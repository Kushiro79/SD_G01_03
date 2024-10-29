import 'package:auto_route/auto_route.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../discussion_page/discussion_screen.dart';
import 'home_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

import '../profile_page/controllers/edit_profile_controller.dart';
import '../../theme/gen/assets.gen.dart';
import '../../routes/app_router.dart';
import '../../page/discover_page/discover_page.dart';

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
          backgroundColor:const Color(0xFF1A1F3B),
          toolbarHeight: 100,
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
                        fontSize: 30,
                        color: Colors.white)),
                Text(
                  "Sphere",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF004ff9),
                      fontSize: 30),
                )
              ]),
        ),
        body: Container(
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
  HomeController homeController = Get.put(HomeController());
  final EditProfileController editController = Get.put(EditProfileController());

  var screenwidth = MediaQuery.of(context).size.width >= 800;

  return Container(
    width: screenwidth ? 300 : 70,
    decoration: const BoxDecoration(
      border: Border(
        right: BorderSide(width: 2, color: Colors.white),
      ),
    ),
    child: ListView(
      padding: EdgeInsets.zero,
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
          hoverColor: Colors.white.withOpacity(0.2),
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
            // Handle tap on Home
          },
        ),
        ListTile(
          hoverColor: Colors.white.withOpacity(0.1),
          leading: Image.asset(
            'assets/profile-2user.png',
            width: 25,
            color: Colors.white,
          ),
          title: screenwidth
              ? const Text(
                  'Follows',
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
                            vertical: 15)
                        : EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
          hoverColor: Colors.white.withOpacity(0.1),
          leading: Image.asset(
            'assets/notification.png',
            width: 25,
            color: Colors.white,
          ),
          title: screenwidth
              ? const Text(
                  'Notifications',
                  style: TextStyle(color: Colors.white),
                )
              : null,
          onTap: () {
            // Handle tap on Notifications
          },
        ),
        ListTile(
          hoverColor: Colors.white.withOpacity(0.1),
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
          hoverColor: Colors.white.withOpacity(0.1),
          leading: const Icon(Icons.bookmark, color: Colors.white),
          title: screenwidth
              ? const Text(
                  'Bookmarks',
                  style: TextStyle(color: Colors.white),
                )
              : null,
          onTap: () {
            // Handle tap on Bookmarks
          },
        ),
        ListTile(
          hoverColor: Colors.white.withOpacity(0.1),
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
          hoverColor: Colors.white.withOpacity(0.1),
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
            context.router.push(SettingsRoute());
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
                  screenwidth // Ensure `screenwidth` is a boolean or has a boolean check
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
  return LayoutBuilder(builder: (context, constraints) {
    return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width > 850
              ? MediaQuery.of(context).size.width * 0.5
              : MediaQuery.of(context).size.width * 0.85,
        ),
        child: Center(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 1.5,
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
                              allowedExtensions: ['jpg', 'png', 'jpeg', 'mp4'],
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
                        List<String> mediaUrls = List<String>.from(
                            (post['mediaUrls'] ?? []).map((url) =>
                                url.toString()) // Ensure each URL is a string
                            );
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: _ThePost(
                                text: post['Text'],
                                user: post['Username'],
                                imageUrl: post['profileImageUrl'],
                                timestamp: post['Timestamp'],
                                context: context,
                                mediaUrls: mediaUrls,
                              ),
                            ),
                            if (index < posts.length - 1)
                              const Divider(
                                thickness: 1,
                                color: Colors
                                    .grey, // Customize the divider's appearance if needed
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

Widget _ThePost({
  required String text,
  required String user,
  required String imageUrl,
  required Timestamp timestamp,
  required List<String> mediaUrls, // Accept media URLs as a parameter
  required BuildContext context,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.transparent,
    ),
    child: Padding(
      padding: const EdgeInsets.only(top: 10, left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          imageUrl.isNotEmpty
              ? ClipOval(
                  child: Image.network(
                    imageUrl,
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                )
              : Container(
                  margin: const EdgeInsets.only(top: 16),
                  height: MediaQuery.of(context).size.height > 850 ? 50 : 20,
                  width: MediaQuery.of(context).size.height > 850 ? 50 : 20,
                  alignment: Alignment.topLeft,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                  child: const Icon(Icons.person, color: Colors.white),
                ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 0, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
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
                                    width: MediaQuery.of(context).size.width >
                                            800
                                        ? MediaQuery.of(context).size.width *
                                            0.3
                                        : MediaQuery.of(context).size.width *
                                            0.50,
                                    child: VideoPlayerWidget(videoUrl: url),
                                  ))
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    url,
                                    width: MediaQuery.of(context).size.width >
                                            800
                                        ? MediaQuery.of(context).size.width *
                                            0.3
                                        : MediaQuery.of(context).size.width *
                                            0.50,
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
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(
                  DateFormat('dd-MM-yyyy \nhh:mm:ss')
                      .format(timestamp.toDate()),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
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
