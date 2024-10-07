import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
                            'Profile ',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          subtitle: Text(
                            'View and Edit your profile details',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          onTap: () => context.router.push(ProfileRouteRoute()),
                        ),
                        const Divider(), // Line separator
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
