import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ProfileScreenController extends GetxController {
  var username = ''.obs;
  var email = ''.obs;
  var profileImageUrl = ''.obs;
  var bannerImageUrl = ''.obs;
  var certificate = 'Newbie'.obs; // Added observable property for certificate

  
  @override
  void onReady() {
    super.onReady();
    fetchUserProfile();
    loadPfp();
  }

  loadPfp() {
    return profileImageUrl.value;
  }

  Future<void> fetchUserProfile() async {
    try {
      // Get the current authenticated user's UID from Firebase Authentication
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        String userId = currentUser.uid;

        // Fetch the user document from Firestore using the user's UID
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();

        if (userDoc.exists && userDoc.data() != null) {
          var userData = userDoc.data() as Map<String, dynamic>;
          username.value = userData['username'] ?? 'Unknown';
          email.value = userData['email'] ?? currentUser.email ?? 'No email';
          profileImageUrl.value = userData['profileImageUrl'] ?? ''; // Default to empty if no profile image
          bannerImageUrl.value = userData['bannerImageUrl'] ?? ''; // Default to empty if no banner image
          certificate.value = userData['certificate'] ?? 'No certificate'; // Fetch and set the certificate data
        } else {
          username.value = 'User not found';
          email.value = 'Email not found';
          profileImageUrl.value = ''; // No image
          bannerImageUrl.value = ''; // No image
          certificate.value = 'Newbie'; // Default certificate text
        }
      } else {
        username.value = 'No user is signed in';
        email.value = 'No email available';
        profileImageUrl.value = ''; // No image
        bannerImageUrl.value = ''; // No image
        certificate.value = 'Newbie'; // Default certificate text
      }
    } catch (e) {
      print('Error fetching user profile: $e');
      username.value = 'Error';
      email.value = 'Error';
      profileImageUrl.value = ''; // No image
      certificate.value = 'Error'; // Default certificate text in case of error
    }
  }

  void logout() {
    FirebaseAuth.instance.signOut();
    Get.offAllNamed('/login'); // Redirect to the login page
  }
}
