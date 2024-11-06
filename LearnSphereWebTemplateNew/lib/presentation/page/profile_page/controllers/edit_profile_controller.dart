import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../routes/app_router.dart';
import '../../../utils/custom_toast.dart';
import 'package:file_picker/file_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:typed_data';
import 'dart:io';


import '../../register/controllers/register_controller.dart';

class EditProfileController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Observable properties for profile details
  final username = ''.obs;
  final email = ''.obs;
  final profileImageUrl = ''.obs;
  final credentials = ''.obs; // Changed from bio to credentials
  final certificate = ''.obs; 
  final bannerImageUrl = ''.obs;

  RxList certificates = <Map<String, dynamic>>[].obs;
  RxList rejectedCertificates = <Map<String, dynamic>>[].obs;


  RxBool _isHovering = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  RxBool get isHovering => _isHovering;
  loadPfp() {
    return profileImageUrl.value;
  }

  void showEditDialog(BuildContext context) {
    final usernameController = TextEditingController(text: username.value);
    final emailController = TextEditingController(text: email.value);
    RegisterController registerController = Get.put(RegisterController());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: const Text("Edit Profile", style: TextStyle(color: Colors.white),),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                style: TextStyle(color: Colors.white),
                controller: usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                style: TextStyle(color: Colors.white),
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel" , style: TextStyle(color: Color(0xFF117aca)),),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color(0xFF117aca),
                elevation: 0,
                backgroundColor: Colors.black
              ),
              onPressed: () async {
                // Check if username exists
                if (await registerController.checkUsernameExists(usernameController.text)) {
                  Get.snackbar('Error', 'Username already exists');
                } else {
                  username.value = usernameController.text;
                  email.value = emailController.text;
                  saveProfile(context);
                  Navigator.of(context).pop(); // Close the dialog
                }
              },
              child: const Text("Save Changes"),
            ),
          ],
        );
      },
    );
  }


  // Method to fetch profile data from Firebase
  Future<void> loadProfile() async {
  try {
    User? user = _auth.currentUser;
    if (user != null) {
      var profileData = await _firestore.collection('users').doc(user.uid).get();
      var certificateSnapshot = await _firestore
          .collection('qualicationRequests')
          .doc('approvedCertificates')
          .collection('users')
          .doc(user.uid)
          .collection('certificates')
          .get();

      username.value = profileData['username'] ?? '';
      email.value = user.email ?? '';
      profileImageUrl.value = profileData['profileImageUrl'] ?? '';
      bannerImageUrl.value = profileData['bannerImageUrl'] ?? '';
      credentials.value = profileData['credentials'] ?? '';

      // Extract all certificate data
      List<String> certificatesList = [];
      for (var doc in certificateSnapshot.docs) {
        var certificateData = doc.data();
        String levelOfEducation = certificateData['levelOfEducation'] ?? 'Unknown';
        certificatesList.add(levelOfEducation);
      }

      // Optionally, you can store the list of certificates in a reactive variable
      certificates.value = certificatesList.isNotEmpty ? certificatesList : ['Newbie'];
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
  void onReady() {
    super.onReady();
    loadProfile(); // Load profile data when the controller is initialized
    loadPfp();
    fetchCertificates();
    fetchRejectedQualifications();
  }

  Future<void> pickAndUploadPfp(BuildContext context) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.image,
  );

  if (result != null && result.files.isNotEmpty) {
    final file = result.files.first;
    final userId = FirebaseAuth.instance.currentUser!.uid;
    String fileName = '${userId}_${DateTime.now().millisecondsSinceEpoch}.jpg';

    try {
      Reference storageRef = FirebaseStorage.instance.ref().child('profile/$fileName');

      if (kIsWeb) {
        await storageRef.putData(file.bytes!); // Web uses putData with Uint8List
      } else {
        File localFile = File(file.path!);
        await storageRef.putFile(localFile); // Android uses putFile with File
      }

      String downloadURL = await storageRef.getDownloadURL();
      profileImageUrl.value = downloadURL;
      print('Profile picture uploaded successfully! Download URL: $downloadURL');
      saveProfile(context);
    } catch (e) {
      print('Error uploading profile picture: $e');
    }
  } else {
    print('No file selected.');
  }
}

  

  Future<void> pickAndUploadBanner(BuildContext context) async {
  // Open file picker and select an image
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.image,
  );

  if (result != null && result.files.isNotEmpty) {
    final file = result.files.first;
    final userId = FirebaseAuth.instance.currentUser!.uid;
    String fileName = '${userId}_banner_${DateTime.now().millisecondsSinceEpoch}.${file.extension}';

    try {
      final storageRef = FirebaseStorage.instance.ref().child('banner/$fileName');
      
      // Check if running on web
      if (kIsWeb) {
        // Upload directly from bytes on web
        await storageRef.putData(file.bytes!);
      } else {
        // Convert file path to a `File` object on mobile
        final localFile = File(file.path!);
        await storageRef.putFile(localFile);
      }

      // Get the download URL after successful upload
      String downloadURL = await storageRef.getDownloadURL();
      bannerImageUrl.value = downloadURL;
      print('Banner uploaded successfully! Download URL: $downloadURL');
      saveProfile(context);
    } catch (e) {
      print('Error uploading banner: $e');
    }
  } else {
    print('No file selected.');
  }
}


  //DELETE
  Future<void> deleteAccount(BuildContext context) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Show confirmation dialog before proceeding
        bool confirmed = await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Confirm Deletion'),
              content: const Text(
                  'Are you sure you want to delete your account? This action cannot be undone.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Delete'),
                ),
              ],
            );
          },
        );

        if (confirmed) {
          await user.delete(); // Delete the Firebase account

          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Account deleted successfully'),
              duration: Duration(seconds: 2), // Display for 2 seconds
            ),
          );

          // Optionally: Remove user data from Firestore or any other database
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .delete();

          // Wait for the SnackBar to show before navigating away
          await Future.delayed(const Duration(seconds: 2));

          // Navigate to the login page after showing the message
          context.router.replace(LoginRouteView());
        }
      }
    } catch (e) {
      print('Error deleting account: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Error deleting account. Please try again.')),
      );
    }
  }




  Future<void> fetchCertificates() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    try {
      // Replace 'userUID' with the actual user's UID and 'certificate' with the correct collection path
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('qualificationRequests')
          .doc('approvedCertificates')
          .collection('users')
          .doc(uid)
          .collection('certificates')
          .get();

      // Map through the documents and add them to the list
      certificates.value = snapshot.docs.map((doc) {
      return {
        'id': doc.id, // Document ID
        ...doc.data() as Map<String, dynamic>,
      };
    }).toList();

      print(certificate);
    } catch (e) {
      print('Error fetching certificates: $e');
    }
  }

  void downloadCertificate(String url) async {
  try {
    // Use any method for downloading the file, for example, url_launcher or dio package
    await launchUrl(Uri.parse(url)); // Using url_launcher for demonstration
  } catch (e) {
    print('Error downloading certificate: $e');
  }
}

