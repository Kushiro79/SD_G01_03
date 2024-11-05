import 'package:auto_route/auto_route.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../discussion_page/discussion_screen.dart';
import '../notification_screen/notification_view.dart';
import '../profile_page/controllers/profile_screen_controller.dart';
import '../profile_page/views/profile_screen_view.dart';
import 'home_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

import '../profile_page/controllers/edit_profile_controller.dart';
import '../../theme/gen/assets.gen.dart';
import '../../routes/app_router.dart';
import '../../page/discover_page/discover_page.dart';
import '../comment_post/comment_screen.dart';
import 'package:share_plus/share_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';

@RoutePage()
class MyHomePage extends GetView<HomeController> {
  MyHomePage({super.key});

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width > 850;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF1A1F3B),
          toolbarHeight: screenwidth ? 100 : 80,
          title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image(
                  image: AssetImage(ProjectAssets.learnSphereLogo.path),
                  width: screenwidth ? 80 : 60,
                  height: screenwidth ? 80 : 60,
                ),
                const SizedBox(width: 20),
                Text("Learn",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: screenwidth ? 30 : 20,
                        color: Colors.white)),
                Text(
                  "Sphere",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF004ff9),
                    fontSize: screenwidth ? 30 : 20,
                  ),
                )
              ]),
        ),
        body: Container(
            padding: EdgeInsets.zero,
            decoration: const BoxDecoration(
              color: Color(0xFF1A1F3B),
            ), // add this to avoid errors
            child: Row(children: [
              _buildSidebar(context),
              Expanded(
                  child: Center(
                child: _buildPost(),
              ))
            ])));
  }
}

Widget _buildSidebar(BuildContext context) {
  final ProfileScreenController profileController =
      Get.put(ProfileScreenController());
  final HomeController homeController = Get.put(HomeController());
  final EditProfileController editController = Get.put(EditProfileController());

  var screenwidth = MediaQuery.of(context).size.width >= 800;
  return Container(
    width: screenwidth ? 300 : 70,
    decoration: BoxDecoration(
      border: Border(
        right: BorderSide(width: 1, color: Colors.white.withOpacity(0.5)),
      ),
    ),
    child: ListView(
      children: [
        SizedBox(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(() {
                  return editController.profileImageUrl.isNotEmpty
                      ? ClipOval(
                          child: Image.network(
                            editController.profileImageUrl.value,
                            height: screenwidth ? 120 : 40,
                            width: screenwidth ? 120 : 40,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Container(
                          margin: const EdgeInsets.only(top: 16),
                          height: screenwidth ? 120 : 40,
                          width: screenwidth ? 120 : 40,
                          alignment: Alignment.topLeft,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors
                                .grey, // Use a default color or your AppColor.Secondary
                          ),
                          child: const Center(
                              child: Icon(Icons.person,
                                  color:
                                      Colors.white)), // Optional: Add an icon
                        );
                }),
                const SizedBox(height: 10),
                screenwidth
                    ? Obx(() {
                        return Text(
                          '@ ${editController.username.value}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Urbanist-semibold',
                              fontWeight: FontWeight.w600),
                          softWrap: true,
                          overflow: TextOverflow.visible,
                        );
                      })
                    : const SizedBox()
              ],
            ),
          ),
        ),
        ListTile(
          leading: Image.asset(
            'assets/home.png',
            width: 25,
            color: Colors.white,
          ),
          title: screenwidth
              ? const Text(
                  'Home',
                  style: TextStyle(color: Colors.white),
                )
              : null,
          onTap: () {
            homeController.getPostsStream(homeController.auth.currentUser!.uid);
          },
        ),
        ListTile(
          leading: Image.asset(
            'assets/profile-2user.png',
            width: 25,
            color: Colors.white,
          ),
          title: screenwidth
              ? const Text(
                  'Discover',
                  style: TextStyle(color: Colors.white),
                )
              : null,
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                    insetPadding: MediaQuery.of(context).size.width > 850
                        ? EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width * 0.3,
                            vertical: MediaQuery.of(context).size.height * 0.2)
                        : EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: MediaQuery.of(context).size.height * 0.2),
                    backgroundColor: Colors.transparent,
                    child:
                        DiscoverPage() // Transparent background for floating window
                    // Show the DiscoverPage as a floating window
                    );
              },
            );
          },
        ),
        ListTile(
          leading: Stack(
            clipBehavior: Clip.none,
            children: [
              Image.asset(
                'assets/notification.png',
                width: 25,
                color:
                    homeController.comments.isEmpty ? Colors.white : Colors.red,
              ),
              if (homeController.comments.isNotEmpty)
                Positioned(
                  top: -5,
                  right: 0,
                  child: Container(
                    width: 15,
                    height: 15,
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
          title: screenwidth
              ? const Text(
                  'Notifications',
                  style: TextStyle(color: Colors.white),
                )
              : null,
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  insetPadding: MediaQuery.of(context).size.width > 850
                      ? EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.3,
                          vertical: MediaQuery.of(context).size.height * 0.2)
                      : EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: MediaQuery.of(context).size.height * 0.2),
                  backgroundColor: Colors.transparent,
                  child: const NotificationView(),
                );
              },
            );
          },
        ),
        ListTile(
          leading: Image.asset(
            'assets/people.png',
            width: 25,
            color: Colors.white,
          ),
          title: screenwidth
              ? const Text(
                  'Discussion',
                  style: TextStyle(color: Colors.white),
                )
              : null,
          onTap: () {
            // print('ListTile tapped!');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DiscussionPage()),
            );
            // Handle tap on Messages
          },
        ),
        ListTile(
          leading: Image.asset(
            'assets/profile.png',
            width: 25,
            color: Colors.white,
          ),
          title: screenwidth
              ? const Text(
                  'Profile',
                  style: TextStyle(color: Colors.white),
                )
              : null,
          onTap: () {
            context.router.push(ProfileRouteRoute());
          },
        ),
        ListTile(
          leading: Image.asset(
            'assets/setting.png',
            width: 25,
            color: Colors.white,
          ),
          title: screenwidth
              ? const Text(
                  'Settings',
                  style: TextStyle(color: Colors.white),
                )
              : null,
          onTap: () {
            context.router.push(const SettingsRoute());
          },
        ),
        Obx(() {
          if (homeController.isStaffOrAdmin.value) {
            return ListTile(
              hoverColor: Colors.white.withOpacity(0.1),
              leading: const Icon(
                Icons.swap_calls,
                color: Colors.white,
              ),
              title:
                  screenwidth // Ensure screenwidth is a boolean or has a boolean check
                      ? const Text(
                          'Change Mode',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        )
                      : null,
              onTap: () {
                // Navigate to homepage if currently in main page
                context.router.push(MainRoute());
              },
            );
          } else {
            return const SizedBox.shrink();
          }
        }),
      ],
    ),
  );
}

