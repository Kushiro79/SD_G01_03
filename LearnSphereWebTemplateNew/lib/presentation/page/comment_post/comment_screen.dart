import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CommentScreen extends StatefulWidget {
  final String postId;

  CommentScreen({required this.postId});

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController commentController = TextEditingController();
  String? currentUsername;

  @override
  void initState() {
    super.initState();
    fetchUsername();
  }

  Future<void> fetchUsername() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();
      setState(() {
        currentUsername = userDoc['username'];
      });
    }
  }

  Future<void> submitComment() async {
    String commentText = commentController.text.trim();
    
    if (commentText.isNotEmpty && currentUsername != null) {
      await FirebaseFirestore.instance.collection('comments').add({
        'postId': widget.postId,
        'user': currentUsername,
        'commentText': commentText,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Clear the comment input field
      commentController.clear();

      // Refresh the state to rebuild the StreamBuilder
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Comment cannot be empty')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('comments')
                    .where('postId', isEqualTo: widget.postId)
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No comments yet.'));
                  }

                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var commentDoc = snapshot.data!.docs[index];
                      return ListTile(
                        title: Text(commentDoc['commentText']),
                        subtitle: Text(commentDoc['user']),
                      );
                    },
                  );
                },
              ),
            ),
            TextField(
              controller: commentController,
              decoration: InputDecoration(
                labelText: 'Write your comment...',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: submitComment,
              child: Text('Submit Comment'),
            ),
          ],
        ),
      ),
    );
  }
}
