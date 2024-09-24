import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_controller.dart';

import '../../theme/palette.dart';
import '../../theme/gen/assets.gen.dart';
import '../../routes/app_router.dart';
import '../../utils/color_extension.dart';
import 'showimage_view.dart';

@RoutePage()
class MyHomePage extends GetView<HomeController> {
  MyHomePage({super.key});

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width > 850;

    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          toolbarHeight: 80,
          title: Row(children: <Widget>[
            Image(
              color: Colors.black,
              image: AssetImage(ProjectAssets.learnSphereLogo.path),
              width: screenwidth ? 300 : 80,
              height: screenwidth ? 100 : 80,
            ),
          ]),
        ),
        body: Row(
            children: [_buildSidebar(context), Expanded(child: _buildPost())]));
  }
}

Widget _buildSidebar(BuildContext context) {
  HomeController homeController = Get.put(HomeController());

  var screenwidth = MediaQuery.of(context).size.width >= 800;

  return Container(
    width: MediaQuery.of(context).size.width *
        0.2, // Adjust the width to your liking
    decoration: BoxDecoration(
      border: Border(
        right: BorderSide(width: 1, color: Colors.grey),
      ),
    ),
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/01.png'),
              ),
              Text('@${homeController.username}') // Listen to username changes
            ],
          ),
        ),
        ListTile(
          leading: Image.asset(
            'assets/home.png',
            width: 25,
            color: Colors.black,
          ),
          title: screenwidth ? const Text('Home') : null,
          onTap: () {
            // Handle tap on Home
          },
        ),
        ListTile(
          leading: Image.asset(
            'assets/profile-2user.png',
            width: 25,
            color: Colors.black,
          ),
          title: screenwidth ? Text('Follows') : null,
          onTap: () {
            // Handle tap on Explore
          },
        ),
        ListTile(
          leading: Image.asset(
            'assets/notification.png',
            width: 25,
            color: Colors.black,
          ),
          title: screenwidth ? const Text('Notifications') : null,
          onTap: () {
            // Handle tap on Notifications
          },
        ),
        ListTile(
          leading: Image.asset('assets/people.png', width: 25),
          title: screenwidth ? const Text('Discussion') : null,
          onTap: () {
            // Handle tap on Messages
          },
        ),
        ListTile(
          leading: Icon(Icons.bookmark),
          title: screenwidth ? const Text('Bookmarks') : null,
          onTap: () {
            // Handle tap on Bookmarks
          },
        ),
        ListTile(
          leading: Image.asset(
            'assets/profile.png',
            width: 25,
            color: Colors.black,
          ),
          title: screenwidth ? const Text('Profile') : null,
          onTap: () {
            context.router.push(ProfileRouteRoute());
          },
        ),
        ListTile(
          leading: Image.asset(
            'assets/setting.png',
            width: 25,
            color: Colors.black,
          ),
          title: screenwidth ? const Text('Settings') : null,
          onTap: () {
            context.router.push(const SettingsRoute());
          },
        ),
      ],
    ),
  );
}

