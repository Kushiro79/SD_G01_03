import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sociogram/app/modules/interest_screen/views/interest_screen_view.dart';

class VerificationScreenController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> checkEmailVerified() async {
    User? user = _auth.currentUser;
    await user?.reload();  // Reload user data to get the latest email verification status
    if (user?.emailVerified ?? false) {
      Get.to(() => InterestScreenView());
    } else {
      Get.snackbar("Verification", "Email is not yet verified. Please check your inbox.");
    }
  }

  Future<void> resendVerificationEmail() async {
    try {
      User? user = _auth.currentUser;
      await user?.sendEmailVerification();
      Get.snackbar("Verification", "Verification email has been resent.");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
