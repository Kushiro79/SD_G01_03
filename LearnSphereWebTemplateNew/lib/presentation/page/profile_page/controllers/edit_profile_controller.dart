import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../utils/custom_toast.dart';
import 'package:file_picker/file_picker.dart';

class EditProfileController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Observable properties for profile details
  final username = ''.obs;
  final email = ''.obs;
  final profileImageUrl = ''.obs;
  final credentials = ''.obs; // Changed from bio to credentials
  final certificate = ''.obs; // For user certification level (e.g., Newbie)
  final bannerImageUrl = ''.obs;

  RxBool _isHovering = false.obs;

  RxBool get isHovering => _isHovering;

  // Method to fetch profile data from Firebase
  Future<void> loadProfile() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        var profileData =
        await _firestore.collection('users').doc(user.uid).get();
        username.value = profileData['username'] ?? '';
        email.value = user.email ?? '';
        profileImageUrl.value = profileData['profileImageUrl'] ?? '';
        bannerImageUrl.value = profileData['bannerImageUrl'] ?? '';
        credentials.value =
        profileData['credentials'] ?? ''; // Changed from bio to credentials
        certificate.value = profileData['certificate'] ?? 'Newbie';
      }
    } catch (e) {
      print('Error fetching profile data: $e');
    }
  }

  bool isEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  // Method to save profile changes to Firebase
  Future<void> saveProfile(context) async {
    if (!isEmail(email.value)) {
      // Check if the email is invalid
      showCustomToast(context, 'Enter a valid email address');
      print('Invalid email format');
      return;
    }
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).update({
          'username': username.value,
          'email': email.value,
          'profileImageUrl': profileImageUrl.value,
          'bannerImageUrl': bannerImageUrl.value,
          'credentials': credentials.value,
          'certificate': certificate.value,
        });
        print('Profile updated successfully');
      }
    } catch (e) {
      print('Error updating profile: $e');
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      print('User logged out successfully');
      // Optionally navigate to the login screen
      Get.offAllNamed('/login'); // Adjust the route as needed
    } catch (e) {
      print('Error logging out: $e');
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      print('Password reset email sent');
      // Optionally show a message to the user
      Get.snackbar('Password Reset', 'Password reset email sent');
    } catch (e) {
      print('Error sending password reset email: $e');
    }
  }

  void setIsHovering(RxBool value) {
    _isHovering = value;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    loadProfile(); // Load profile data when the controller is initialized
  }

  Future<void> pickAndUploadPfp(BuildContext context) async {
    // Open file picker and select an image
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null && result.files.isNotEmpty) {
      // Get the selected file
      final file = result.files.first;

      // Upload the file to Firebase Storage
      try {
        // Create a reference to the Firebase Storage bucket
        final storageRef =
            FirebaseStorage.instance.ref().child('profile/${file.name}');
        // Upload the file
        await storageRef.putData(await file.bytes!);
      
        // Optionally, get the download URL
        String downloadURL = await storageRef.getDownloadURL();
        profileImageUrl.value = downloadURL;
        print("File uploaded successfully! Download URL: $downloadURL");
        saveProfile(context);
      } catch (e) {
        print("Error uploading file: $e");
      }
    } else {
      print("No file selected.");
    }
  }

  Future<void> pickAndUploadBanner(BuildContext context) async {
    // Open file picker and select an image
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null && result.files.isNotEmpty) {
      // Get the selected file
      final file = result.files.first;

      // Upload the file to Firebase Storage
      try {
        // Create a reference to the Firebase Storage bucket
        final storageRef =
            FirebaseStorage.instance.ref().child('banner/${file.name}');
        // Upload the file
        await storageRef.putData(await file.bytes!);
      
        // Optionally, get the download URL
        String downloadURL = await storageRef.getDownloadURL();
        bannerImageUrl.value = downloadURL;
        print("File uploaded successfully! Download URL: $downloadURL");
        saveProfile(context);
      } catch (e) {
        print("Error uploading file: $e");
      }
    } else {
      print("No file selected.");
    }
  }
}
