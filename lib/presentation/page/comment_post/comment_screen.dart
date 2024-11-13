import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../Home_page/home_controller.dart';

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
    HomeController homeController = Get.put(HomeController());
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
                        trailing: ElevatedButton.icon(
                  onPressed: () {
                    homeController.checkUserCertificate(commentDoc['uid']);
                    // Show alert dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor:
                              const Color(0xFF1A1F3B), // Dialog background
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          title: const Text(
                            'Verified Qualifications',
                            style: TextStyle(color: Colors.white),
                          ),
                          content: Obx(() {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  children: [
                                    Icon(
                                      Icons.verified_user,
                                      color: Colors.greenAccent,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      'Verified Qualifications',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                if (homeController.certificates.isEmpty)
                                  const Text(
                                    'No certificates found.',
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                ...homeController.certificates
                                    .map((certificate) {
                                  return ListTile(
                                    title: Text(
                                      certificate['fieldOfStudy'] ??
                                          'Unknown Field of Study',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          certificate['levelOfEducation'] ??
                                              'Unknown Level of Education',
                                          style: TextStyle(
                                            color: homeController
                                                .getColorBasedOnContent(
                                                    certificate[
                                                        'levelOfEducation']),
                                          ),
                                        ),
                                        Text(
                                          certificate['institutionName'] ??
                                              'Unknown Institution',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ],
                            );
                          }),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pop(); // Closes the dialog
                              },
                              child: const Text(
                                'Close',
                                style: TextStyle(color: Color(0xFF117aca)),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.shield_rounded),
                  label: const SizedBox
                      .shrink(), // Hide label for a circular button
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(16),
                    backgroundColor: const Color(0xFF1A1F3B),
                    foregroundColor: const Color(0xFF117aca),
                  ),
                ),
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
