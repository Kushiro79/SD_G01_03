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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200], // Set the container background color to purple
                  borderRadius: BorderRadius.circular(20), // Add a rounded corner
                ),
                child: Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 16,
                    color: const Color.fromARGB(255, 0, 0, 0), // Set the text color to white
                  ),
                ),
              ),
            ),
            SizedBox(height: 10), // Add some space between the capsules
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.grey[200], // Set the container background color to a light grey
                borderRadius: BorderRadius.circular(20), // Add a rounded corner
              ),
              child: ListTile(
                leading: Icon(
                  Icons.lock,
                  color: Colors.grey[700], // Set the icon color to a dark grey
                ),
                title: Text(
                  'Account',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black, // Set the text color to black
                  ),
                ),
                subtitle: Text(
                  'Manage your account settings',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600], // Set the text color to a dark grey
                  ),
                ),
                onTap: () => context.router.push(ForgotRouteView()),
              ),
            ),
            SizedBox(height: 10), // Add some space between the capsules
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.grey[200], // Set the container background color to a light grey
                borderRadius: BorderRadius.circular(20), // Add a rounded corner
              ),
              child: ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Colors.grey[700], // Set the icon color to a dark grey
                ),
                title: Text(
                  'Sign out',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black, // Set the text color to black
                  ),
                ),
                subtitle: Text(
                  'Sign out of your account',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600], // Set the text color to a dark grey
                  ),
                ),
                onTap: () async {
                  try {
                    await FirebaseAuth.instance.signOut();
                    print('Log out successfully');
                    context.router.replace(LoginRouteView());
                  } catch (e) {
                    print('Error logging out: ${e.toString()}');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}