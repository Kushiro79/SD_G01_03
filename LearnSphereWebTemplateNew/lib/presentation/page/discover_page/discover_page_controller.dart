import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';


class DiscoverController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxList<DocumentSnapshot> users = RxList<DocumentSnapshot>([]);
  RxList<DocumentSnapshot> followedUsers = RxList<DocumentSnapshot>([]);

    var imageUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    discoverList();
    followingList();
  }

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
      final followersDocRef = _firestore.collection('followers').doc(targetUserId);
      final followersDoc = await followersDocRef.get();

      if (followersDoc.exists) {
        await followersDocRef.update({
          'followerUsers': FieldValue.arrayUnion([userId]),
        });
      } else {
        await followersDocRef.set({
          'followerUsers': [userId],
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

Future<String> loadImageFromFirebase(String profileImageUrl) async {
  try {
    
    // Parse the URL
    print("Profile Image URL: $profileImageUrl");
    Uri uri = Uri.parse(profileImageUrl);

    // Extract the path from the URL (Firebase path starts after the "o/" part)
    String firebasePath = uri.pathSegments.skip(1).join('/'); // Skip the version part, like "v0"

    // Decode the path (in case it's URL-encoded with %2F)
    String decodedPath = Uri.decodeComponent(firebasePath);

    // Extract the actual file path, which is after the 'o/' segment in Firebase URLs
    int startIndex = decodedPath.indexOf('o/') + 2;  // The 'o/' part is included in the URL structure
    String filePath = decodedPath.substring(startIndex);

    print("Extracted Firebase file path: $filePath");

    // Reference to the image in Firebase Storage using the extracted full path
    Reference ref = FirebaseStorage.instance.ref().child(filePath);

    // Get the download URL for the specific file
    String downloadURL = await ref.getDownloadURL();
    return downloadURL; // Return the download URL
  } catch (e) {
    print('Error retrieving image: $e');
    return ''; // Return an empty string if there's an error
  }
}



}
