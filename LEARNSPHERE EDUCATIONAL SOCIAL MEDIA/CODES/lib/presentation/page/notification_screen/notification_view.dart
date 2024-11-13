import 'dart:async';  // Import for StreamSubscription
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<Map<String, dynamic>> comments = [];
  StreamSubscription? _commentsSubscription; // StreamSubscription to manage Firestore listener

  @override
  void initState() {
    super.initState();
    _fetchComments();
  }

  Future<void> _fetchComments() async {
  String currentUserUid = _auth.currentUser!.uid;

  // Get the current user's username
  DocumentSnapshot userDoc = await _firestore.collection('users').doc(currentUserUid).get();
  
  // Ensure the username exists
  var username = userDoc['username'];
  if (username == null) {
    print("Username not found for user ID: $currentUserUid");
    return; // Exit if no username found
  }
  
  print("Current user: $username");
  
  // Listen for comments on posts by the current user
  _commentsSubscription = _firestore
      .collection('posts')
      .doc(currentUserUid)
      .collection('myPosts')
      .snapshots()
      .listen((snapshot) {
    // Clear previous comments to prevent duplicates
    List<Map<String, dynamic>> newComments = [];

    // Iterate through each post document
    for (var postDoc in snapshot.docs) {
      String postId = postDoc.id;

      // Listen for unread comments on each post
      _firestore
          .collection('comments')
          .where('postId', isEqualTo: postId)
          .where('isRead', isEqualTo: false)
          .where('user', isNotEqualTo: username) // Ensure you have a field 'user' in your comments
          .get() // Change to get() to avoid nested listeners
          .then((commentSnapshot) {
        if (mounted) {
          setState(() {
            newComments.addAll(commentSnapshot.docs.map((doc) {
              return {
                'commentId': doc.id, // This is the document ID
                ...doc.data(),
              };
            }).toList());
            comments = newComments; // Update the comments list
          });
        }
      }).catchError((error) {
        print("Error fetching comments: $error");
      });
    }
  });
}


  Future<void> _markAsRead(String commentId) async {
    if (commentId.isEmpty) {
      print("Comment ID is empty. Cannot mark as read.");
      return; // Exit if commentId is empty
    }

    try {
      // Update the comment's `isRead` status to true
      await _firestore
          .collection('comments') // Ensure this collection name is correct
          .doc(commentId) // Use the valid commentId
          .update({'isRead': true});

      // Remove the comment from the local state
      if (mounted) { // Check if the widget is still mounted
        setState(() {
          comments.removeWhere((comment) => comment['commentId'] == commentId);
        });
      }
    } catch (e) {
      print("Error updating comment: $e");
    }
  }

  @override
  void dispose() {
    // Cancel the Firestore subscription when the widget is disposed
    _commentsSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Color(0xFF1A1F3B).withOpacity(0.95), // Floating window background
          borderRadius: BorderRadius.circular(20), // Rounded corners
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            foregroundColor: Colors.white,
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: const Text("Notifications"),
          ),
          body: comments.isEmpty
              ? const Center(
                  child: Text(
                  "No new notifications",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ))
              : ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final comment = comments[index];
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: ListTile(
                            title: Text(
                              '${comment['user']} commented on your post',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                            ),
                            subtitle: Text(
                              comment['commentText'] ?? 'No Comment Text',
                              style: const TextStyle(color: Colors.white70),
                            ),
                            trailing: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: const Color(0xFF117aca),
                                backgroundColor: Colors.white,
                                shape: const CircleBorder(),
                              ),
                              onPressed: () async {
                                final commentId = comment['commentId'];
                                if (commentId != null && commentId.isNotEmpty) {
                                  await _markAsRead(commentId);
                                } else {
                                  print("Invalid commentId: $commentId");
                                }
                              },
                              child: const Icon(Icons.check),
                            ),
                          ),
                        ),
                        const Divider(),
                      ],
                    );
                  },
                ),
        ),
      ),
    );
  }
}
