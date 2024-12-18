import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io';

import '../../../routes/app_router.dart';
import 'package:auto_route/auto_route.dart';



class UploadAcademicQualificationController extends GetxController {
  var isUploading = false.obs;
  final formKey = GlobalKey<FormState>();

  final name = TextEditingController();
  final education = TextEditingController();
  final fieldOfStudy = TextEditingController();
  final institution = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final certificateUrl = ''.obs;
  final file = ''.obs;
  
  @override
  void onInit() {
    super.onInit();
    const UploadAcademicQualificationsRoute();    
  }
  
  

  // Picking and uploading the certificate
Future<void> pickAndUploadCertificate(BuildContext context) async {
  // Open file picker and select an image or document
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf', 'docx', 'jpg', 'png', 'jpeg'],
  );

  if (result != null && result.files.isNotEmpty) {
    // Get the selected file
    final file = result.files.first;

    try {
      isUploading.value = true; // Indicate that the upload is in progress

      // Create a reference to the Firebase Storage bucket
      final storageRef = FirebaseStorage.instance.ref().child('certificates/${file.name}');

      // Check platform and upload the file accordingly
      if (kIsWeb) {
        // Upload directly from bytes for web
        await storageRef.putData(file.bytes!);
      } else {
        // Convert path to File and upload for Android/iOS
        File localFile = File(file.path!);
        await storageRef.putFile(localFile);
      }

      // Get the download URL after successful upload
      String downloadURL = await storageRef.getDownloadURL();
      
      // Update certificate URL observable or variable
      certificateUrl.value = downloadURL;
      isUploading.value = false; // Reset upload state

      print('File uploaded successfully! Download URL: $downloadURL');
      
    } catch (e) {
      isUploading.value = false; // Reset upload state on error
      print('Error uploading file: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading file: $e')),
      );
    }
  } else {
    print('No file selected.');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('No file selected')),
    );
  }
}


// Submitting form information to Firestore
Future<void> submitInfo(BuildContext context) async {
  final userId = _auth.currentUser?.uid;
  
  if (userId == null) {
    print('User is not logged in');
    return;
  }

  if (certificateUrl.isNotEmpty && formKey.currentState!.validate()) {
    try {
      // Add the certificate info to a collection
      await FirebaseFirestore.instance.collection('qualificationRequests').doc('requested').collection('uniqueRequests').add({
        'name': name.text,
        'levelOfEducation': education.text,
        'fieldOfStudy': fieldOfStudy.text,
        'institutionName': institution.text,
        'certificateUrl': certificateUrl.value,
        'status':'pending',
        'userId' : userId, // Make sure this is set by pickAndUploadCertificate
      });

      print('Form data and certificate info submitted successfully!');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data submitted successfully!')),
      );

      name.clear();
      education.clear();
      fieldOfStudy.clear();
      institution.clear();
      certificateUrl.value = '';

      context.router.replace(MyHomeRoute());

    } catch (e) {
      print('Error submitting data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error submitting data: $e')),
      );
    }
  } else {
    print('Please upload certificate before submitting');
  }
}
  @override
  void onClose() {
    name.dispose();
    education.dispose();
    fieldOfStudy.dispose();
    institution.dispose();
    super.onClose();
  }
  
}