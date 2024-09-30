import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:auto_route/auto_route.dart';

// Page for viewing feedback given by users
@RoutePage()
class ViewFeedbackPage extends StatelessWidget {
  const ViewFeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Feedback'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('feedbacks')
            .orderBy('timestamp', descending: true) // Sort by timestamp
            .snapshots(), // Listen for real-time updates
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // Loading indicator
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}')); // Error message
          }

          final feedbackDocs = snapshot.data?.docs ?? [];

          if (feedbackDocs.isEmpty) {
            return const Center(child: Text('No feedback available.')); // No feedback message
          }

          return ListView.builder(
            itemCount: feedbackDocs.length,
            itemBuilder: (context, index) {
              var feedbackData = feedbackDocs[index];
              String feedbackMessage = feedbackData['feedback'] ?? 'No feedback';
              String userId = feedbackData['uid'] ?? 'Anonymous';
              Timestamp? timestamp = feedbackData['timestamp'];

              // Convert Firestore Timestamp to DateTime
              DateTime? feedbackTime = timestamp?.toDate();

              return ListTile(
                title: Text(feedbackMessage), // Feedback text
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('UID: $userId'), // User ID
                    if (feedbackTime != null)
                      Text('Submitted on: ${feedbackTime.toLocal()}'), // Submission time
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}