Widget _buildPost() {
  HomeController homeController = Get.find();
  return LayoutBuilder(builder: (context, constraints) {
    return LayoutBuilder(builder: (context, constraints) {
      return ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: constraints.maxWidth *
                0.5, // Set minimum width for the SizedBox
            maxWidth: constraints.maxWidth *
                0.7, // Set maximum width based on the parent
          ),
          child: SizedBox(
            height: constraints.maxHeight * 0.9,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(width: 1, color: Colors.grey),
                  right: BorderSide(width: 1, color: Colors.grey),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                child: ListView.builder(
                  itemCount: homeController.pic.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return index == 1
                        ? Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: ListTile(
                                    leading: SizedBox(
                                      height: 48,
                                      width: 48,
                                      child: Container(
                                        height: 173,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    homeController.pic[index]),
                                                fit: BoxFit.fill),
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                      ),
                                    ),
                                    title: Row(
                                      children: [
                                        Text(homeController.text[index],
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'Urbanist-semibold',
                                                fontWeight: FontWeight.w600)),
                                        Image.asset(
                                          'assets/badge-check.png',
                                          height: 20,
                                          width: 20,
                                        ),
                                      ],
                                    ),
                                    subtitle: const Text('3 Minutes Ago',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                            fontFamily: 'Urbanist-regular',
                                            fontWeight: FontWeight.w400)),
                                    trailing: GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet(
                                            context: context,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                      top: Radius.circular(15)),
                                            ),
                                            builder: (context) {
                                              return SizedBox(
                                                height: 250,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 15),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Container(
                                                        height: 50,
                                                        width: 375,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: Colors
                                                              .grey.shade200,
                                                        ),
                                                        child: const Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  15.0),
                                                          child: Text(
                                                            'Mute',
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                          height: 150,
                                                          width: 375,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color: Colors
                                                                .grey.shade200,
                                                          ),
                                                          child:
                                                              ListView.builder(
                                                            itemCount:
                                                                homeController
                                                                    .option
                                                                    .length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            13,
                                                                        top: 13,
                                                                        bottom:
                                                                            10),
                                                                    child: Text(
                                                                      homeController
                                                                              .option[
                                                                          index],
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                          color: homeController.colors[
                                                                              index],
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                  index == 2
                                                                      ? const SizedBox()
                                                                      : const Divider(
                                                                          height:
                                                                              10,
                                                                          thickness:
                                                                              1,
                                                                          color:
                                                                              Colors.grey,
                                                                        ),
                                                                ],
                                                              );
                                                            },
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child:
                                            const Icon(Icons.more_vert_sharp)),
                                  ),
                                ),
                                Container(
                                    alignment: Alignment
                                        .centerLeft, // Aligns the RichText to the left
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 88),
                                        child: RichText(
                                          text: const TextSpan(
                                            children: [
                                              TextSpan(
                                                text:
                                                    "Hey guys! I really love the city pop hit Plastic Love and I'm working on a cover...",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontFamily:
                                                        'Urbanist-medium',
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ))),
                                // Post
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  height: 300,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: homeController.frame.length,
                                    shrinkWrap: false,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    FullScreenImage(
                                                  imageUrl: homeController
                                                      .frame[index],
                                                  tag: "generate_a_unique_tag",
                                                ),
                                              ));
                                        },
                                        child: Container(
                                          height: 225,
                                          width: 200,
                                          margin: const EdgeInsets.only(
                                              left: 5, top: 10, bottom: 10),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.asset(
                                              homeController.frame[index],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30, right: 20, top: 5),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                        width: 12,
                                        child: Image.asset('assets/heart.png'),
                                      ),
                                      SizedBox(
                                        height: 20,
                                        width: 12,
                                        child: Image.asset('assets/like.png'),
                                      ),
                                      const Text(
                                        '  2.8K',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                            fontFamily: 'Urbanist-regular',
                                            fontWeight: FontWeight.w400),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const Expanded(
                                          child: SizedBox(width: 185)),
                                      const Text(
                                        '948 Comment',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                            fontFamily: 'Urbanist-regular',
                                            fontWeight: FontWeight.w400),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    // Like
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    GetBuilder<HomeController>(
                                      builder: (controller) {
                                        return GestureDetector(
                                          onTap: () {
                                            homeController.changeValue1(
                                                value: index);
                                          },
                                          child: Container(
                                            height: 36,
                                            width: 36,
                                            decoration: BoxDecoration(
                                              // color: Colors.red,
                                              border: Border.all(
                                                  color: homeController
                                                          .selectIndex1
                                                          .contains(index)
                                                      ? Colors.grey.shade200
                                                      : Colors.red),
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                            child: Center(
                                                child: Image.asset(
                                              homeController.selectIndex1
                                                      .contains(index)
                                                  ? 'assets/hearts.png'
                                                  : 'assets/heart2.png',
                                              height: 16,
                                              width: 16,
                                            )),
                                          ),
                                        );
                                      },
                                    ),
                                    // Comment
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet(
                                          context: context,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(15)),
                                          ),
                                          builder: (context) {
                                            return SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  ListTile(
                                                    title: const Text(
                                                        'Comments',
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontFamily:
                                                                'Urbanist-semibold'),
                                                        textAlign:
                                                            TextAlign.center),
                                                    trailing: InkWell(
                                                      onTap: () =>
                                                          Navigator.pop(
                                                              context),
                                                      child: const Icon(
                                                        Icons.close,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  GetBuilder<HomeController>(
                                                    builder: (controller) {
                                                      return ListView.builder(
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        itemCount:
                                                            homeController
                                                                .instastory1
                                                                .length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Column(
                                                            children: [
                                                              ListTile(
                                                                leading:
                                                                    Image.asset(
                                                                  homeController
                                                                          .instastory1[
                                                                      index],
                                                                  height: 30,
                                                                  width: 30,
                                                                ),
                                                                title: Text(
                                                                  homeController
                                                                          .text1[
                                                                      index],
                                                                  style: const TextStyle(
                                                                      fontFamily:
                                                                          'Urbanist-semibold',
                                                                      fontSize:
                                                                          15),
                                                                ),
                                                                subtitle: Text(
                                                                  homeController
                                                                          .subtitle[
                                                                      index],
                                                                  style: const TextStyle(
                                                                      fontFamily:
                                                                          "Urbanist-medium"),
                                                                ),
                                                                trailing: Text(
                                                                  homeController
                                                                          .time[
                                                                      index],
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "Urbanist-medium",
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .grey
                                                                          .shade400),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            20),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    InkWell(
                                                                        onTap:
                                                                            () {
                                                                          homeController.changeValue(
                                                                              value: index);
                                                                        },
                                                                        child: Image
                                                                            .asset(
                                                                          homeController.selectIndex.contains(index)
                                                                              ? 'assets/heart2.png'
                                                                              : 'assets/hearts.png',
                                                                          height:
                                                                              15,
                                                                          width:
                                                                              15,
                                                                        )),
                                                                    const SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Image.asset(
                                                                      'assets/comment.png',
                                                                      height:
                                                                          15,
                                                                      width: 15,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Container(
                                        height: 36,
                                        width: 36,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey.shade200),
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        child: Center(
                                          child: Image.asset(
                                            'assets/comment.png',
                                            width: 16,
                                            height: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Repost
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      height: 36,
                                      width: 36,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey.shade200),
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: Center(
                                          child: Image.asset(
                                        'assets/repost.png',
                                        height: 16,
                                        width: 16,
                                      )),
                                    ),
                                    // Share
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      height: 36,
                                      width: 36,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey.shade200),
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: Center(
                                          child: Image.asset(
                                        'assets/send.png',
                                        height: 16,
                                        width: 16,
                                      )),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ))
                        : Container();
                  },
                ),
              ),
            ),
          ));
    });
  });
}

class _BellIcon extends StatelessWidget {
  const _BellIcon({required this.hasNotifications});

  final bool hasNotifications;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: <Widget>[
        ProjectAssets.icons.bell.svg(
          width: 24,
          height: 27.79,
          colorFilter: Palette.black.toColorFilter,
        ),
        if (hasNotifications)
          Container(
            margin: const EdgeInsets.all(1),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: Palette.blue,
              shape: BoxShape.circle,
              border: Border.all(color: Palette.dirtyWhite),
            ),
          ),
      ],
    );
  }
}
