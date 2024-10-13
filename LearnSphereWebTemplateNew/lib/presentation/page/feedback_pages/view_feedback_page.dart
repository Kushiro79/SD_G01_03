import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:auto_route/auto_route.dart';
import 'feedback_controller.dart';

@RoutePage()
class ViewFeedbackPage extends GetView<ViewFeedbackController> {
  ViewFeedbackPage({super.key});

  // Initialize the controller
  final ViewFeedbackController feedbackController =
      Get.put(ViewFeedbackController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text(
        'View Feedback',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      Obx(() {
        if (feedbackController.feedbackDocs.isEmpty) {
          return const Center(
              child: CircularProgressIndicator()); // Loading indicator
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal, // Enable horizontal scrolling
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width *
                  0.8, // Adjust width to 80% of screen
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical, // Enable vertical scrolling
              child: Container(
                margin:
                    const EdgeInsets.all(16.0), // Margin around the container
                padding:
                    const EdgeInsets.all(16.0), // Padding inside the container
                decoration: BoxDecoration(
                  color: Colors.white, // Background color of the container
                  borderRadius: BorderRadius.circular(16.0), // Rounded corners
                  border:
                      Border.all(color: Colors.grey.shade300), // Border color
                ),
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('UID')),
                    DataColumn(label: Text('Feedback')),
                    DataColumn(label: Text('Submitted On')),
                  ],
                  rows: feedbackController.feedbackDocs.map((feedbackData) {
                    String feedbackMessage =
                        feedbackData['feedback'] ?? 'No feedback';
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
            ),
          ),
        );
      }),
    ])));
  }
}
