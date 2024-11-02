import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../routes/app_router.dart';
import '../../Home_page/home_controller.dart';
import '../controllers/edit_profile_controller.dart';
import '../controllers/profile_screen_controller.dart';
import 'package:intl/intl.dart';
import 'dart:core';
import '../../Home_page/home_screen.dart';

@RoutePage()
class ProfileScreenPage extends StatelessWidget {
  final ProfileScreenController profileController =
      Get.put(ProfileScreenController());
  final EditProfileController editController = Get.put(EditProfileController());
  final HomeController homeController = Get.put(HomeController());

  ProfileScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width >= 800;
    //String bannerImageUrl = editController.bannerImageUrl.value;
    homeController.isAtProfilePage.value = true;
    return Scaffold(
        backgroundColor: const Color(0xFF1A1F3B),
        body: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  //profile banner
                  height: 300,
                  width: double.infinity,
                  child: Obx(() {
                    return editController.bannerImageUrl.isNotEmpty
                        ? Opacity(
                            opacity: 0.7,
                            child: Image.network(
                              editController.bannerImageUrl.value,
                              fit: BoxFit.cover,
                            ))
                        : Image.asset(
                            'assets/background.jpg',
                            fit: BoxFit.cover,
                          );
                  }),
                ),
                Positioned(
                  top: 80, // adjust the value to control the overlap
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Obx(() {
                      return profileController.profileImageUrl.isNotEmpty
                          ? ClipOval(
                              child: Image.network(
                                profileController.profileImageUrl.value,
                                height: 150,
                                width: 150,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Container(
                              margin: const EdgeInsets.only(top: 16),
                              height: 150,
                              width: 150,
                              alignment: Alignment.topLeft,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors
                                    .grey, // Use a default color or your AppColor.Secondary
                              ),
                              child: const Center(
                                  child: Icon(Icons.person,
                                      color: Colors
                                          .white)), // Optional: Add an icon
                            );
                    }),
                  ),
                ),

                // Profile content
              ],
            ),
            const SizedBox(height: 20),
            screenwidth
                ? Card(
                    color: Colors.transparent, // Black with some transparency
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Obx(() => Text(
                                    profileController.postCountString,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white))),
                              const Text('Posts',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255))),
                            ],
                          ),
                          Column(
                            children: [
                              Obx(() => Text(
                                  profileController.followersCountString,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontWeight: FontWeight.bold))),
                              const Text('Followers',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255))),
                            ],
                          ),
                          Column(
                            children: [
                              Obx(() => Text(
                                  profileController.followingCountString,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontWeight: FontWeight.bold))),
                              const Text('Following',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255))),
                            ],
                          ),
                          Card(
                            color: Colors
                                .transparent, // Black with some transparency
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width >
                                        800
                                    ? MediaQuery.of(context).size.width * 0.4
                                    : MediaQuery.of(context).size.width * 0.8,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Obx(() {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Row(
                                        children: [
                                          Icon(
                                            Icons.verified_user,
                                            color: Colors.greenAccent,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            'Verified Qualifications',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      ...editController.certificates
                                          .map((certificate) {
                                        return ListTile(
                                          title: Text(
                                              certificate['fieldOfStudy'] ??
                                                  'Unknown Field of Study',
                                              style: const TextStyle(
                                                  color: Colors.white)),
                                          subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                certificate[
                                                        'levelOfEducation'] ??
                                                    'Unknown Level of Education',
                                                style: TextStyle(
                                                    color: profileController
                                                        .getColorBasedOnContent(
                                                            certificate[
                                                                'levelOfEducation'])),
                                              ),
                                              Text(
                                                  certificate[
                                                          'institutionName'] ??
                                                      'Unknown Institution',
                                                  style: const TextStyle(
                                                      color: Colors.white)),
                                            ],
                                          ),
                                        );
                                      }),
                                    ],
                                  );
                                }),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : Column(children: [
                    Card(
                      color:  Colors
                                .transparent, // Black with some transparency
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width > 850
                              ? MediaQuery.of(context).size.width * 0.5
                              : MediaQuery.of(context).size.width * 0.9,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Obx(() => Text(
                                    profileController.postCountString,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white))),
                                const Text('Posts',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white)),
                              ],
                            ),
                            Column(
                              children: [
                                Obx(() => Text(
                                    profileController.followersCountString,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white))),
                                const Text('Followers',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Color.fromARGB(
                                            255, 255, 255, 255))),
                              ],
                            ),
                            Column(
                              children: [
                                Obx(() => Text(
                                    profileController.followingCountString,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white))),
                                const Text('Following',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Color.fromARGB(
                                            255, 255, 255, 255))),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      color: Color.fromARGB(
                          150, 0, 0, 0), // Black with some transparency
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width > 850
                              ? MediaQuery.of(context).size.width * 0.5
                              : MediaQuery.of(context).size.width * 0.9,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Obx(() {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  children: [
                                    Icon(
                                      Icons.verified_user,
                                      color: Colors.greenAccent,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      'Verified Qualifications',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                ...editController.certificates
                                    .map((certificate) {
                                  return ListTile(
                                    title: Text(certificate['fieldOfStudy'] ??
                                        'Unknown Field of Study',style: TextStyle(color: Colors.white),),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          certificate['levelOfEducation'] ??
                                              'Unknown Level of Education',
                                          style: TextStyle(
                                              color: profileController
                                                  .getColorBasedOnContent(
                                                      certificate[
                                                          'levelOfEducation'])),
                                        ),
                                        Text(certificate['institutionName'] ??
                                            'Unknown Institution',style: TextStyle(color: Colors.white),),
                                      ],
                                    ),
                                  );
                                }),
                              ],
                            );
                          }),
                        ),
                      ),
                    ),
                  ]),

            //current user posts
            //current user posts
Expanded(
  child: ConstrainedBox(
    constraints: BoxConstraints(
      maxWidth: MediaQuery.of(context).size.width > 800
          ? MediaQuery.of(context).size.width * 0.5 // Set the max width for larger screens
          : MediaQuery.of(context).size.width * 0.9, // Set the max width for smaller screens
    ),
    child: StreamBuilder(
      stream: profileController
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: thePost(
                      text: post['Text'],
                      user: post['Username'],
                      uid: post['uid'],
                      imageUrl: post['profileImageUrl'],
                      timestamp: post['Timestamp'],
                      context: context,
                      mediaUrls: mediaUrls,
                      postId: postId,
                      //userId: userId,
                    ),
                  ),
                  if (index < posts.length - 1)
                    const Divider(
                      thickness: 1,
                      color: Colors.grey,
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
  ),
),

          ],
        ));
  }
}
