import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/app_color.dart';
import '../../theme/gen/fonts.gen.dart';
import 'discover_page_controller.dart';

@RoutePage()
class DiscoverPage extends GetView<DiscoverController> {
  DiscoverPage({super.key});

  final DiscoverController controller = Get.put(DiscoverController());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4, // Floating window size
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95), // Floating window background
          borderRadius: BorderRadius.circular(20), // Rounded corners
        ),
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: Colors.transparent, // No background color
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: const Text(
                'Discover',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              bottom: const TabBar(
                tabs: [
                  Tab(text: 'Discover'),
                  Tab(text: 'Following'),
                ],
              ),
            ),
            body: Container(
              padding: const EdgeInsets.all(20),
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
        return const Text('No users followed yet');
      } else {
        return usersLists(controller.followedUsers);
      }
    });
  }

usersLists(RxList<DocumentSnapshot> usersList) {
  RxMap<String, bool> isFollowingMap = RxMap<String, bool>();

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

      return ListTile(
        dense: false,
        contentPadding: EdgeInsets.all(10),
        leading: usersList[index]['profileImageUrl'] != null
            ? SizedBox(
                height: 40,
                width: 40,
                child: ClipOval(
                  child: Image.network(
                    usersList[index]['profileImageUrl'],
                    fit: BoxFit.fill,
                  ),
                ),
              )
            : const Icon(
                Icons.person,
                size: 40,
              ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                usersList[index]['username'] != null
                    ? Text('@' + usersList[index]['username'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ))
                    : const Text('Unknown User'),
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
                      child: Text(isFollowingMap[userId]! ? 'Following' : 'Follow'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // Change button background color here
                       foregroundColor: Colors.white, // Change text color here
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10), // Adjust padding for button size
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // Adjust this value for less rounded corners
                        ),
                      ),
                    )),
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