Future<void> fetchRejectedQualifications() async {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  try {
    // Fetching rejected qualifications for the current user
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('qualificationRequests')
        .doc('rejectedCertificates') // Assuming this is the collection path
        .collection('users')
        .doc(uid)
        .collection('certificates') // Assuming this is the sub-collection name
        .get();

    // Map through the documents and add them to the list
    rejectedCertificates.value = snapshot.docs.map((doc) {
      return {
        'id': doc.id, // Document ID
        ...doc.data() as Map<String, dynamic>,
      };
    }).toList();

    print('Rejected: $rejectedCertificates'); // Print the fetched qualifications for debugging
  } catch (e) {
    print('Error fetching rejected qualifications: $e');
  }
}


Future<void> deleteCertificate(String certificateId) async {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  print('Certificate ID function: $certificateId');
    try {
      try {
        await FirebaseFirestore.instance
            .collection('qualificationRequests')
            .doc('approvedCertificates') // Replace with the actual user ID
            .collection('users')
            .doc(uid)
            .collection('certificates')
            .doc(certificateId)
            .delete();

        // Optionally, remove the certificate from the local list
        certificates.removeWhere((certificate) => certificate['id'] == certificateId);
        Get.snackbar('Success', 'Certificate deleted successfully',
            snackPosition: SnackPosition.BOTTOM);
      } catch (e) {
        Get.snackbar('Error', 'Certificate ID not found',
            snackPosition: SnackPosition.BOTTOM);
      }
        // Access the Firestore collection and delete the document
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete certificate: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

}
