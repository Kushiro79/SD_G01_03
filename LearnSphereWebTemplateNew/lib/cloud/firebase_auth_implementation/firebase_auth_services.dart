import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAuthServices {
  FirebaseAuth _auth = FirebaseAuth.instance;

  /*Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
       // If successful, get the user
      User? user = userCredential.user;

      // Add user data to Firestore with 'role' as 'user'
      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'email': email,
          'role': 'user',
          'createdAt': FieldValue.serverTimestamp(),
        });

        return user;
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      return null;
      }
  }
  
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      // Fetch additional user data (like role) from Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.user?.uid)
        .get();

    String? role = userDoc.data()?['role'];

    if (role == 'admin') {
      // Redirect to admin dashboard
    } else if (role == 'staff') {
      // Redirect to staff dashboard
    } else {
      // Redirect to user dashboard
    }
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print(e);
      return null;
    }
  }
}*/
}