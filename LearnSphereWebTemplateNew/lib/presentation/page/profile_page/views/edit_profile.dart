import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_router.dart';
import '../../../utils/custom_toast.dart';
import '../controllers/edit_profile_controller.dart';

import '../../register/controllers/register_controller.dart';

@RoutePage()
class EditProfilePage extends GetView<EditProfileController> {
  EditProfilePage({super.key});

  @override
  final EditProfileController controller = Get.put(EditProfileController());
  final RegisterController registerController = Get.put(RegisterController());
  @override
  Widget build(BuildContext context) {
    // To control whether to show editable fields or static text
    final isEditing = false.obs;

    return Scaffold(
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
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Handle banner tap
                          controller.pickAndUploadBanner(context);
                        },
                        child: SizedBox(
                          //profile banner
                          height: 200,
                          width: double.infinity,
                          child: Obx(() {
                            return controller.bannerImageUrl.isNotEmpty
                                ? Image.network(
                                    controller.bannerImageUrl.value,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    'assets/background.jpg',
                                    fit: BoxFit.cover,
                                  );
                          }),
                        ),
                      ),
                      // Profile picture
                      GestureDetector(
                        onTap: () {
                          // Handle profile picture tap
                          controller.pickAndUploadPfp(context);
                        },
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Obx(() {
                              return controller.profileImageUrl.isNotEmpty
                                  ? Stack(children: [
                                      ClipOval(
                                        child: Opacity(
                                          opacity: 0.7,
                                          child: Image.network(
                                            controller.profileImageUrl.value,
                                            height: 120,
                                            width: 120,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.only(
                                              top: 50, left: 50),
                                          child: Icon(
                                            Icons.create,
                                            color: Colors.black,
                                          )),
                                    ])
                                  : Container(
                                      margin: const EdgeInsets.only(top: 16),
                                      height: 120,
                                      width: 120,
                                      alignment: Alignment.topLeft,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors
                                            .grey, // Use a default color or your AppColor.Secondary
                                      ),
                                      child: const Center(
                                          child: Icon(Icons.person,
                                              color: Colors
                                                  .white)), // Optional: Add an icon
                                    );
                            }),
                          ),
                        ),
                      ),
                      // Grey translucent layer
                    ],
                  ),
                  const SizedBox(height: 16),
                  Obx(() {
                    String username = controller.username.value;
                    String email = controller.email.value;
                    String certificate = controller.certificate.value;
                    return Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              username,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              email,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.verified,
                                  color: Colors.grey,
                                  size: 28,
                                ),
                                const SizedBox(width: 8),
                                Text(certificate),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                  const Spacer(),
                  ElevatedButton.icon(
                    label: const Text('Add Certificate'),
                    icon: const Icon(Icons.description_rounded),
                    onPressed: () {
                      AutoRouter.of(context).push(const UploadAcademicQualificationsRoute());
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    label: const Text('Change Password'),
                    icon: const Icon(Icons.lock),
                    onPressed: () {
                      AutoRouter.of(context).push(ChangePasswordRoute());
                    },
                  ),
                  // Add a SizedBox for spacing
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.logout),
                    label: const Text('Logout'),
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
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    label: const Text('Delete Account',
                        style: TextStyle(color: Colors.red)),
                    onPressed: () async {
                      await controller.deleteAccount(context);
                    },
                  ),
                ],
              ),
            ),

            // Vertical Divider between the sections
            const VerticalDivider(
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
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (!isEditing.value) ...[
                                Text('Username: ${controller.username.value}'),
                                const SizedBox(height: 16),
                                Text('Email: ${controller.email.value}'),
                                const SizedBox(height: 16),
                                Text(
                                    'Credentials: ${controller.credentials.value}'),
                                const SizedBox(height: 32),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    isEditing.value = true;
                                  },
                                  icon: const Icon(Icons.edit),
                                  label: const Text('Change'),
                                ),
                              ] else ...[
                                TextFormField(
                                  initialValue: controller.username.value,
                                  decoration: const InputDecoration(
                                      labelText: 'Username'),
                                  onChanged: (value) async {
                                    controller.username.value = value;
                                  },
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  initialValue: controller.email.value,
                                  decoration:
                                      const InputDecoration(labelText: 'Email'),
                                  onChanged: (value) {
                                    controller.email.value = value;
                                  },
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  initialValue: controller.credentials.value,
                                  decoration: const InputDecoration(
                                      labelText: 'Credentials'),
                                  onChanged: (value) {
                                    controller.credentials.value = value;
                                  },
                                ),
                                const SizedBox(height: 32),
                                ElevatedButton(
                                  onPressed: () async {
                                    if (await registerController
                                        .checkUsernameExists(
                                            controller.username.value)) {
                                      showCustomToast(
                                          context, 'Username Already Exists.');
                                    } else {
                                      controller.saveProfile(context);
                                      isEditing.value = false;
                                    }
                                  },
                                  child: const Text('Save Changes'),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                      // Adjust the height as needed
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
