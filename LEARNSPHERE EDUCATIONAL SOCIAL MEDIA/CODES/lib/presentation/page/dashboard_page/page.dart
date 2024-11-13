import 'package:auto_route/auto_route.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import  'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

@RoutePage()
class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<int> getAmountofStaffAndAdmin() async {
    try {
      final staffSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('role', whereIn: ['staff', 'admin']).get();
      return staffSnapshot.docs.length;
    } catch (e) {
      print('Error in get staff & admin: $e');
      return 0;
    }
  }

  Future<int> getUserRegisteredLastMonth() async {
    try {
      final now = DateTime.now();
      final lastMonth =
          DateTime(now.year, now.month == 1 ? 12 : now.month - 1, now.day);
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('registrationDate', isGreaterThan: lastMonth)
          .get();
      return snapshot.docs.length;
    } catch (e) {
      print('Error in get user registered: $e');
      return 0;
    }
  }

  Future<double> fetchAveragePostCountPerUser() async {
  try {
    // Get all user documents from 'users' collection
    final userSnapshots = await _firestore.collection('users').get();

    // Use Future.wait to fetch all user posts concurrently
    final futures = userSnapshots.docs.map((userDoc) async {
      final userId = userDoc.id;

      // Get all posts for the user in 'myPosts' subcollection
      final userPostsSnapshot = await _firestore
          .collection('posts')
          .doc(userId)
          .collection('myPosts')
          .get();

      return userPostsSnapshot.size; // Return the count of posts for this user
    });

    // Wait for all futures to complete and collect the post counts
    final postCounts = await Future.wait(futures);
    final totalPosts = postCounts.reduce((a, b) => a + b); // Sum all counts
    final userCount = userSnapshots.docs.length; // Count of users

    // Calculate average, handle division by zero case
    final averagePosts = userCount > 0 ? totalPosts / userCount : 0.0;

    print('Total Posts: $totalPosts');
    print('User Count: $userCount');
    print('Average Posts per User: $averagePosts');
    
    return averagePosts; // Return the average number of posts per user
  } catch (e) {
    print('Error fetching average post count per user: $e');
    return 0.0; // Return 0 or handle the error as needed
  }
}



  Future<Map<String, int>> getUserDeviceUsage() async {
    try {
      final androidSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('device', isEqualTo: 'Android')
          .get();
      final webSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('device', isEqualTo: 'Web')
          .get();
      return {
        'Android': androidSnapshot.docs.length,
        'Web': webSnapshot.docs.length,
      };
    } catch (e) {
      print('Error in get user device usage: $e');
      return {
        'Android': 0,
        'Web': 0,
      };
    }
  }

  Future<int> getTotalActiveUsers() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('active', isEqualTo: true)
          .get();
      return snapshot.docs.length;
    } catch (e) {
      print('Error in get total active users: $e');
      return 0;
    }
  }

  Future<int> fetchTotalPostCount() async {
  try {
    // Get all user IDs from 'posts' collection
    final userSnapshots = await _firestore.collection('users').get();
    
    // Use Future.wait to fetch all user posts concurrently
    final futures = userSnapshots.docs.map((userDoc) async {
      final userId = userDoc.id;

      // Get all posts for the user in 'myPosts' subcollection
      final userPostsSnapshot = await _firestore
          .collection('posts')
          .doc(userId)
          .collection('myPosts')
          .get();
      
      return userPostsSnapshot.size; // Return the count of posts for this user
    });

    // Wait for all futures to complete and sum the results
    final postCounts = await Future.wait(futures);
    final totalPosts = postCounts.reduce((a, b) => a + b); // Sum all counts

    print(totalPosts);
    return totalPosts;
  } catch (e) {
    print('Error fetching total post count: $e');
    return 0; // Return 0 or handle the error as needed
  }
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
              // Title
              const Text(
                'Dashboard',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 16),
              // Foreground content
              FutureBuilder(
                future: Future.wait([
                  getAmountofStaffAndAdmin(),
                  getUserRegisteredLastMonth(),
                  fetchTotalPostCount(),
                  fetchAveragePostCountPerUser(),
                  getUserDeviceUsage(),
                  getTotalActiveUsers(),
                ]),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
          
                    final data = snapshot.data as List<dynamic>;
                    final amountofStaffAndAdmin = data[0] as int;
                    final userRegisteredLastMonth = data[1] as int;
                    final totalPost = data[2] as int; // This should be the total post count
                    final averagePostsPerUser = data[3] as double; // This is correct as it returns double
                    final deviceUsage = data[4] as Map<String, int>; // Change index from 3 to 4
                    final totalActiveUsers = data[5] as int;

                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.black
                              .withOpacity(0.13), // Increased transparency
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildMetricCard(
                              title: 'Staff and Admin',
                              value: amountofStaffAndAdmin.toString(),
                              
                            ),
                            const Divider(height: 24),
                            _buildMetricCard(
                              title: 'Users Registered Last Month',
                              value: userRegisteredLastMonth.toString(),
                            ),
                            const Divider(height: 24),
                            _buildMetricCard(
                              title: 'Total Posts',
                              value: totalPost.toString(),
                            ),
                            const Divider(height: 24),
                            _buildMetricCard(
                              title: 'Avg. Posts per User',
                              value: averagePostsPerUser.toStringAsFixed(2),
                            ),
                            const Divider(height: 24),
                            _buildDeviceUsageChart(deviceUsage),
                            const Divider(height: 24),
                            _buildMetricCard(
                              title: 'Total Active Users',
                              value: totalActiveUsers.toString(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricCard({required String title, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        const SizedBox(height: 8),
        Text(value, style: const TextStyle(fontSize: 24, color: Colors.white)),
      ],
    );
  }

  Widget _buildDeviceUsageChart(Map<String, int> deviceUsage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Device Usage',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        SizedBox(
          height: 200,
          child: PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(
                  value: deviceUsage['Android']!.toDouble(),
                  title: 'Android: ${deviceUsage['Android'] ?? 0}',
                  color: const Color.fromARGB(255, 168, 229, 169),
                ),
                PieChartSectionData(
                  value: deviceUsage['Web']!.toDouble(),
                  title: 'Web: ${deviceUsage['Web'] ?? 0}',
                  color: const Color.fromARGB(255, 125, 197, 255),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
