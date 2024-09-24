import 'package:auto_route/auto_route.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../utils/custom_toast.dart';
import '../../../routes/app_router.dart';

class LoginScreenController extends GetxController {
  //observable
  var isValidEmail = true.obs;
  var isValidPassword = true.obs;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  RxString _emailErrorText = ''.obs;
  RxString _passwordErrorText = ''.obs;

  String get emailErrorText => _emailErrorText.value;
  String get passwordErrorText => _passwordErrorText.value;

  void updateEmail(String value) {
    _emailController.text = value;
    //isValidEmail.value = isEmail(value);
    bool validEmail = isEmail(value);
    print('email: $value, valid: $validEmail'); //debug test
    isValidEmail.value = validEmail;
    update();
  }

  /*bool isPassValid(String password){
    return password.length >= 8 &&
    RegExp(r'[a-z]').hasMatch(password) &&
    RegExp(r'[A-Z]').hasMatch(password) &&
    RegExp(r'[0-9]').hasMatch(password) &&
    RegExp(r'[!@#$&*]').hasMatch(password);
  }*/

  bool isEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  //TODO: Implement LoginScreenController

  final count = 0.obs;
  bool showPassword = true;

  void increment() => count.value++;

  changePasswordhideAndShow() {
    showPassword = !showPassword;
    update();
  }

  bool validateCredentials() {
    updateEmail(_emailController.text);
    updatePassword(_passwordController.text);
    return isValidEmail.value && isValidPassword.value;
  }

  void disposeController() {
    _emailController.dispose();
    _passwordController.dispose();
  }

  SigninWithEmailandPassword(BuildContext context) async {
    if (_emailController.text.isEmpty && _passwordController.text.isEmpty) {
      showCustomToast(context, 'Please enter your information.');
      return;
    }
    if (_emailController.text.isEmpty) {
      showCustomToast(context, 'Please enter your email address.');
      return;
    }
    if (_passwordController.text.isEmpty) {
      showCustomToast(context, 'Please enter your password.');
      return;
    }
    if (!isValidEmail.value) {
      showCustomToast(context, 'Please enter a valid email address.');
      return;
    }

    if (validateCredentials()) {
      print('Email: ${_emailController.text}');
      print('Password: ${_passwordController.text}');

      try {
        UserCredential userCredential =
            await _firebaseAuth.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        print('Signed in successfully');

        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .get();

        String role = userDoc.get('role');

        if (context.mounted) {
          if (role == 'user') {
            context.router.push(MyHomeRoute()); // Navigate to the Home Page
          } else if (role == 'admin' || role == 'staff') {
            context.router.push(
                const MainRoute()); // Navigate to the Admin/Staff Dashboard
          } else {
            // Handle any unexpected roles
            print('Unexpected role: $role');
          }
        }
      } on FirebaseAuthException catch (e) {
        showCustomToast(context, e.message.toString());
      }
    }
  }

  void updateEmailErrorText(String errorMessage) {
    _emailErrorText.value = errorMessage;
  }

  void updatePasswordErrorText(String errorMessage) {
    _passwordErrorText.value = errorMessage;
  }

  updatePassword(value) {
    _passwordController.text = value;
  }
}
