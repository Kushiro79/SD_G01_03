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

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal, // Allow horizontal scrolling
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              margin: const EdgeInsets.all(16.0), // Margin around the container
              padding: const EdgeInsets.all(16.0), // Padding inside the container
              decoration: BoxDecoration(
                color: Colors.white, // Background color of the container
                borderRadius: BorderRadius.circular(16.0), // Rounded corners
                border: Border.all(color: Colors.grey.shade300), // Border color
              ),
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('UID')),
                  DataColumn(label: Text('Feedback')),
                  DataColumn(label: Text('Submitted On')),
                ],
                rows: feedbackDocs.map((feedbackData) {
                  String feedbackMessage = feedbackData['feedback'] ?? 'No feedback';
                  String userId = feedbackData['uid'] ?? 'Anonymous';
                  Timestamp? timestamp = feedbackData['timestamp'];

                  // Convert Firestore Timestamp to DateTime
                  DateTime? feedbackTime = timestamp?.toDate();

                  return DataRow(cells: [
                    DataCell(Text(userId)), // User ID
                    DataCell(Text(feedbackMessage)), // Feedback message
                    DataCell(Text(feedbackTime != null
                        ? feedbackTime.toLocal().toString()
                        : 'Unknown')), // Submission time
                  ]);
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
