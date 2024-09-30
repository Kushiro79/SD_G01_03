import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../profile_page/controllers/edit_profile_controller.dart';

class HomeController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    userUsername();
  }
  void onClose() {
    super.onClose();
    username = ''.obs;
  }


  var selectIndex = [];
  var selectIndex1 = [];
  int seltectitem = 0;
  final count = 0.obs;

  RxString username = ''.obs;


  void increment() => count.value++;


  changeValue({int? value}) {
    if (selectIndex.contains(value)) {
      selectIndex.remove(value);
    } else {
      selectIndex.add(value);
    }
    update();
  }

  changeValue1({int? value}) {
    if (selectIndex1.contains(value)) {
      selectIndex1.remove(value);
    } else {
      selectIndex1.add(value);
    }
    update();
  }

  List pic = [
    'assets/02.png',
    'assets/03.png',
    'assets/03.png',
  ];
  List frame = [
    'assets/Frame 427321881.png',
    'assets/Frame 427321882.png',
    'assets/Frame 427321883.png',
  ];
  List text = [
    'Alon musk',
    'Samantha',
    'Sara Ali khan',
  ];
  List instastory = [
    'assets/02.png',
    'assets/03.png',
    'assets/01.png',
    'assets/04.png',
    'assets/03.png',
  ];
  List instastory1 = [
    'assets/02.png',
    'assets/03.png',
    'assets/01.png',
    'assets/04.png',
  ];
  List text1 = [
    'Alon musk',
    'V. Kohl',
    'Tiger shroff',
    'Sharukh',
  ];
  List subtitle = [
    'Wow Looking Handsome Buddy',
    'You Are So Handsome',
    'So Beautiful Pic',
    'You Have A Great Smile',
  ];
  List time = [
    '2 min ago',
    '5 min ago',
    '10 min ago',
    '20 min ago',
  ];
  List option = [
    'Hide',
    'Block',
    'Report',
  ];
  List<Color> colors = [
    Colors.black,
    Colors.red,
    Colors.red,
  ];
  Future<void> userUsername() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final firestore = FirebaseFirestore.instance;

    User? user = auth.currentUser; // Use currentUser property directly
    if (user != null) {
      final userId = user.uid; // Get the current user's ID
      final collection = firestore.collection('users');

      final document = await collection
          .doc(userId)
          .get(const GetOptions(source: Source.server));
      final data = document.data();

       username.value = data?['username']; // Retrieve username

      print('Username: $username'); // Handle the retrieved username
   
    } else {
      print('No current user');
    }
  }
}
