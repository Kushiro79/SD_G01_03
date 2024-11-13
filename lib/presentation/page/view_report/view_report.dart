import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

@RoutePage()
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
      reportedPosts = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    });
  }

  Future<void> fetchReportedDiscussions() async {
    final snapshot = await firestore.collection('report_discussion').get();
    setState(() {
      reportedDiscussions = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    });
  }

  Future<void> fetchReportedUsers() async {
    final snapshot = await firestore.collection('report_user').get();
    setState(() {
      reportedUsers = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
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
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'View Report',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              _buildSectionTitle(context, 'Reported Users'),
              reportedUsers.isEmpty
                  ? const Text('No reported users found.',
                      style: TextStyle(color: Colors.white))
                  : _buildDataTable(
                      headers: [
                        'Reported By',
                        'Username',
                        'Reason',
                        'Date Reported',
                      ],
                      rows: reportedUsers.map((user) {
                        return DataRow(cells: [
                          DataCell(Text(user['reporterUid'] ?? 'Unknown User',
                              style: TextStyle(color: Colors.white))),
                          DataCell(Text(user['uid'] ?? 'Unknown User',
                              style: TextStyle(color: Colors.white))),
                          DataCell(Text(user['reason'] ?? 'N/A',
                              style: TextStyle(color: Colors.white))),
                          DataCell(Text(
                              user['reportedAt']?.toDate().toString() ?? 'N/A',
                              style: TextStyle(color: Colors.white))),
                        ]);
                      }).toList(),
                    ),
              const Divider(height: 30, thickness: 1),
              _buildSectionTitle(context, 'Reported Posts'),
              reportedPosts.isEmpty
                  ? const Text('No reported posts found.',
                      style: TextStyle(color: Colors.white))
                  : _buildDataTable(
                      headers: [
                        'Reported By',
                        'Post ID',
                        'Reason',
                        'Date Reported',
                      ],
                      rows: reportedPosts.map((post) {
                        return DataRow(cells: [
                          DataCell(Text(post['userId'] ?? 'Unknown User',
                              style: TextStyle(color: Colors.white))),
                          DataCell(Text(post['postId'] ?? 'Unknown Post',
                              style: TextStyle(color: Colors.white))),
                          DataCell(Text(post['reason'] ?? 'N/A',
                              style: TextStyle(color: Colors.white))),
                          DataCell(Text(
                              post['timestamp']?.toDate().toString() ?? 'N/A',
                              style: TextStyle(color: Colors.white))),
                        ]);
                      }).toList(),
                    ),
              const Divider(height: 30, thickness: 1),
              _buildSectionTitle(context, 'Reported Discussions'),
              reportedDiscussions.isEmpty
                  ? const Text('No reported discussions found.',
                      style: TextStyle(color: Colors.white))
                  : _buildDataTable(
                      headers: [
                        'Discussion ID',
                        'Reported By',
                        'Reason',
                        'Date Reported',
                      ],
                      rows: reportedDiscussions.map((discussion) {
                        return DataRow(cells: [
                          DataCell(Text(
                              discussion['messageId'] ?? 'Unknown Discussion',
                              style: TextStyle(color: Colors.white))),
                          DataCell(Text(
                              discussion['username'] ?? 'Unknown User',
                              style: TextStyle(color: Colors.white))),
                          DataCell(Text(discussion['reason'] ?? 'N/A',
                              style: TextStyle(color: Colors.white))),
                          DataCell(Text(
                              discussion['reportedAt']?.toDate().toString() ??
                                  'N/A',
                              style: TextStyle(color: Colors.white))),
                        ]);
                      }).toList(),
                    ),
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
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }

  // DataTable builder function for report entries
  Widget _buildDataTable(
      {required List<String> headers, required List<DataRow> rows}) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth:MediaQuery.of(context).size.width * 0.8,
),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          padding: const EdgeInsets.all(16.0), // Consistent padding
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.13),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: DataTable(
            columns: headers
                .map((header) => DataColumn(
                    label: Text(header,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold))))
                .toList(),
            rows: rows,
            // Make background transparent
            dataRowColor: WidgetStateColor.resolveWith(
                (states) => Colors.transparent),
            headingRowColor: WidgetStateColor.resolveWith(
                (states) => Colors.transparent),
            horizontalMargin: 8,
            dividerThickness: 0, // Remove row dividers
          ),
        ),
      ),
    );
  }
}
