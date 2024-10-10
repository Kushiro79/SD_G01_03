import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:get/get.dart';
import 'controller/upload_controller.dart';

// A page where users can upload their academic qualifications for approval by the admin or staff. Also insert their name, interest and other details according to their qualifications
@RoutePage()
class UploadAcademicQualificationsPage extends GetView<UploadAcademicQualificationController> {
  const UploadAcademicQualificationsPage({super.key});
  
  @override
  UploadAcademicQualificationController get controller => Get.put(UploadAcademicQualificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload your Academic Qualifications'),
      ),
      body: Center( // Center the box vertically and horizontally
        child: LayoutBuilder(builder: (context, constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center the form and buttons vertically
            children: [
              // Box with form fields up to "Institution Name"
              Container(
                width: constraints.maxWidth * 0.9, // Makes the container 90% of the available width
                decoration: BoxDecoration(
                  color: Colors.white, // Background color of the box
                  borderRadius: BorderRadius.circular(20), // Curved borders
                
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0), // Padding inside the box
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch, // Align children to the edges of the box
                      children: [
                        TextFormField(
                          controller: controller.name,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Name',
                            hintText: 'Jane Doe',
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: controller.education,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your highest level of education';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Level Of Education', 
                            hintText: 'PhD',
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: controller.fieldOfStudy,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your field of study';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Field of Study',
                            hintText: 'LearnSpherology',
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: controller.institution,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your institution name';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Institution Name',
                            hintText: 'University of LearnSphere',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20), // Space between the form and buttons
              
              // Centered Buttons outside the box with reduced border radius
              MediaQuery.of(context).size.width > 850
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center, // Center the buttons horizontally
                      children: [
                        Obx(() {
                          if (controller.isUploading.value) {
                            return const CircularProgressIndicator(); // Show progress indicator during upload
                          }
                          return ElevatedButton(
                            onPressed: () async {
                              await controller.pickAndUploadCertificate(context); // Upload the file after picking
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8), // Reduced border radius
                              ),
                            ),
                            child: const Text('Upload Certificate'),
                          );
                        }),
                        const SizedBox(width: 10),
                        Obx(() {
                          return ElevatedButton(
                            onPressed: controller.isUploading.value || controller.certificateUrl.isEmpty
                                ? null // Disable the button
                                : () async {
                                    await controller.submitInfo(context); // Submit form after upload
                                  },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6), // Reduced border radius
                              ),
                            ),
                            child: const Text('Submit'),
                          );
                        }),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center, // Center the buttons horizontally
                      children: [
                        Obx(() {
                          if (controller.isUploading.value) {
                            return const CircularProgressIndicator(); // Show progress indicator during upload
                          }
                          return ElevatedButton(
                            onPressed: () async {
                              await controller.pickAndUploadCertificate(context); // Upload the file after picking
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6), // Reduced border radius
                              ),
                            ),
                            child: const Text('Upload Certificate'),
                          );
                        }),
                        const SizedBox(width: 10),
                        Obx(() {
                          return ElevatedButton(
                            onPressed: controller.isUploading.value || controller.certificateUrl.isEmpty
                                ? null // Disable the button
                                : () async {
                                    await controller.submitInfo(context); // Submit form after upload
                                  },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6), // Reduced border radius
                              ),
                            ),
                            child: const Text('Submit'),
                          );
                        }),
                      ],
                    ),
            ],
          );
        }),
      ),
    );
  }
}
