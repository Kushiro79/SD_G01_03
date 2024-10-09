import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class DiscoverController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxList<DocumentSnapshot> users = RxList<DocumentSnapshot>([]);
  RxList<DocumentSnapshot> followedUsers = RxList<DocumentSnapshot>([]);

  Future<void> discoverList() async {
  final userId = _auth.currentUser?.uid;

  if (userId != null) {
    try {
      // Fetch the 'following' document for the current user
      final discoverDoc =
          await _firestore.collection('following').doc(userId).get();

      if (discoverDoc.exists) {
        // Extract the UIDs from the 'followedUsers' array
        final followingData = discoverDoc.data();
        if (followingData != null && followingData.containsKey('followedUsers')) {
          // Collect all UIDs from the 'followedUsers' array
          final followingUids = List<String>.from(followingData['followedUsers']);

          print('Following UIDs: $followingUids'); // Print the list of UIDs

          // Query the 'users' collection to get details of users not following the current user
          final userDoc = await _firestore
              .collection('users')
              .where('uid', isNotEqualTo: userId) // Exclude the current user
              .get();
          
          users.value = userDoc.docs.where((doc) {
            final uid = doc['uid'];
            return !followingUids.contains(uid); // Only include users not in followingUids
          }).toList();
        } else {
          users.value = [];
        }
      } else {
        _firestore.collection('following').doc(userId).set({
          'followedUsers': [],
        });
        await discoverList();
      }
    } catch (e) {
      print('Error fetching discover list: $e');
      users.value = [];
    }
  }
}

Future<void> followingList() async {
  final userId = _auth.currentUser?.uid;

  if (userId != null) {
    try {
      // Fetch the 'following' document for the current user
      final followingDoc =
          await _firestore.collection('following').doc(userId).get();

      if (followingDoc.exists) {
        // Extract the UIDs from the 'followedUsers' array
        final followingData = followingDoc.data();
        if (followingData != null && followingData.containsKey('followedUsers')) {
          // Collect all UIDs from the 'followedUsers' array
          final followingUids = List<String>.from(followingData['followedUsers']);

          print('Following UIDs: $followingUids'); // Print the list of UIDs

          // Query the 'users' collection to get details of users following the current user
          final usersQuery = await _firestore
              .collection('users')
              .where('uid', whereIn: followingUids)
              .get();

          followedUsers.value =
              usersQuery.docs.map((doc) => doc as DocumentSnapshot).toList();
        } else {
          followedUsers.value = [];
          Text('No User Followed',);
        }
      } else {
        _firestore.collection('following').doc(userId).set({
          'followedUsers': [],
        });
        await followingList();
      }
    } catch (e) {
      print('Error fetching following list: $e');
      followedUsers.value = [];
    }
  }
}


  Future<void> followUser(String targetUserId) async {
  final userId = _auth.currentUser?.uid;

  if (userId != null && targetUserId.isNotEmpty) {
    try {
      final followingDocRef = _firestore.collection('following').doc(userId); // Fetch the current user's following document
      final followingDoc = await followingDocRef.get();

      if (followingDoc.exists) {
        // If the document exists, add the target user's UID to the array
        await followingDocRef.update({
          'followedUsers': FieldValue.arrayUnion([targetUserId]),
        });
      } else {
        // If the following document doesn't exist, create it and add the target UID
        await followingDocRef.set({
          'followedUsers': [targetUserId],
        });
      }

      print('Successfully followed user: $targetUserId');
    } catch (e) {
      print('Error following user: $e');
    }
  } else {
    print('Invalid user ID or target user ID.');
  }
}

Future<void> unfollowUser(String targetUserId) async {
  final userId = _auth.currentUser?.uid;
  if (userId != null && targetUserId.isNotEmpty) {
    try {
      final followingDocRef = _firestore.collection('following').doc(userId);
      final followingDoc = await followingDocRef.get();

      if (followingDoc.exists) {
        // If the document exists, remove the target user's UID from the array
        await followingDocRef.update({
          'followedUsers': FieldValue.arrayRemove([targetUserId]),
        });
        print('Successfully unfollowed user: $targetUserId');
      } else {
        print('Following document does not exist.');
      }
    } catch (e) {
      print('Error unfollowing user: $e');
    }
  } else {
    print('Invalid user ID or target user ID.');
  }
}

}
