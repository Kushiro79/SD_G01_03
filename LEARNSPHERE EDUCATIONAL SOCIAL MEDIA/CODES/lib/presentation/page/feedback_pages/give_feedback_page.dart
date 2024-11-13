import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

@RoutePage()
class GiveFeedbackPage extends StatelessWidget {
  GiveFeedbackPage({super.key});

  // TextEditingController to capture feedback input
  final TextEditingController _feedbackController = TextEditingController();

  // Function to submit feedback to Firestore
  Future<void> submitFeedback(BuildContext context) async {
    String feedback = _feedbackController.text.trim();

    // Check if user is authenticated
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('You need to be logged in to submit feedback.')),
    );
    return;
  }

    if (feedback.isNotEmpty) {
      try {
        // Add feedback to Firestore
        await FirebaseFirestore.instance.collection('feedbacks').add({
          'uid': FirebaseAuth.instance.currentUser?.uid, // User ID
          'feedback': feedback, // The feedback text
          'timestamp': FieldValue.serverTimestamp(), // Add a timestamp for better sorting
        });

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Thank you for your feedback!')),
        );

        // Clear the feedback form
        _feedbackController.clear();
      } catch (e) {
        print('Error submitting feedback: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error submitting feedback. Please try again.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your feedback')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1F3B),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Give Feedback' , style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),),
            const SizedBox(height: 16.0),
            const Text(
              'We would love to hear your thoughts!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 16.0),

            // Feedback input field
            TextField(
              style: const TextStyle(color: Colors.white),
              controller: _feedbackController,
              maxLines: 5,
              decoration: const InputDecoration(
                border:  OutlineInputBorder(),
                hintText: 'Enter your feedback here...',
                hintStyle: TextStyle(color: Colors.white54),
              ),
            ),
            const SizedBox(height: 16.0),

            // Submit button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF117aca), // Button color
              ),
              onPressed: () {
                // Handle feedback submission
                submitFeedback(context); // Call the function to submit feedback
              },
              child: const Text('Submit', style: TextStyle(color:  Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}