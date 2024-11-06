import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/app_color.dart';
import '../../theme/gen/fonts.gen.dart';
import 'discover_page_controller.dart';
import 'package:google_fonts/google_fonts.dart';

@RoutePage()
class DiscoverPage extends GetView<DiscoverController> {
  DiscoverPage({super.key});

  @override
  final DiscoverController controller = Get.put(DiscoverController());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Color(0xFF1A1F3B).withOpacity(0.95), // Floating window background
          borderRadius: BorderRadius.circular(20), // Rounded corners
        ),
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: Colors.transparent, // No background color
            appBar: AppBar(
              foregroundColor: Colors.white,
              elevation: 0,
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: const Text(
                'Discover',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              bottom: const TabBar(
                tabs: [
                  Tab(text: 'Discover', ),
                  Tab(text: 'Following'),
                ],
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Color(0xFF117aca) ,
              ),
            ),
            body: Container(
              padding: const EdgeInsets.all(10),
              child: TabBarView(
                children: [
                  discoverTab(),
                  followingTab(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  discoverTab() {
    return Obx(() {
      controller.discoverList();
      if (controller.users.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      } else {
        return usersLists(controller.users);
      }
    });
  }

  followingTab() {
    return Obx(() {
      controller.followingList();
      if (controller.followedUsers.isEmpty) {
        return const Center(child:Text('No users followed yet', style: TextStyle(color: Colors.white , fontSize: 30, fontWeight: FontWeight.bold),));
      } else {
        return usersLists(controller.followedUsers);
      }
    });
  }

usersLists(RxList<DocumentSnapshot> usersList) {
  RxMap<String, bool> isFollowingMap = RxMap<String, bool>();
  RxMap<String, String> userImageUrls = RxMap<String, String>(); // Store each user's image URL


  return ListView.builder(
    padding: EdgeInsets.zero, // Remove default padding
    itemCount: usersList.length,
    itemBuilder: (context, index) {
      String userId = usersList[index].id;

      // Initialize following status if not already set
        if (!isFollowingMap.containsKey(userId)) {
              isFollowingMap[userId] =
                  controller.followedUsers.value.any((doc) {
                return doc.id == userId;
              });
            }

            // Initialize image URL for each user
            if (!userImageUrls.containsKey(userId)) {
              final profileImagePath = usersList[index]['profileImageUrl'];
              if (profileImagePath != null && !profileImagePath.startsWith('http')) {
                // Fetch image from Firebase Storage asynchronously
                controller.loadImageFromFirebase(profileImagePath).then((url) {
                  userImageUrls[userId] = url; // Store URL when loaded
                });
              } else {
                // Direct URL or no image
                userImageUrls[userId] = profileImagePath ?? '';
              }
            }

      return ListTile(
        dense: false,
        contentPadding: const EdgeInsets.all(10),
        leading: Obx(() {
          // Observe changes to the userImageUrls
          final imageUrl = userImageUrls[userId];
          return imageUrl != null && imageUrl.isNotEmpty
              ? SizedBox(
                  height: 40,
                  width: 40,
                  child: ClipOval(
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.fill,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.person, size: 40),
                    ),
                  ),
                )
              : const Icon(Icons.person, size: 40); // Fallback icon
        }),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                usersList[index]['username'] != null
                    ? Text('@' + usersList[index]['username'],
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color : Colors.white,
                        ))
                    : const Text('Unknown User'),

                    MediaQuery.of(context).size.width > 850 ?
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Obx(() => ElevatedButton(
                      onPressed: () async {
                        if (isFollowingMap[userId]!) {
                          await controller.unfollowUser(userId);
                          isFollowingMap[userId] = false; // Update state to unfollowed
                        } else {
                          await controller.followUser(userId);
                          isFollowingMap[userId] = true; // Update state to followed
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF117aca), // Change button background color here
                        foregroundColor: Colors.white, // Change text color here
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), // Adjust padding for button size
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // Adjust this value for less rounded corners
                        ),
                      ),
                      child: Text(isFollowingMap[userId]! ? 'Following' : 'Follow'),
                    )),
                    const SizedBox(width: 10), // Add space between buttons
                    ElevatedButton(
                    onPressed: () async {
                    // Call the reportUser method in your controller
                    controller.reportUser(context, userId);
                  },
                  style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE57373), // Change button background color here for reporting
                  foregroundColor: Colors.white, // Change text color here
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), // Adjust padding for button size
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Adjust this value for less rounded corners
                  ),
                ),
                child: const Text('Report'),
              ),
                      ],
                    )
                    :
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Obx(() => ElevatedButton(
                      onPressed: () async {
                        if (isFollowingMap[userId]!) {
                          await controller.unfollowUser(userId);
                          isFollowingMap[userId] = false; // Update state to unfollowed
                        } else {
                          await controller.followUser(userId);
                          isFollowingMap[userId] = true; // Update state to followed
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF117aca), // Change button background color here
                        foregroundColor: Colors.white, // Change text color here
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), // Adjust padding for button size
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // Adjust this value for less rounded corners
                        ),
                      ),
                      child: Icon(isFollowingMap[userId]! ? Icons.check : Icons.person_add_alt_rounded),
                    )),
                     const SizedBox(width: 5), // Add space between buttons
                    ElevatedButton(
                    onPressed: () async {
                    // Call the reportUser method in your controller
                    controller.reportUser(context, userId);
                  },
                  style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE57373), // Change button background color here for reporting
                  foregroundColor: Colors.white, // Change text color here
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), // Adjust padding for button size
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Adjust this value for less rounded corners
                  ),
                ),
                child: const Icon(Icons.report_rounded),
              ),

                      ],
                    )

                
              ],
            ),
            usersList[index]['credentials'] != null
                ? Text(usersList[index]['credentials'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ))
                : const SizedBox.shrink(),
          ],
        ),
      );
    },
  );
}
}