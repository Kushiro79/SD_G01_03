import 'package:firebase_core/firebase_core.dart';
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
    var uid = FirebaseAuth.instance.currentUser!.uid;

    if (commentText.isNotEmpty && currentUsername != null) {
      await FirebaseFirestore.instance.collection('comments').add({
        'postId': widget.postId,
        'user': currentUsername,
        'commentText': commentText,
        'timestamp': FieldValue.serverTimestamp(),
        'uid': uid,
        'isRead' : false,
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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFF1A1F3B).withOpacity(0.90),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            AppBar(
              backgroundColor: const Color(0xFF1A1F3B).withOpacity(0.90),
              title: const Text(
                'Comments',
                style: TextStyle(color: Colors.white),
              ),
              foregroundColor: Colors.white,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('comments')
                    .where('postId', isEqualTo: widget.postId)
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                        child: Text(
                      'No comments yet.',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ));
                  }

                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var commentDoc = snapshot.data!.docs[index];
                      return ListTile(
                        title: Text(commentDoc['commentText'], style: const TextStyle(color: Colors.white)),
                        subtitle: Text(commentDoc['user'], style: const TextStyle(color: Colors.white60),),
                      );
                    },
                  );
                },
              ),
            ),
            TextField(
              controller: commentController,
              decoration: const InputDecoration(
                labelText: 'Write your comment...',
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color:  Color(0xFF117aca))
                ),
              ),
              style: const TextStyle(color: Colors.white),
              minLines: 1,
              maxLines: 5,
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF117aca),
                  foregroundColor: const Color(0xFF1A1F3B),
                ),
                onPressed: submitComment,
                child: Text('Submit Comment'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
