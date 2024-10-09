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

  @override
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
            body: TabBarView(children: [
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
        return const Text('No users followed yet');
      } else {
        return usersLists(controller.followedUsers);
      }
    });
  }

  usersLists(RxList<DocumentSnapshot> usersList) {
  RxMap<String, bool> isFollowingMap = RxMap<String, bool>();
  RxMap<String, String> userImageUrls = RxMap<String, String>(); // Store each user's image URL

  return LayoutBuilder(
    builder: (context, constraints) {
      return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: constraints.maxWidth > 1080
                ? constraints.maxWidth * 0.22
                : constraints.maxWidth * 0.05,
            vertical: 10),
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

            return Container(
              decoration: BoxDecoration(
                  color: AppColor.Greyscale,
                  borderRadius: BorderRadius.circular(10)),
              width: double.infinity,
              child: SizedBox(
                child: Obx(() {
                  // Observe changes to the userImageUrls
                  final imageUrl = userImageUrls[userId];
                  return ListTile(
                    dense: false,
                    contentPadding: const EdgeInsets.all(10),
                    leading: imageUrl != null && imageUrl.isNotEmpty
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
                        : const Icon(Icons.person, size: 40), // Fallback icon
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
                                      await controller.unfollowUser(userId);
                                      isFollowingMap[userId] = false; // Update state
                                    } else {
                                      // If the user is not following, call the followUser function
                                      await controller.followUser(userId);
                                      isFollowingMap[userId] = true; // Update state
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
                  );
                }),
              ),
            );
          },
        ),
      );
    },
  );
}


}
