import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewReportPage extends StatefulWidget {
  const ViewReportPage({Key? key}) : super(key: key);

  @override
  _ViewReportPageState createState() => _ViewReportPageState();
}

class _ViewReportPageState extends State<ViewReportPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> reportedPosts = [];
  List<Map<String, dynamic>> reportedDiscussions = [];
  List<Map<String, dynamic>> reportedUsers = [];

  @override
  void initState() {
    super.initState();
    fetchAllReports();
  }

  Future<void> fetchReportedPosts() async {
    final snapshot = await firestore.collection('report_post').get();
    setState(() {
      reportedPosts = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    });
  }

  Future<void> fetchReportedDiscussions() async {
    final snapshot = await firestore.collection('report_discussion').get();
    setState(() {
      reportedDiscussions = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    });
  }

  Future<void> fetchReportedUsers() async {
    final snapshot = await firestore.collection('report_user').get();
    setState(() {
      reportedUsers = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    });
  }

  Future<void> fetchAllReports() async {
    await fetchReportedPosts();
    await fetchReportedDiscussions();
    await fetchReportedUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Report'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle(context, 'Reported Users'),
              _buildReportHeaders(['Username', 'Reason', 'Date Reported', 'Status']),
              if (reportedUsers.isEmpty)
                const Text('No reported users found.'),
              ...reportedUsers.map((user) {
                return _buildReportRow(
                  user['username'] ?? 'Unknown User',
                  user['reason'] ?? 'N/A',
                  user['reportedAt']?.toDate().toString() ?? 'N/A',
                  'Pending',
                );
              }).toList(),

              const Divider(height: 30, thickness: 1),

              _buildSectionTitle(context, 'Reported Posts'),
              _buildReportHeaders(['Post Title', 'Reported By', 'Date Reported', 'Status']),
              if (reportedPosts.isEmpty)
                const Text('No reported posts found.'),
              ...reportedPosts.map((post) {
                return _buildReportRow(
                  post['postTitle'] ?? 'Unknown Post',
                  post['userId'] ?? 'Unknown User',
                  post['timestamp']?.toDate().toString() ?? 'N/A',
                  'Pending',
                );
              }).toList(),

              const Divider(height: 30, thickness: 1),

              _buildSectionTitle(context, 'Reported Discussions'),
              _buildReportHeaders(['Discussion Topic', 'Reported By', 'Date Reported', 'Status']),
              if (reportedDiscussions.isEmpty)
                const Text('No reported discussions found.'),
              ...reportedDiscussions.map((discussion) {
                return _buildReportRow(
                  discussion['messageId'] ?? 'Unknown Discussion',
                  discussion['username'] ?? 'Unknown User',
                  discussion['reportedAt']?.toDate().toString() ?? 'N/A',
                  'Pending',
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to display section titles
  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  // Flexible headers with custom titles
  Widget _buildReportHeaders(List<String> headers) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: headers
          .map((title) => Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ))
          .toList(),
    );
  }

  // Row builder for each report entry
  Widget _buildReportRow(String title1, String title2, String title3, String title4) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(title1, textAlign: TextAlign.center)),
          Expanded(child: Text(title2, textAlign: TextAlign.center)),
          Expanded(child: Text(title3, textAlign: TextAlign.center)),
          Expanded(child: Text(title4, textAlign: TextAlign.center)),
        ],
      ),
    );
  }
}
