import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../routes/app_router.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Settings content
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                double containerWidth = constraints.maxWidth * 0.9;

                return Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: containerWidth,
                    padding: const EdgeInsets.all(10.0),
                    margin: const EdgeInsets.only(top: 20), // Margin to push it down a bit
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.6), // More transparent
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // Box ends after content
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Title
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Settings',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Divider(), // Line separator
                        // Account section
                        ListTile(
                          leading: Icon(
                            Icons.lock,
                            color: Colors.grey[700],
                          ),
                          title: const Text(
                            'Edit Profile ',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          subtitle: Text(
                            'Edit your profile details',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          onTap: () => context.router.push(EditProfileRoute()),
                        ),
                        const Divider(), // Line separator
                        //Delete Account
                        ListTile(
                          leading: Icon(
                            Icons.delete,
                            color: Colors.grey[700],
                          ),
                          title: const Text(
                            'Delete Account',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          subtitle: Text(
                            'Delete your account permanently',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          onTap: () async {
                            try {
                              final user = FirebaseAuth.instance.currentUser;

                              if (user != null) {
                                // Show confirmation dialog before proceeding
                                bool confirmed = await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Confirm Deletion'),
                                      content: const Text(
                                          'Are you sure you want to delete your account? This action cannot be undone.'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(false),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(true),
                                          child: const Text('Delete'),
                                        ),
                                      ],
                                    );
                                  },
                                );

                                if (confirmed) {
                                  await user.delete(); // Delete the Firebase account

                                  // Show success message
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Account deleted successfully'),
                                      duration: Duration(seconds: 2), // Display for 2 seconds
                                    ),
                                  );

                                  // Optionally: Remove user data from Firestore or any other database
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(user.uid)
                                      .delete();

                                  // Wait for the SnackBar to show before navigating away
                                  await Future.delayed(const Duration(seconds: 2));

                                  // Navigate to the login page after showing the message
                                  context.router.replace(LoginRouteView());
                                }
                              }
                            } catch (e) {
                              print('Error deleting account: $e');
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Error deleting account. Please try again.')),
                              );
                            }
                          },
                        ),
                        const Divider(),
                        // Sign out section
                        ListTile(
                          leading: Icon(
                            Icons.logout,
                            color: Colors.grey[700],
                          ),
                          title: const Text(
                            'Sign out',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          subtitle: Text(
                            'Sign out of your account',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          onTap: () async {
                            try {
                              await FirebaseAuth.instance.signOut();
                              Get.reset(); // Reset all GetX controllers
                              print('Log out successfully');
                              context.router.replace(LoginRouteView());
                            } catch (e) {
                              print('Error logging out: ${e.toString()}');
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  
}
