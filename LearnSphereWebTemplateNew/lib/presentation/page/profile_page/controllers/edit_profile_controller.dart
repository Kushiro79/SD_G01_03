import 'package:get/get.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../utils/custom_toast.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Observable properties for profile details
  final username = ''.obs;
  final email = ''.obs;
  final credentials = ''.obs;  // Changed from bio to credentials
  final profileImageUrl = ''.obs;
  final certificate = ''.obs; // For user certification level (e.g., Newbie)

  // Method to fetch profile data from Firebase
  Future<void> loadProfile() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        var profileData = await _firestore.collection('users').doc(user.uid).get();
        username.value = profileData['username'] ?? '';
        email.value = user.email ?? '';
        credentials.value = profileData['credentials'] ?? '';  // Changed from bio to credentials
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
  if (!isEmail(email.value)) {  // Check if the email is invalid
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
        'credentials': credentials.value,
        'profileImageUrl': profileImageUrl.value,
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


  @override
  void onInit() {
    super.onInit();
    loadProfile(); // Load profile data when the controller is initialized
  }

  void picUploadImage() async {
    final picker = await ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);


    if (pickedFile == null) {
    print('No image selected');
    return;  // Stop further execution if no image is selected
  }

    Reference ref = FirebaseStorage.instance.ref().child('profile').child('${DateTime.now()}profilepic.png');

    try {
    await ref.putFile(File(pickedFile!.path));
    String downloadUrl = await ref.getDownloadURL();
    profileImageUrl.value = downloadUrl;
    print('Image uploaded successfully: $downloadUrl');
  } catch (e) {
    print('Error uploading image: $e');
  }
    
    }
}

