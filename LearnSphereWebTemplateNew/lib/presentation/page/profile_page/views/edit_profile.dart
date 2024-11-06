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
      backgroundColor: const Color(0xFF1A1F3B),
      body: SingleChildScrollView(
        // Added this for scrolling
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Added this to control alignment
            children: [
              // Left side with profile image and static info (from Firebase)
              Column(
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
                                  ? Stack(
                                      children: [
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
                                          ),
                                        ),
                                      ],
                                    )
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
                    ],
                  ),
                  const SizedBox(height: 16),
                  Obx(() {
                    String username = controller.username.value;
                    String email = controller.email.value;
                    String certificate = controller.certificate.value;
                    return Card(
                      color: Colors.transparent.withOpacity(0.13),
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
                                  color: Colors.white),
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
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Obx(() {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

    Card(
      color: Colors.transparent.withOpacity(0.13),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Username: ${controller.username.value}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Email: ${controller.email.value}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF117aca),
                    ),
                    onPressed: () {
                      controller.showEditDialog(context);
                    },
                    icon: const Icon(Icons.edit, color: Colors.white),
                    label: const Text('Change', style: TextStyle(color: Colors.white)),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    ),
  

  // Method to show the edit dialog
  

                          const SizedBox(width: 16),
                          Card(
                            color: Colors.transparent.withOpacity(0.13),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width >
                                        850
                                    ? MediaQuery.of(context).size.width * 0.5
                                    : MediaQuery.of(context).size.width *
                                        0.9, // Constrain width to screen size
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .start, // Aligns the title to the left
                                  children: [
                                    const Text(
                                      'Approved Certificates',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                        height:
                                            16), // Adds some spacing between the title and list
                                    ...controller.certificates
                                        .map((certificate) {
                                      return ListTile(
                                        title: Text(
                                          certificate['fieldOfStudy'] ??
                                              'Unknown Field of Study',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                certificate[
                                                        'levelOfEducation'] ??
                                                    'Unknown Level of Education',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                )),
                                            Text(
                                                certificate[
                                                        'institutionName'] ??
                                                    'Unknown Institution',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                )),
                                            Text(
                                                certificate['id'] ??
                                                    'Unknown id',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                )),
                                          ],
                                        ),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize
                                              .min, // Ensures the row takes up the minimum width needed
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons
                                                  .download, color: Colors.white,), // Download icon
                                              onPressed: () {
                                                final certificateUrl =
                                                    certificate[
                                                        'certificateUrl'];
                                                if (certificateUrl != null) {
                                                  controller.downloadCertificate(
                                                      certificateUrl); // Call function to download
                                                } else {
                                                  showCustomToast(context,
                                                      'Certificate URL not available.');
                                                }
                                              },
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.delete,
                                                  color: Colors
                                                      .red), // Delete icon
                                              onPressed: () async {
                                                final certificateId = certificate[
                                                    'id']; // Accessing the ID
                                                print(
                                                    'Certificate ID: $certificateId'); // Debug statement

                                                if (certificateId != null &&
                                                    certificateId.isNotEmpty) {
                                                  // Show confirmation dialog
                                                  final confirmed =
                                                      await showDialog<bool>(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                            'Confirm Deletion'),
                                                        content: const Text(
                                                            'Are you sure you want to delete this certificate?'),
                                                        actions: [
                                                          TextButton(
                                                            child: const Text(
                                                                'Cancel'),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(
                                                                      false); // Return false for cancellation
                                                            },
                                                          ),
                                                          TextButton(
                                                            child: const Text(
                                                                'Delete'),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(
                                                                      true); // Return true for confirmation
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );

                                                  if (confirmed == true) {
                                                    // If the user confirmed, proceed to delete
                                                    await controller
                                                        .deleteCertificate(
                                                            certificateId);
                                                  }
                                                } else {
                                                  showCustomToast(context,
                                                      'Certificate ID not found.');
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    }),
                  ),
                  Card(
                    color: Colors.transparent.withOpacity(0.13),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width > 850
                            ? MediaQuery.of(context).size.width * 0.5
                            : MediaQuery.of(context).size.width *
                                0.9, // Constrain width to screen size
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // Aligns the title to the left
                          children: [
                            const Text(
                              'Rejected Certificates',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                                height:
                                    16), // Adds some spacing between the title and list

                            // Use Obx to make the list reactive
                            Obx(() {
                              if (controller.rejectedCertificates.isNotEmpty) {
                                return Column(
                                  children: [
                                    // Add the apology message if there are any rejected certificates
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 16),
                                      child: Text(
                                        'Your Certificate application request was rejected. Please send a new request',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),

                                    // Dynamically generate the ListTiles from the rejectedCertificates list
                                    Column(
                                      children: controller.rejectedCertificates
                                          .map((rejectedCertificate) {
                                        return ListTile(
                                          title: Text(
                                              rejectedCertificate[
                                                      'fieldOfStudy'] ??
                                                  'Unknown Field of Study',
                                              style: TextStyle(
                                                color: Colors.white,
                                              )),
                                          subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  rejectedCertificate[
                                                          'levelOfEducation'] ??
                                                      'Unknown Level of Education',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  )),
                                              Text(
                                                  rejectedCertificate[
                                                          'institutionName'] ??
                                                      'Unknown Institution',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  )),
                                              Text(
                                                  rejectedCertificate['id'] ??
                                                      'Unknown ID',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  )),
                                            ],
                                          ),
                                          trailing: Row(
                                            mainAxisSize: MainAxisSize
                                                .min, // Ensures the row takes up the minimum width needed
                                            children: [
                                              IconButton(
                                                icon: const Icon(Icons
                                                    .download, color: Colors.white,), // Download icon
                                                onPressed: () {
                                                  final certificateUrl =
                                                      rejectedCertificate[
                                                          'certificateUrl'];
                                                  if (certificateUrl != null) {
                                                    controller.downloadCertificate(
                                                        certificateUrl); // Call function to download
                                                  } else {
                                                    showCustomToast(context,
                                                        'Certificate URL not available.');
                                                  }
                                                },
                                              ),
                                              IconButton(
                                                icon: const Icon(Icons.delete,
                                                    color: Colors
                                                        .red), // Delete icon
                                                onPressed: () async {
                                                  final certificateId =
                                                      rejectedCertificate[
                                                          'id']; // Accessing the ID
                                                  print(
                                                      'Certificate ID: $certificateId'); // Debug statement

                                                  if (certificateId != null &&
                                                      certificateId
                                                          .isNotEmpty) {
                                                    // Show confirmation dialog
                                                    final confirmed =
                                                        await showDialog<bool>(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          title: const Text(
                                                              'Confirm Deletion'),
                                                          content: const Text(
                                                              'Are you sure you want to delete this certificate?'),
                                                          actions: [
                                                            TextButton(
                                                              child: const Text(
                                                                  'Cancel'),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(
                                                                        false); // Return false for cancellation
                                                              },
                                                            ),
                                                            TextButton(
                                                              child: const Text(
                                                                  'Delete'),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(
                                                                        true); // Return true for confirmation
                                                              },
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );

                                                    if (confirmed == true) {
                                                      // If the user confirmed, proceed to delete
                                                      await controller
                                                          .deleteCertificate(
                                                              certificateId);
                                                    }
                                                  } else {
                                                    showCustomToast(context,
                                                        'Certificate ID not found.');
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                );
                              } else {
                                return const Text(
                                    'No rejected certificates found.',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ));
                              }
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  MediaQuery.of(context).size.width > 850
                  ?Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF117aca),
                          ),
                        label: const Text('Add Certificate', style: TextStyle(color:Colors.white),),
                        icon: const Icon(Icons.description_rounded, color:Colors.white),
                        onPressed: () {
                          AutoRouter.of(context)
                              .push(const UploadAcademicQualificationsRoute());
                        },
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF117aca),
                          ),
                        label: const Text('Change Password', style: TextStyle(color: Colors.white),),
                        icon: const Icon(Icons.lock , color: Colors.white),
                        onPressed: () {
                          AutoRouter.of(context).push(ChangePasswordRoute());
                        },
                      ),
                    ],
                  )
                  :
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF117aca),
                          ),
                        label: const Text('Add Certificate', style: TextStyle(color:Colors.white),),
                        icon: const Icon(Icons.description_rounded, color:Colors.white),
                        onPressed: () {
                          AutoRouter.of(context)
                              .push(const UploadAcademicQualificationsRoute());
                        },
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF117aca),
                          ),
                        label: const Text('Change Password', style: TextStyle(color: Colors.white),),
                        icon: const Icon(Icons.lock , color: Colors.white),
                        onPressed: () {
                          AutoRouter.of(context).push(ChangePasswordRoute());
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
