import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_router.dart';
import 'controllers/edit_profile_controller.dart';
import 'controllers/proflie_screen_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';

@RoutePage()
class EditProfilePage extends GetView<EditProfileController> {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditProfileController());

    // To control whether to show editable fields or static text
    final isEditing = false.obs;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontFamily: 'Urbanist-semibold',
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          SizedBox(
            height: 24,
            width: 24,
            child: Image.asset('assets/setting-4.png'),
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Left side with profile image and static info (from Firebase)
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(() {
                    String profileImageUrl = controller.profileImageUrl.value;
                    return CircleAvatar(
                      radius: 50,
                      backgroundImage: profileImageUrl.isNotEmpty
                          ? NetworkImage(profileImageUrl) as ImageProvider
                          : const AssetImage('assets/default_profile.png'),
                    );
                  }),
                  SizedBox(height: 16),
                  Obx(() {
                    String username = controller.username.value;
                    return Text(
                      username,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }),
                  SizedBox(height: 8),
                  Obx(() {
                    String email = controller.email.value;
                    return Text(
                      email,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    );
                  }),
                  SizedBox(height: 16),
                  Obx(() {
                    String certificate = controller.certificate.value;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.verified,
                          color: Colors.grey,
                          size: 28,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Certified User',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    );
                  }),
                  // Logout button
                Spacer(), // Pushes the button to the bottom
                      ElevatedButton.icon(
                        label: Text("Logout"),
                      onPressed: () async {
                      try {
                      await controller.logout(); // Call your logout method here
                      print('Log out successfully');
                      context.router.replace(LoginRouteView()); // Adjust the route as needed
                    } catch (e) {
                    print('Error logging out: ${e.toString()}');
                    }
                      },
                      ),
                ],
              ),
            ),

            // Vertical Divider between the sections
            VerticalDivider(
              color: Colors.grey, // Line color
              thickness: 1.0, // Line thickness
              width: 40, // Space between the sections
            ),

            // Right side with toggle between static text and editable fields
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Obx(() {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Toggle between static data and editable fields
                      if (!isEditing.value) ...[
                        // Static Text for Display
                        Text('Username: ${controller.username.value}'),
                        SizedBox(height: 16),
                        Text('Email: ${controller.email.value}'),
                        SizedBox(height: 16),
                        Text('Credentials: ${controller.credentials.value}'),
                        SizedBox(height: 32),

                        // Button to enable editing
                        ElevatedButton.icon(
                          onPressed: () {
                            isEditing.value = true; // Switch to editing mode
                          },
                          icon: Icon(Icons.edit),
                          label: Text('Change'),
                        ),
                      ] else ...[
                        // Editable Fields for Username, Email, and Credentials
                        TextFormField(
                          initialValue: controller.username.value,
                          decoration: InputDecoration(labelText: 'Username'),
                          onChanged: (value) {
                            controller.username.value = value;
                          },
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          initialValue: controller.email.value,
                          decoration: InputDecoration(labelText: 'Email'),
                          onChanged: (value) {
                            controller.email.value = value;
                          },
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          initialValue: controller.credentials.value,
                          decoration: InputDecoration(labelText: 'Credentials'),
                          onChanged: (value) {
                            controller.credentials.value = value;
                          },
                        ),
                        SizedBox(height: 32),

                        // Save Changes button
                        ElevatedButton(
                          onPressed: () {
                            controller.saveProfile(); // Save changes to Firebase
                            isEditing.value = false; // Switch back to display mode
                          },
                          child: Text('Save Changes'),
                        ),
                      ],
                      Spacer(), // Pushes the Forgot Password button to the bottom
                      ElevatedButton.icon(
                        label: Text("Forgot Password"),
                      onPressed: () {
                      // Navigate to the Change Password screen
                      AutoRouter.of(context).push(ForgotRouteView());
                    },
                    ),
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
