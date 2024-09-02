import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterController extends GetxController {
  final count = 0.obs;

  bool showPassword = true;

  void increment() => count.value++;

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String get username => _usernameController.text;
  String get email => _emailController.text;
  String get password => _passwordController.text;

  changePasswordhideAndShow(){
    showPassword = !showPassword;
    update();
  }


  void updateUsername(String value) {
    _usernameController.text = value;
  }

  void updateEmail(String value) {
    _emailController.text = value;
  }

  void updatePassword(String value) {
    _passwordController.text = value;
  }

  void disposeControllers() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  Future<void> createUserwithEmailandPassword(String email, String password ) async{
    try {
      UserCredential result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: this.email, password: this.password);
      User? user = result.user;

      if (user != null) {
      // Create a new user document in Firestore
      await _createUserDocument(user);
      } else {
      print('Error creating user: user is null');
      }
    } catch (e) {
      print('Error creating user: $e');
      Get.snackbar('Error', 'Failed to create user: $e');

    }
  }
  Future<void> _createUserDocument(User user) async{
    final firestore = FirebaseFirestore.instance;
    final userCollection = firestore.collection('users');

    final userData = {
    'username': username, // You can get the username from the user input
    'role': 'user',
    'uid': user.uid,
    };

    await userCollection.doc(user.uid).set(userData);
  }


}
