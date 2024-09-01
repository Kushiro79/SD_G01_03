import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';


import '../../routes/app_router.dart';
import '../../config/app_contents.dart';
import '../../config/common_button.dart';
import '../../config/common_textfield.dart';
import '../../config/app_color.dart';
import '../login_screen/views/login_screen_view.dart';




@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

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
              onTap: () => context.router.push( ForgotRouteView())
            ),
            ListTile(
              leading:const Icon(Icons.logout),
              title: const Text('Log Out'),
              onTap: () async {
                try {
                await FirebaseAuth.instance.signOut();
                print('Log out successfully');
                context.router.replace( LoginRouteView());
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
