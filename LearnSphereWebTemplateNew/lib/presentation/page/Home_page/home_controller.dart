import 'dart:typed_data';

import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rxdart/rxdart.dart' as rxdart;
import 'package:file_picker/file_picker.dart';

import 'package:share_plus/share_plus.dart';
import '../profile_page/controllers/edit_profile_controller.dart';

class HomeController extends GetxController {
  final postText = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  var pickedMedia = <Map<String, dynamic>>[].obs;
  RxBool isStaffOrAdmin = false.obs;
  RxBool isAtProfilePage = false.obs;
  var comments = <Map<String, dynamic>>[].obs;


  void addFile(Uint8List bytes, String type) {
    pickedMedia.add({"bytes": bytes, "type": type});
  }

  @override
  void onReady() {
    super.onReady();
    userUsername();
    checkUserRole();
    _fetchComments();
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

  void changeText(String value) {
    postText.text = value; // Update the controller's text
  }

  Future<void> _fetchComments() async {
    String currentUserUid = auth.currentUser!.uid;

    //Listen for comments on posts by the current user
    firestore
        .collection('posts')
        .doc(currentUserUid)
        .collection('myPosts')
        .snapshots()
        .listen((snapshot) {
      snapshot.docs.forEach((postDoc) {
        String postId = postDoc.id;

        //listen for unread comments on each post
        firestore
            .collection('comments')
            .where('postId', isEqualTo: postId)
            .where('isRead', isEqualTo: false)
            .snapshots()
            .listen((commentSnapshot) {
          
            comments.value = commentSnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
        });
      });
    });
  }

  Widget buildHoverableImages(HomeController homeController) {
    return Obx(() {
      if (homeController.pickedMedia.isEmpty) {
        return const SizedBox(); // No media to display
      }

      return Wrap(
        spacing: 8.0, // Spacing between items
        runSpacing: 8.0,
        children: homeController.pickedMedia.asMap().entries.map((entry) {
          int index = entry.key;
          Uint8List mediaData = entry.value["bytes"];
          String mediaType = entry.value["type"];
          final hover = false.obs;
          return MouseRegion(
            onEnter: (_) => hover.value = true,
            onExit: (_) => hover.value = false,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Display the image or video icon
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: mediaType == 'image'
                      ? Image.memory(
                          mediaData,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          width: 100,
                          height: 100,
                          color: Colors.grey[800],
                          child: Icon(
                            Icons.videocam,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                ),
                // Display the overlay 'X' button on hover
                Obx(() => Visibility(
                      visible: hover.value,
                      child: Positioned(
                        top: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: () {
                            // Remove the media from the list
                            homeController.pickedMedia.removeAt(index);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.7),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          );
        }).toList(),
      );
    });
  }

  Future<void> userUsername() async {
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

  //post message
  void postMessage() async {
    EditProfileController editController = Get.put(EditProfileController());
    User? user = auth.currentUser;
    final userId = user!.uid;

    if (postText.text.isNotEmpty) {
      // Create a list to hold the download URLs of the uploaded media
      List<String> mediaUrls = [];

      for (var media in pickedMedia) {
        Uint8List mediaBytes = media["bytes"];
        String mediaType = media["type"];

        // Generate a unique file name
        String fileName =
            '${userId}_${DateTime.now().millisecondsSinceEpoch}.${mediaType == 'image' ? 'jpg' : 'mp4'}';

        // Upload to Firebase Storage
        Reference storageRef =
            FirebaseStorage.instance.ref().child('uploads/$fileName');

        UploadTask uploadTask = storageRef.putData(mediaBytes);
        TaskSnapshot taskSnapshot = await uploadTask;

        // Get the download URL after successful upload
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();
        mediaUrls.add(downloadUrl);
      }

      // Add the post document to Firestore with media URLs
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(userId)
          .collection('myPosts')
          .add({
        'profileImageUrl': editController.profileImageUrl.value,
        'uid' : userId,
        'Username': username.value,
        'Text': postText.text,
        'certificate': editController.certificate.value,
        'Timestamp': Timestamp.now(),
        'mediaUrls': mediaUrls, // Store the list of media URLs
      });

      print(
          'Post created with username: ${username.value}, Text: ${postText.text}, Timestamp: ${Timestamp.now()}, mediaUrls: $mediaUrls');

      // Optionally clear the picked media after posting
      pickedMedia.clear();
    } else {
      print('Please enter some text');
    }
  }

  Stream<List<DocumentSnapshot>> getPostsStream(String userId) async* {
    await checkUserRole();
    //Step 1: Create a list to hold streams of posts
    List<Stream<List<DocumentSnapshot>>> streams = [];

    if (isStaffOrAdmin.value == true) {
      print('Admin/Staff detected. Loading posts from all users.');

      // If the user is an admin or staff, add all users' post streams
      QuerySnapshot allUsers =
          await FirebaseFirestore.instance.collection('users').get();

      for (var user in allUsers.docs) {
        String userId = user.id;
        streams.add(FirebaseFirestore.instance
            .collection('posts')
            .doc(userId)
            .collection('myPosts')
            .orderBy('Timestamp', descending: true)
            .snapshots()
            .map((snapshot) => snapshot.docs));
      }
    } else {
      // Step 1: Get the list of user IDs the current user is following
      DocumentSnapshot followingDoc = await FirebaseFirestore.instance
          .collection('following')
          .doc(userId)
          .get();

      List<String> followingList =
          List<String>.from(followingDoc['followedUsers'] ?? []);

      // Add the current user's posts to the list of streams
      streams.add(FirebaseFirestore.instance
          .collection("posts")
          .doc(userId)
          .collection('myPosts')
          .orderBy("Timestamp", descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs));

      // Step 3: For each followed user, get their posts
      for (String followingUserId in followingList) {
        streams.add(FirebaseFirestore.instance
            .collection("posts")
            .doc(followingUserId)
            .collection('myPosts')
            .orderBy("Timestamp", descending: true)
            .snapshots()
            .map((snapshot) => snapshot.docs));
      }
    }
    // Step 4: Combine all the streams into a single stream
    yield* rxdart.Rx.combineLatest(streams, (values) {
      // Flatten the list of lists into a single list
      return values.expand((list) => list).toList();
    });
  }

  Future<void> checkUserRole() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userId = user.uid;
      final firestore = FirebaseFirestore.instance;

      try {
        final userData = await firestore.collection('users').doc(userId).get();
        final userRole = userData['role'];

        if (userRole == 'staff' || userRole == 'admin') {
          // User is a staff or admin
          isStaffOrAdmin.value = true;
          print('isStaffOrAdmin: $isStaffOrAdmin');
        } else {
          // User is not a staff or admin
          isStaffOrAdmin.value = false;
          print('isStaffOrAdmin: $isStaffOrAdmin');
        }
      } catch (e) {
        print('Error checking user role: $e');
      }
    }
  }

  Future<void> deletePost(String uid, String postId) async {
  User? currentUser  = FirebaseAuth.instance.currentUser ;
  if (currentUser  == null) {
      _showDialog('Error', 'User  not authenticated', Colors.red);
      return;
    }
  try {
    // Fetch the user document for the post owner
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();
    // Check if the user exists
    if (!userSnapshot.exists) {
      print("User does not exist");
      return;
    }
    print("Post exists. Deleting post...");

    // Fetch the post document for the user who owns the post
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(uid) // Use the UID to find the user's posts
        .collection('myPosts')
        .doc(postId)
        .delete();
    
    print("Delete successful...");

  } catch (e) {
    print("Error deleting post: $e");
  }
}

// Function to show dialog
void _showDialog(String title, String content, Color titleColor) {
  showDialog(
    context: Get.context!,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.transparent.withOpacity(0.13),
        title: Text(title, style: TextStyle(color: titleColor)),
        content: Text(content, style: TextStyle(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('OK', style: TextStyle(color: Colors.white)),
          ),
        ],
      );
    },
  );
}

void sharePost(String postText, List<String> mediaUrls) {
    String content = postText; // Prepare the content to share

    if (mediaUrls.isNotEmpty) {
      content += '\nCheck this out: ${mediaUrls.join(', ')}';
    }

    Share.share(content, subject: 'Check out this post!');
  }

  
Future<void> reportPost(String postId, String userId, {String? reason}) async {
    // Firestore operation (make sure this is awaited)
    await firestore.collection('report_post').add({
      'postId': postId,
      'userId': userId,
      'reason': reason ?? 'No reason provided',
      'timestamp': Timestamp.now(),
    });
  }

  Future<void> toggleLike(String userId, String postId) async {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;
    if (currentUserId == null) return; // Ensure user is logged in

    // Reference to the specific post in the subcollection
    final postRef = FirebaseFirestore.instance
        .collection('posts')
        .doc(userId) // The owner of the post
        .collection('myPosts')
        .doc(postId);

    final postSnapshot = await postRef.get();



    final List<dynamic> likes = postSnapshot['likes'] ?? [];

    if(!postSnapshot.exists){
      print('Post does not exist');
      return;
    }

    if (likes.contains(currentUserId)) {
        // If the user has already liked the post, remove their ID from the array
        await postRef.update({
            'likes': FieldValue.arrayRemove([currentUserId])
        });
    } else {
        // If the user has not liked the post, add their ID to the array
        await postRef.update({
            'likes': FieldValue.arrayUnion([currentUserId])
        });
    }


   
  }



}


