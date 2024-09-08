import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../routes/app_router.dart';

class VerificationScreenController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> checkEmailVerified(BuildContext context) async {
    User? user = _auth.currentUser;
    await user
        ?.reload(); // Reload user data to get the latest email verification status
    if (user?.emailVerified ?? false) {
      Get.put(VerificationScreenController());
      context.router.push(MyHomeRoute());
    } else {
      showCustomToast(context, 'Please verify your email');
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

  void showCustomToast(BuildContext context, String message) {
    FToast fToast = FToast();
    fToast.init(context);

    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.black87,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 2),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 12.0),
          Text(
            message,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
