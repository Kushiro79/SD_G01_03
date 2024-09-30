import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewOtherUsersController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxList<DocumentSnapshot> users = RxList<DocumentSnapshot>([]);

  String _currentUserRole = '';

   Future<void> _fetchUsers() async {
    final userId = _auth.currentUser?.uid;

    if (userId != null) {
      final userDoc = await _firestore.collection('users').doc(userId).get();
      if (userDoc.exists) {
        _currentUserRole = userDoc.data()?['role'];
      }
    }

    final snapshot = await _firestore
        .collection('users')
        .where('role', whereIn: ['user', 'staff', 'admin'])
        .where('cer')
        .get();

users.value = snapshot.docs.map((doc) => doc as DocumentSnapshot).toList();    }
  }

