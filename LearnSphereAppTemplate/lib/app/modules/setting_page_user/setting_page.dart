import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../login_screen/views/login_screen_view.dart';
import '../forgot_screen/views/forgot_screen_view.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.lock),
              title: const Text('Reset Password'),
              onTap: () => Get.to(() => const ForgotScreenView()),
            ),
            ListTile(
              leading:const Icon(Icons.logout),
              title: const Text('Log Out'),
              onTap: () async {
                try {
                await FirebaseAuth.instance.signOut();
                print('Log out successfully');
                Get.offAll(() => LoginScreenView());
                } catch (e) {
                  print('Error logging out: ${e.toString()}');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
