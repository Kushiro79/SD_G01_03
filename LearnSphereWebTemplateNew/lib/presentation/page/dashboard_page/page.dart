import 'package:auto_route/auto_route.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

@RoutePage()
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  Future<int> getAmountofStaffAndAdmin() async {
    try {
      final staffSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('role', whereIn: ['staff', 'admin'])
          .get();
      return staffSnapshot.docs.length;
    } catch (e) {
      print('Error in get staff & admin: $e');
      return 0;
    }
  }

  Future<int> getUserRegisteredLastMonth() async {
    try {
      final now = DateTime.now();
      final lastMonth = DateTime(now.year, now.month == 1 ? 12 : now.month - 1, now.day);
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

  Future<double> getAveragePostsPerUser() async {
    try {
      final postsSnapshot = await FirebaseFirestore.instance.collection('posts').get();
      final userPostCounts = <String, int>{};

      for (var post in postsSnapshot.docs) {
        final username = post['username'];
        userPostCounts[username] = (userPostCounts[username] ?? 0) + 1;
      }

      final totalUsers = userPostCounts.keys.length;
      if (totalUsers == 0) return 0.0;

      final totalPosts = userPostCounts.values.reduce((a, b) => a + b);
      return totalPosts / totalUsers;
    } catch (e) {
      print('Error in get average posts: $e');
      return 0.0;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
        'Dashboard',
        style: TextStyle(
          fontSize: 24, // Bigger font size
          fontWeight: FontWeight.bold, // Bold text
        ),
        )
      ),
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/background.jpg',
              fit: BoxFit.cover, // Ensures the image fills the entire screen
            ),
          ),
          // Foreground content
          FutureBuilder(
            future: Future.wait([
              getAmountofStaffAndAdmin(),
              getUserRegisteredLastMonth(),
              getAveragePostsPerUser(),
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
              final averagePostsPerUser = data[2] as double;
              final deviceUsage = data[3] as Map<String, int>;
              final totalActiveUsers = data[4] as int;

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5), // Increased transparency
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
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
    );
  }

  Widget _buildMetricCard({required String title, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(value, style: const TextStyle(fontSize: 24)),
      ],
    );
  }

  Widget _buildDeviceUsageChart(Map<String, int> deviceUsage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Device Usage', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(
          height: 200,
          child: PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(
                  value: deviceUsage['Android']!.toDouble() ?? 0.0,
                  title: 'Android: ${deviceUsage['Android'] ?? 0}',
                  color: const Color.fromARGB(255, 168, 229, 169),
                ),
                PieChartSectionData(
                  value: deviceUsage['Web']!.toDouble() ?? 0.0,
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
