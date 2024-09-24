import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/app_color.dart';
import '../../routes/app_router.dart';
import 'controllers/edit_profile_controller.dart';
import 'controllers/proflie_screen_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';

@RoutePage()
class EditProfilePage extends GetView<EditProfileController> {
  EditProfilePage({super.key});

  final EditProfileController controller = Get.put(EditProfileController());

  @override
  Widget build(BuildContext context) {
    // To control whether to show editable fields or static text
    final isEditing = false.obs;

    return Scaffold(
      backgroundColor:
          Colors.transparent, // Set background color to transparent
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
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/background.jpg',
              fit: BoxFit.cover, // This ensures the image fills the background
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Left side with profile image and static info (from Firebase)
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.picUploadImage();
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 16),
                          height: 120,
                          width: 120,
                          alignment: Alignment.topLeft,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.purple,
                            image: controller.profileImageUrl.value.isNotEmpty
                                ? DecorationImage(
                                    image: NetworkImage(
                                        controller.profileImageUrl.value),
                                    fit: BoxFit.cover,
                                  )
                                : null, // No image uploaded yet
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Obx(() {
                        String username = controller.username.value;
                        String email = controller.email.value;
                        String certificate = controller.certificate.value;
                        return Card(
                          elevation: 4,
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  username,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  email,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.verified,
                                      color: Colors.grey,
                                      size: 28,
                                    ),
                                    SizedBox(width: 8),
                                    Text(certificate),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                      Spacer(),
                      ElevatedButton.icon(
                        label: Text("Logout"),
                        onPressed: () async {
                          try {
                            await controller.logout();
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

                // Vertical Divider between the sections
                VerticalDivider(
                  color: Colors.grey,
                  thickness: 1.0,
                  width: 40,
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
                          Card(
                            elevation: 4,
                            margin: EdgeInsets.symmetric(vertical: 8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (!isEditing.value) ...[
                                    Text(
                                        'Username: ${controller.username.value}'),
                                    SizedBox(height: 16),
                                    Text('Email: ${controller.email.value}'),
                                    SizedBox(height: 16),
                                    Text(
                                        'Credentials: ${controller.credentials.value}'),
                                    SizedBox(height: 32),
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        isEditing.value = true;
                                      },
                                      icon: Icon(Icons.edit),
                                      label: Text('Change'),
                                    ),
                                  ] else ...[
                                    TextFormField(
                                      initialValue: controller.username.value,
                                      decoration: InputDecoration(
                                          labelText: 'Username'),
                                      onChanged: (value) {
                                        controller.username.value = value;
                                      },
                                    ),
                                    SizedBox(height: 16),
                                    TextFormField(
                                      initialValue: controller.email.value,
                                      decoration:
                                          InputDecoration(labelText: 'Email'),
                                      onChanged: (value) {
                                        controller.email.value = value;
                                      },
                                    ),
                                    SizedBox(height: 16),
                                    TextFormField(
                                      initialValue:
                                          controller.credentials.value,
                                      decoration: InputDecoration(
                                          labelText: 'Credentials'),
                                      onChanged: (value) {
                                        controller.credentials.value = value;
                                      },
                                    ),
                                    SizedBox(height: 32),
                                    ElevatedButton(
                                      onPressed: () {
                                        controller.saveProfile(context);
                                        isEditing.value = false;
                                      },
                                      child: Text('Save Changes'),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                          Spacer(),
                          ElevatedButton.icon(
                            label: Text("Change Password"),
                            onPressed: () {
                              AutoRouter.of(context)
                                  .push(ChangePasswordRoute());
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
        ],
      ),
    );
  }
}
