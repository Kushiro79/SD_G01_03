import 'package:auto_route/auto_route.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/foundation.dart'
    show kIsWeb; //to check if the app is running on the web
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'dart:io' as io; // to check if the app running on app

import '../../../utils/custom_toast.dart';
import '../../../routes/app_router.dart';
import '../../verification_screen/controllers/verification_screen_controller.dart';

class RegisterController extends GetxController {
  var isValidEmail = true.obs;
  var isValidPassword = true.obs;
  var isValidUsername = true.obs;

  final count = 0.obs;

  RxBool showPassword = true.obs;

  void increment() => count.value++;

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String get username => _usernameController.text;
  String get email => _emailController.text;
  String get password => _passwordController.text;

Future<bool> checkUsernameExists(String username) async {
  try {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: username)
        .limit(1) // Limit to 1 to improve efficiency
        .get();

    return querySnapshot.docs.isNotEmpty;
  } catch (e) {
    print('Error checking username: $e');
    return false; // Better to return false on error and handle the error separately
  }
}



  void updateEmail(String value) {
    String trimmedValue = value.trim();
    _emailController.text = trimmedValue;
    //isValidEmail.value = isEmail(value);
    bool validEmail = isEmail(trimmedValue);
    print('email: $value, valid: $validEmail'); //debug test
    isValidEmail.value = validEmail;
    update();
  }

  bool isEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  

  bool validateCredentials() {
    updateEmail(_emailController.text);
    updatePassword(_passwordController.text);
    return isValidEmail.value && isValidPassword.value;
  }

  changePasswordhideAndShow() {
    showPassword.value = !showPassword.value;
    update();
  }

  void updateUsername(String value) {
    _usernameController.text = value;
  }

  void updatePassword(String value) {
    _passwordController.text = value;
  }

  void disposeControllers() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  Future<void> createUserwithEmailandPassword(String email, String password, BuildContext context) async {
        
    if(username.isEmpty && email.isEmpty && password.isEmpty){
      showCustomToast(context, 'Please enter the information.');
      return;
    }
    if(username.isEmpty){
      showCustomToast(context, 'Please enter your username.');
      return;
    }
    if(email.isEmpty){
      showCustomToast(context, 'Please enter your email address.');
      return;
    }
    if(password.isEmpty){
      showCustomToast(context, 'Please enter your password.');
      return;
    }
    if (!isValidEmail.value) {
      showCustomToast(context, 'Please enter a valid email address.');
      return;
    }

    if (await checkUsernameExists(username)) {
      showCustomToast(context, 'Username already exists.');
      return;
    }


    if (validateCredentials()) {
      print('Username: ${_usernameController.text}');
      print('Email: ${_emailController.text}');
      print('Password: ${_passwordController.text}');

      try {
        UserCredential result = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: this.email, password: this.password);
        User? user = result.user;

        if (user != null) {
          // Create a new user document in Firestore
          await _createUserDocument(user);
          user.sendEmailVerification();
          Get.put(VerificationScreenController());
          context.router.push(const VerificationRouteView());
        } else {
          print('Error creating user: user is null');
        }
      } catch (e) {
        print('Error creating user: $e');
        showCustomToast(context,'Failed to create user: $e');
      }
    }
  }

  //
  Future<void> _createUserDocument(User user) async {
    final firestore = FirebaseFirestore.instance;
    final userCollection = firestore.collection('users');

    // Determine the device type
    String getDeviceType() {
      if (kIsWeb) {
        return 'Web';
      } else if (io.Platform.isAndroid) {
        return 'Android';
      } else {
        return 'Unknown';
      }
    }

    // Get the device type
    String deviceType = getDeviceType();

    final userData = {
      'username': username, // You can get the username from the user input
      'role': 'user',
      'uid': user.uid,
      'email': user.email,
      'active': true, // Automatically setting active status to true
      'registrationDate': FieldValue.serverTimestamp(),
      'device': deviceType,
      'profileImageUrl': '',
      'profileBannerUrl': '',
      'credentials': null,
      
    };

    await userCollection.doc(user.uid).set(userData);
  }
}
