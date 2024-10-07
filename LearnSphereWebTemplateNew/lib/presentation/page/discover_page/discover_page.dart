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
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              bottom: const TabBar(
                tabs: [
                  Tab(
                    text: 'Discover',
                  ),
                  Tab(text: 'Following'),
                ],
              ),
              title: const Text('Discover'),
            ),
            body: TabBarView (
              controller: controller.tabController,
              children: [
              discoverTab(),
              followingTab(),
            ])));
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
        return const Center(child: CircularProgressIndicator());
      } else {
        return usersLists(controller.followedUsers);
      }
    });
  }

  usersLists(RxList<DocumentSnapshot> usersList) {
    RxMap<String, bool> isFollowingMap = RxMap<String, bool>();

    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: constraints.maxWidth * 0.22, vertical: 10),
          child: ListView.separated(
            itemCount: usersList.length,
            separatorBuilder: (context, index) => const Divider(
              color: AppColor.purple,
            ),
            itemBuilder: (context, index) {
              String userId = usersList[index].id;

              // Initialize following status if not already set
              if (!isFollowingMap.containsKey(userId)) {
                isFollowingMap[userId] =
                    controller.followedUsers.value.any((doc) {
                  return doc.id == userId;
                });
              }

              return Container(
                decoration: BoxDecoration(
                    color: AppColor.Greyscale,
                    borderRadius: BorderRadius.circular(10)),
                width: double.infinity,
                child: SizedBox(
                  child: ListTile(
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
                                      // If the user is following, call the unfollowUser function
                                      await controller.unfollowUser(userId); // Pass the target user ID
                                      isFollowingMap[userId] =false; // Update state to unfollowed
                                    } else {
                                      // If the user is not following, call the followUser function
                                      await controller.followUser(userId); // Pass the target user ID
                                      isFollowingMap[userId] =true; // Update state to followed
                                    }
                                  },
                                  child: Text(isFollowingMap[userId]!
                                      ? 'Following'
                                      : 'Follow'),
                                )),
                          ],
                        ),
                        usersList[index]['credentials'] != null
                            ? Text(usersList[index]['credentials'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ))
                            : const Text(''),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
