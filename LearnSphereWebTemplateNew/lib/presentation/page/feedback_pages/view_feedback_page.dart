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
      backgroundColor: Colors.transparent,
        body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text(
        'View Feedback',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
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
                  color: Colors.black.withOpacity(0.13), // Background color of the container
                  borderRadius: BorderRadius.circular(16.0), // Rounded corners
                ),
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('UID', style: TextStyle(color: Colors.white))),
                    DataColumn(label: Text('Feedback', style: TextStyle(color: Colors.white))),
                    DataColumn(label: Text('Submitted On', style: TextStyle(color: Colors.white))),
                  ],
                  rows: feedbackController.feedbackDocs.map((feedbackData) {
                    String feedbackMessage =
                        feedbackData['feedback'] ?? 'No feedback';
                    String userId = feedbackData['uid'] ?? 'Anonymous';
                    Timestamp? timestamp = feedbackData['timestamp'];

                    // Convert Firestore Timestamp to DateTime
                    DateTime? feedbackTime = timestamp?.toDate();

                    return DataRow(cells: [
                      DataCell(Text(userId, style: TextStyle(color: Colors.white))), // User ID
                      DataCell(Text(feedbackMessage, style: TextStyle(color: Colors.white))), // Feedback message
                      DataCell(Text(feedbackTime != null
                          ? feedbackTime.toLocal().toString()
                          : 'Unknown', style: TextStyle(color: Colors.white))), // Submission time
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
