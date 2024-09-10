import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProfileController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Observable properties for profile details
  final username = ''.obs;
  final email = ''.obs;
  final bio = ''.obs;
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
        bio.value = profileData['bio'] ?? '';
        profileImageUrl.value = profileData['profileImageUrl'] ?? '';
        certificate.value = profileData['certificate'] ?? 'Newbie';
      }
    } catch (e) {
      print('Error fetching profile data: $e');
    }
  }

  // Method to save profile changes to Firebase
  Future<void> saveProfile() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).update({
          'username': username.value,
          'bio': bio.value,
          'profileImageUrl': profileImageUrl.value,
          'certificate': certificate.value,
        });
        print('Profile updated successfully');
      }
    } catch (e) {
      print('Error updating profile: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadProfile(); // Load profile data when the controller is initialized
  }
}
