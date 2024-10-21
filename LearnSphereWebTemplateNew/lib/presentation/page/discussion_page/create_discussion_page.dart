import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateDiscussionPage extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

   final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Discussion'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: contentController,
              decoration: InputDecoration(labelText: 'Content'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement logic to create the discussion
                createDiscussion(titleController.text, contentController.text,context);
              },
              child: Text('Create Discussion'),
            ),
          ],
        ),
      ),
    );
  }

   Future<void> createDiscussion(String title, String content, BuildContext context) async {
    if (title.isEmpty || content.isEmpty) {
     showAlertDialog(context, 'Error', 'Title and content cannot be empty.', true);
      return;
    }

    try {
      await firestore.collection('discussions').add({
        'title': title,
        'content': content,
        'createdAt': FieldValue.serverTimestamp(), // Timestamp
      });

      print('Discussion Created: Title: $title, Content: $content');
      
      // Show success message and navigate back to the discussion page
      showAlertDialog(context, 'Success', 'Discussion created successfully!', false);
      
      // Auto redirect to the previous discussion page
      Get.back();
    } catch (e) {
      print('Error creating discussion: $e');
      // Show error alert
      //showAlertDialog(context, 'Error', 'Failed to create discussion.', true);
    }
  }


// Function to display AlertDialog
  void showAlertDialog(BuildContext context, String title, String message, bool isError) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the alert
                if (!isError) {
                  // If it's a success, go back to the discussion page
                  Navigator.of(context).pop();
                }
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}