import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateDiscussionPage extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color:
            Color(0xFF1A1F3B).withOpacity(0.95), // Floating window background
        borderRadius: BorderRadius.circular(20), // Rounded corners
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFF1A1F3B),
        appBar: AppBar(
          title:
              Text('Create Discussion', style: TextStyle(color: Colors.white)),
          backgroundColor:
              const Color(0xFF1A1F3B), // Match the page background color
          iconTheme: IconThemeData(
              color: Colors.white), // Set icons (like back button) to white
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20 , horizontal: 10),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(color: Colors.white), // Label color
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white), // Border color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.white), // Border color when focused
                  ),
                ),
                style: const TextStyle(color: Colors.white), // Input text color
              ),
              const SizedBox(height: 40), // Add space between the fields
              TextField(
                maxLines: 5,
                controller: contentController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  labelStyle: TextStyle(color: Colors.white), // Label color
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white), // Border color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.white), // Border color when focused
                  ),
                ),
                style: TextStyle(color: Colors.white), // Input text color
              ),
              SizedBox(height: 40), // Add space between the form and the button
              SizedBox(
                width: 300, // Make the button take full width
                height: 50, // Increase the button height
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF117aca), // Set button color to cyan
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(30), // Add slight rounding
                    ),
                  ),
                  onPressed: () {
                    // Implement logic to create the discussion
                    createDiscussion(
                        titleController.text, contentController.text, context);
                  },
                  child: Text(
                    'Create Discussion',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18), // Set text color and size
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> createDiscussion(
      String title, String content, BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    //check from the users collection the current user's username
    DocumentSnapshot userSnapshot =
        await firestore.collection('users').doc(auth.currentUser!.uid).get();
    String username = userSnapshot['username'];

    if (title.isEmpty || content.isEmpty) {
      showAlertDialog(
          context, 'Error', 'Title and content cannot be empty.', true);
      return;
    }

    try {
      await firestore.collection('discussions').add({
        'title': title,
        'content': content,
        'createdAt': FieldValue.serverTimestamp(), // Timestamp
        'createdBy': username,
      });

      print('Discussion Created: Title: $title, Content: $content');

      // Show success message and navigate back to the discussion page
      showAlertDialog(
          context, 'Success', 'Discussion created successfully!', false);

      // Auto redirect to the previous discussion page
      Get.back();
    } catch (e) {
      print('Error creating discussion: $e');
      // Show error alert
      //showAlertDialog(context, 'Error', 'Failed to create discussion.', true);
    }
  }

  // Function to display AlertDialog
  void showAlertDialog(
      BuildContext context, String title, String message, bool isError) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title, style: TextStyle(color: Colors.white)),
          content: Text(message, style: TextStyle(color: Colors.white)),
          backgroundColor:
              Colors.black87, // Set dialog background to match the page
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the alert
                if (!isError) {
                  // If it's a success, go back to the discussion page
                  Navigator.of(context).pop();
                }
              },
              child: Text('OK', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
