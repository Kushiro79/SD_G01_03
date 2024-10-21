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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Profile',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.black),
              onPressed: () {
                // Navigate to the Edit Profile screen
                AutoRouter.of(context).push(EditProfileRoute());
              },
            ),
          ],
        ),
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
                            opacity: 0.9,
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
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Column(
                            children: [
                              Text('89',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              Text('Posts',
                                  style: TextStyle(
                                      fontSize: 12, color: Color(0xff64748B))),
                            ],
                          ),
                          Column(
                            children: [
                              Obx(() => Text(
                                  profileController.followersCountString,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))),
                              const Text('Followers',
                                  style: TextStyle(
                                      fontSize: 12, color: Color(0xff64748B))),
                            ],
                          ),
                          Column(
                            children: [
                              Obx(() => Text(
                                  profileController.followingCountString,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))),
                              const Text('Following',
                                  style: TextStyle(
                                      fontSize: 12, color: Color(0xff64748B))),
                            ],
                          ),
                          Card(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width >
                                        800
                                    ? MediaQuery.of(context).size.width * 0.4
                                    : MediaQuery.of(context).size.width *
                                        0.8, // Constrain width to screen size
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Obx(() {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start, // Aligns the title to the left
                                    children: [
                                      const Row(
                                        children: [
                                          Icon(
                                            Icons.verified_user,
                                            color: Colors.greenAccent,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'Verified Qualifications',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                          height:
                                              16), // Adds some spacing between the title and list
                                      ...editController.certificates
                                          .map((certificate) {
                                        return ListTile(
                                          title: Text(
                                              certificate['fieldOfStudy'] ??
                                                  'Unknown Field of Study'),
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
                                              Text(certificate[
                                                      'institutionName'] ??
                                                  'Unknown Institution'),
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
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width > 850
                              ? MediaQuery.of(context).size.width * 0.5
                              : MediaQuery.of(context).size.width *
                                  0.9, // Constrain width to screen size
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Obx(() => Text(
                                    profileController.postCountString,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold))),
                                Text('Posts',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xff64748B))),
                              ],
                            ),
                            Column(
                              children: [
                                Obx(() => Text(
                                    profileController.followersCountString,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold))),
                                const Text('Followers',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xff64748B))),
                              ],
                            ),
                            Column(
                              children: [
                                Obx(() => Text(
                                    profileController.followingCountString,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold))),
                                const Text('Following',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xff64748B))),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width > 850
                              ? MediaQuery.of(context).size.width * 0.5
                              : MediaQuery.of(context).size.width *
                                  0.9, // Constrain width to screen size
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Obx(() {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment
                                  .start, // Aligns the title to the left
                              children: [
                                const Row(
                                  children: [
                                    Icon(
                                      Icons.verified_user,
                                      color: Colors.greenAccent,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Verified Qualifications',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                    height:
                                        16), // Adds some spacing between the title and list
                                ...editController.certificates
                                    .map((certificate) {
                                  return ListTile(
                                    title: Text(certificate['fieldOfStudy'] ??
                                        'Unknown Field of Study'),
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
                                            'Unknown Institution'),
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
                  ]),
            //current user posts
            Expanded(
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
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: MediaQuery.of(context).size.width > 800 ? 300 : 10),
                            child: _ThePost(
                              text: post['Text'],
                              user: post['Username'],
                              imageUrl: post['profileImageUrl'],
                              timestamp: post['Timestamp'],
                              context: context,
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    return const CircularProgressIndicator();
                  },
                ),
              )
          ],
        ));
  }
}
Widget _ThePost({
  required String text,
  required String user,
  required String imageUrl,
  required Timestamp timestamp,
  required BuildContext context,
}) {
  return Container(
    decoration: BoxDecoration(
      color: const Color.fromARGB(206, 255, 255, 255),
      border: Border.all(
        color: Colors.grey,
      ),
      borderRadius: BorderRadius.circular(15),
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
                    color: Colors
                        .grey, // Use a default color or your AppColor.Secondary
                  ),
                  child: const Icon(Icons.person,
                      color: Colors.white), // Optional: Add an icon
                ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 0, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 30),
                Text(text),
              ],
            ),
          ),
          const Spacer(),
          Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Text(DateFormat('dd-MM-yyyy \nhh:mm:ss')
                  .format(timestamp.toDate())
                  )),
        ],
      ),
    ),
  );
}