Widget _buildPost() {
  HomeController homeController = Get.put(HomeController());
  String userId = homeController.auth.currentUser!.uid;
  return LayoutBuilder(builder: (context, constraints) {
    return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width > 850
              ? MediaQuery.of(context).size.width * 0.5
              : MediaQuery.of(context).size.width * 0.9,
        ),
        child: Center(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white.withOpacity(0.5),
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.transparent,
                ),
                padding: const EdgeInsets.all(
                    10), // Optional padding for the container
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Align children to the start
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          // Post Text field
                          Expanded(
                            child: _buildTextField(
                              hintText: 'What\'s on your mind?',
                              controller: homeController.postText,
                              onChanged: (value) {
                                homeController.changeText(value);
                              },
                              obscureText: false,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            onPressed: homeController.postMessage,
                            icon: const Icon(
                              Icons.send,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    homeController.buildHoverableImages(homeController),
                    // Row for multiple icons (e.g., pictures, videos)
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly, // Space evenly
                      children: [
                        IconButton(
                          onPressed: () async {
                            // Handle photos action
                            final result = await FilePicker.platform.pickFiles(
                              type: FileType.custom,
                              allowedExtensions: [
                                'jpg',
                                'png',
                                'jpeg',
                              ],
                            );
                            if (result == null) return;

                            for (var file in result.files) {
                              if (file.bytes != null) {
                                // Determine if file is image or video based on extension
                                final isImage = ['jpg', 'png', 'jpeg']
                                    .contains(file.extension);
                                homeController.addFile(
                                    file.bytes!, isImage ? 'image' : 'video');
                              }
                            }
                          },
                          icon: const Icon(
                            Icons.photo,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            // Handle videos action
                            final result = await FilePicker.platform.pickFiles(
                              type: FileType.custom,
                              allowedExtensions: ['mp4'],
                            );
                            if (result == null) return;

                            for (var file in result.files) {
                              if (file.bytes != null) {
                                // Determine if file is image or video based on extension
                                final isImage = ['jpg', 'png', 'jpeg']
                                    .contains(file.extension);
                                homeController.addFile(
                                    file.bytes!, isImage ? 'image' : 'video');
                              }
                            }
                          },
                          icon: const Icon(
                            Icons.videocam,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            // Handle other media action
                          },
                          icon: const Icon(
                            Icons.attach_file,
                            color: Colors.white,
                          ), // Example for attachments
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: homeController
                    .getPostsStream(homeController.auth.currentUser!.uid),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var posts = snapshot.data as List<DocumentSnapshot>;
                    return ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        final post = posts[index];
                        String postId = post.id;

                        List<String> mediaUrls = List<String>.from(
                            (post['mediaUrls'] ?? []).map((url) =>
                                url.toString()) // Ensure each URL is a string
                            );
                        // String userId = homeController.auth.currentUser!.uid; // Get user ID here
                        return Column(
                          children: [
                            thePost(
                              text: post['Text'],
                              user: post['Username'],
                              uid: post['uid'],
                              imageUrl: post['profileImageUrl'],
                              timestamp: post['Timestamp'],
                              context: context,
                              mediaUrls: mediaUrls,
                              postId: postId,
                              userId: userId,
                              likesCount: post['likes'].length,
                              //likesCount: post['likesCount']??0,
                            ),
                          ],
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.white,
                  ));
                },
              ),
            )
          ]),
        ));
  });
}

