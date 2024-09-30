import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

class DiscoverController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxList<DocumentSnapshot> users = RxList<DocumentSnapshot>([]);

  String _currentUserRole = '';

  Future<void> discoverList() async {
    final userId = _auth.currentUser?.uid;

    if (userId != null) {
      final userDoc = await _firestore
      .collection('users')
      .where('uid',isNotEqualTo: userId)
      .get();


      users.value = userDoc.docs.map((doc) => doc as DocumentSnapshot).toList();
    }
  }

}