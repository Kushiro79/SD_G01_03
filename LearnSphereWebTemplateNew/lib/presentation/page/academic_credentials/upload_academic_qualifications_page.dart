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
        body: LayoutBuilder(builder: (context, constraints) {
          return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: constraints.maxWidth >850 ?constraints.maxWidth *0.22 :constraints.maxWidth *0.05 , vertical: 10),
              child: Form(
                key: controller.formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
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
                            labelText: 'Level Of Education', hintText: 'PhD'),
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
                            hintText: 'LearnSpherology'),
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
                            hintText: 'University of LearnSphere'),
                      ),
                      const SizedBox(height: 20),
                      MediaQuery.of(context).size.width > 850 
                      ?
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Obx(() {
                            if (controller.isUploading.value) {
                              return const CircularProgressIndicator(); // Show progress indicator during upload
                            }
                            return ElevatedButton(
                              onPressed: () async {
                                await controller.pickAndUploadCertificate(context); // Upload the file after picking
                              },
                              child: const Text('Upload Certificate'),
                            );
                          }),
                          const SizedBox(
                            width: 10,
                          ),
                          Obx(() {
                            // Disable the Submit button while uploading or if no file is uploaded
                            return ElevatedButton(
                              onPressed: controller.isUploading.value ||
                                      controller.certificateUrl.isEmpty
                                  ? null // Disable the button
                                  : () async {
                                      await controller.submitInfo(context); // Submit form after upload
                                    },
                              child: const Text('Submit'),
                            );
                          }),
                        ],
                      )
                      :
                      Column(
                        children: [
                          Obx(() {
                            if (controller.isUploading.value) {
                              return const CircularProgressIndicator(); // Show progress indicator during upload
                            }
                            return ElevatedButton(
                              onPressed: () async {
                                await controller.pickAndUploadCertificate(context); // Upload the file after picking
                              },
                              child: const Text('Upload Certificate'),
                            );
                          }),
                          const SizedBox(
                            width: 10,
                          ),
                          Obx(() {
                            // Disable the Submit button while uploading or if no file is uploaded
                            return ElevatedButton(
                              onPressed: controller.isUploading.value ||
                                      controller.certificateUrl.isEmpty
                                  ? null // Disable the button
                                  : () async {
                                      await controller.submitInfo(context); // Submit form after upload
                                    },
                              child: const Text('Submit'),
                            );
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
              ));
        }));
  }
}