Widget _buildTextField({
  required TextEditingController controller,
  required String hintText,
  required Function(String) onChanged,
  bool obscureText = false,
  Widget? suffixIcon,
}) {
  return TextField(
    onChanged: onChanged,
    obscureText: obscureText,
    maxLines: null,
    minLines: 1,
    decoration: InputDecoration(
      hintText: hintText,
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: Colors.white,
      labelStyle: const TextStyle(fontSize: 12),
      contentPadding:
          const EdgeInsets.only(left: 30, right: 15, top: 10, bottom: 10),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(15),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(15),
      ),
    ),
  );
}

Widget thePost({
  required String text,
  required String user,
  required String uid,
  required String imageUrl,
  required Timestamp timestamp,
  required List<String> mediaUrls,
  required BuildContext context,
  required String postId, // Pass the post ID to the widget
  required String userId,
  required int likesCount,
  //required int likesCount,
}) {
  HomeController homeController = Get.put(HomeController());

  //final HomeController homeController = Get.find(); // Get the HomeController instance
// Function to toggle like

  return Container(
    decoration: const BoxDecoration(
      color: Colors.transparent,
    ),
    child: Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 5, 0, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        imageUrl.isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: ClipOval(
                                  child: Image.network(
                                    imageUrl,
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : Container(
                                margin: const EdgeInsets.only(top: 16),
                                height: MediaQuery.of(context).size.height > 850
                                    ? 50
                                    : 20,
                                width: MediaQuery.of(context).size.height > 850
                                    ? 50
                                    : 20,
                                alignment: Alignment.topLeft,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey,
                                ),
                                child: const Icon(Icons.person,
                                    color: Colors.white),
                              ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          user,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),
                    Text(
                      text,
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    // Display the media
                    mediaUrls.isNotEmpty
                        ? Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children: mediaUrls.map((url) {
                              return url.contains('.mp4')
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width >
                                                    800
                                                ? MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.3
                                                : MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.75,
                                        child: VideoPlayerWidget(videoUrl: url),
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        url,
                                        width:
                                            MediaQuery.of(context).size.width >
                                                    800
                                                ? MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.3
                                                : MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.75,
                                        height: 300,
                                        fit: BoxFit.cover,
                                      ),
                                    );
                            }).toList(),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Obx(() {
                    return homeController.isStaffOrAdmin.value ||
                            homeController.isAtProfilePage.value
                        ? PopupMenuButton<String>(
                            icon: const Icon(Icons.more_vert,
                                color: Colors.white),
                            onSelected: (value) {
                              // Handle the selection
                              if (value == 'Delete') {
                                // Show confirmation dialog
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Confirm Deletion'),
                                      content: const Text(
                                          'Are you sure you want to delete this post?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(); // Close the dialog
                                          },
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            homeController.deletePost(
                                                uid, postId.trim());
                                            Navigator.of(context)
                                                .pop(); // Close the dialog
                                          },
                                          child: const Text('Delete'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            itemBuilder: (BuildContext context) {
                              return [
                                const PopupMenuItem<String>(
                                  value: 'Delete',
                                  child: Text('Delete Post'),
                                ),
                              ];
                            },
                          )
                        : const SizedBox
                            .shrink(); // If not staff/admin, display nothing
                  }),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10), // Space between the post and buttons
          Container(
            decoration:  BoxDecoration(
              //make visible line top and under
              border: Border(
                top: BorderSide(
                  color: Colors.white.withOpacity(0.5),
                  width: 0.5,
                ),
                bottom: BorderSide(
                  color: Colors.white.withOpacity(0.5),
                  width: 0.5,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Text(
                    'Likes $likesCount',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    DateFormat('dd-MM-yyyy hh:mm:ss')
                        .format(timestamp.toDate()),
                    style: const TextStyle(color: Colors.white60, fontSize: 10),
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration:  BoxDecoration(
              //make visible line top and under
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withOpacity(0.5),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.thumb_up, color: Colors.white),
                  onPressed: () {
                    homeController.toggleLike(userId, postId);
                  }, // Call the toggleLike function
                ),
                IconButton(
                  icon: const Icon(Icons.comment, color: Colors.white),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            insetPadding: MediaQuery.of(context).size.width >
                                    850
                                ? EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width * 0.3,
                                    vertical: 15)
                                : EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 15),
                            backgroundColor: Colors.transparent,
                            child: CommentScreen(postId: postId),
                          );
                        });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.share, color: Colors.white),
                  onPressed: () {
                    // Call the sharePost method from the HomeController
                    HomeController homeController = Get.find();

                    // Assuming you have access to the post text and media URLs
                    String postText =
                        text; // This should be the actual post text
                    List<String> mediaUrls =
                        []; // Fetch or pass the actual media URLs

                    homeController.sharePost(postText, mediaUrls);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.report,
                      color: Colors.red), // Report icon
                  onPressed: () {
                    // Create a TextEditingController to manage the input field
                    TextEditingController reasonController =
                        TextEditingController();

                    // Show confirmation dialog
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: Colors.black,
                        title: const Row(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween, // Aligns items on opposite ends
                          children: [
                            Text(
                              "Report Post",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                                "Are you sure you want to report this post?",
                                style: TextStyle(color: Colors.white)),
                            const SizedBox(height: 10),
                            TextField(
                              style: TextStyle(color: Colors.white),
                              controller:
                                  reasonController, // Set the controller
                              decoration: const InputDecoration(
                                labelText: "Reason (required)",
                                hintText: "Enter your reason for reporting",
                                labelStyle: TextStyle(color: Colors.white),
                                hintStyle: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              String reason = reasonController
                                  .text; // Get text from the controller

                              if (reason.isNotEmpty) {
                                // Get the current user ID
                                User? user = FirebaseAuth.instance.currentUser;
                                String userId = user?.uid ??
                                    'unknown_user'; // Handle case if user is not logged in

                                // Call the reportPost method
                                await reportPost(context, postId, userId,
                                    reason: reason);

                                // Close the report confirmation dialog
                                Navigator.of(context).pop();

                                // Show the success dialog
                                showDialog(
                                  context:
                                      context, // Same context is used for success dialog
                                  builder: (context) => AlertDialog(
                                    backgroundColor: Colors.black,
                                    title: const Text("Success",
                                        style: TextStyle(color: Colors.white)),
                                    content: const Text(
                                        "Post has been reported successfully.",
                                        style: TextStyle(color: Colors.white)),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Close the success dialog
                                          reasonController.clear();
                                          Navigator.of(context)
                                              .pop(); // Clear the text field after success dialog is closed
                                        },
                                        child: const Text(
                                          "OK",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                // Show a message if the reason is empty
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                    "Please enter a reason.",
                                    style: TextStyle(color: Colors.white),
                                  )),
                                );
                              }
                            },
                            child: const Text(
                              "Yes",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pop(); // Close the report dialog
                              reasonController
                                  .clear(); // Clear the text field when dialog closes
                            },
                            child: const Text(
                              "No",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Future<void> reportPost(BuildContext context, String postId, String userId,
    {String? reason}) async {
  // Access your controller and call the method to report the post
  HomeController homeController = Get.find();
  await homeController.reportPost(postId, userId,
      reason: reason); // Ensure this is awaited if it's an async call

  // After reporting, show success dialog
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Success"),
      content: const Text("Post has been reported successfully."),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(), // Close the dialog
          child: const Text("OK"),
        ),
      ],
    ),
  );
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized.
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Display the video
        _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : Center(child: CircularProgressIndicator()), // Loading indicator

        // Add play/pause buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _controller.value.isPlaying
                      ? _controller.pause()
                      : _controller.play();
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.stop, color: Colors.white),
              onPressed: () {
                setState(() {
                  _controller.pause();
                  _controller.seekTo(Duration.zero); // Reset to start
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}
