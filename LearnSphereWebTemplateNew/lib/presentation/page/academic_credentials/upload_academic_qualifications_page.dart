import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
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
      backgroundColor: const Color(0xFF1A1F3B), // Background color of the page
      body: Center( // Center the box vertically and horizontally
        child: LayoutBuilder(builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start, // Center the form and buttons vertically
              children: [
                const Text('Upload your Academic Qualifications', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),),
            
                // Box with form fields up to "Institution Name"
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Container(
                    width: constraints.maxWidth * 0.9, // Makes the container 90% of the available width
                    decoration: BoxDecoration(
                      color: Colors.transparent.withOpacity(0.13), // Background color of the box
                      borderRadius: BorderRadius.circular(20), // Curved borders
                    
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(30.0), // Padding inside the box
                      child: Form(
                        key: controller.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch, // Align children to the edges of the box
                          children: [
                            TextFormField(
                              style: const TextStyle(color: Colors.white),
                              controller: controller.name,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                labelStyle: TextStyle(color: Colors.white),
                                labelText: 'Name',
                                hintText: 'Jane Doe',
                                hintStyle: TextStyle(color: Colors.white),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              style: const TextStyle(color: Colors.white),
                              controller: controller.education,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your highest level of education';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                labelStyle: TextStyle(color: Colors.white),
                                labelText: 'Level Of Education', 
                                hintText: 'PhD',
                                hintStyle: TextStyle(color: Colors.white),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              style: const TextStyle(color: Colors.white),
                              controller: controller.fieldOfStudy,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your field of study';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                labelStyle: TextStyle(color: Colors.white),
                                labelText: 'Field of Study',
                                hintText: 'Computer Science',
                                hintStyle: TextStyle(color: Colors.white),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              style: const TextStyle(color: Colors.white),
                              controller: controller.institution,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your institution name';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                labelStyle: TextStyle(color: Colors.white),
                                labelText: 'Institution Name',
                                hintText: 'University of Technology',
                                hintStyle: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
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
                                backgroundColor: const Color(0xFF117aca), // Change button background color here
                              ),
                              child: const Text('Upload Certificate', style: TextStyle(color: Colors.white)),
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
                                backgroundColor: const Color(0xFF117aca), // Change button background color here
                              ),
                              child: const Text('Submit', style: TextStyle(color: Colors.white)),
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
                                  borderRadius: BorderRadius.circular(8), // Reduced border radius
                                ),
                                backgroundColor: Color(0xFF117aca),
                                foregroundColor: Colors.white,
                                
                              ),
                              child: const Text('Upload Certificate'),
                            );
                          }),
                          const SizedBox(height: 10),
                          Obx(() {
                            return ElevatedButton(
                              onPressed: controller.isUploading.value || controller.certificateUrl.isEmpty
                                  ? null // Disable the button
                                  : () async {
                                      await controller.submitInfo(context); // Submit form after upload
                                    },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8), // Reduced border radius
                                ),
                                backgroundColor: Color(0xFF117aca),
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('Submit'),
                            );
                          }),
                        ],
                      ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
