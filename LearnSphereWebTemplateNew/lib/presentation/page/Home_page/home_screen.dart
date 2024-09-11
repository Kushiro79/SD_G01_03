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

  List pic = [
    'assets/02.png',
    'assets/03.png',
    'assets/03.png',
  ];
  List frame = [
    'assets/Frame 427321881.png',
    'assets/Frame 427321882.png',
    'assets/Frame 427321883.png',
  ];
  List text = [
    'Alon musk',
    'Samantha',
    'Sara Ali khan',
  ];
  List instastory = [
    'assets/02.png',
    'assets/03.png',
    'assets/01.png',
    'assets/04.png',
    'assets/03.png',
  ];
  List instastory1 = [
    'assets/02.png',
    'assets/03.png',
    'assets/01.png',
    'assets/04.png',
  ];
  List text1 = [
    'Alon musk',
    'V. Kohl',
    'Tiger shroff',
    'Sharukh',
  ];
  List subtitle = [
    'Wow Looking Handsome Buddy',
    'You Are So Handsome',
    'So Beautiful Pic',
    'You Have A Great Smile',
  ];
  List time = [
    '2 min ago',
    '5 min ago',
    '10 min ago',
    '20 min ago',
  ];
  List option = [
    'Hide',
    'Block',
    'Report',
  ];
  List<Color> colors = [
    Colors.black,
    Colors.red,
    Colors.red,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          toolbarHeight: 100,
          title: Row(
            children: <Widget>[
              const Text('LearnSphere'), // Add a title to the AppBar
              const Spacer(),
              const _BellIcon(
                hasNotifications: true,
              ),
              const SizedBox(width: 34),
              CircleAvatar(
                backgroundImage: AssetImage('assets/01.png'),
                child: PopupMenuButton<String>(
                  offset: const Offset(0, 50),
                  child: Container(),
                  onSelected: (String value) {
                    switch (value) {
                      case 'View Profile':
                        context.router
                            .push(ProfileRouteRoute()); // Corrected route
                        break;
                      case 'Edit Profile':
                        context.router.push(const EditProfileRoute());
                        break;
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'View Profile',
                        child: Row(
                          children: [
                            Icon(Icons.person),
                            Text('   View Profile'),
                          ],
                        ),
                      ),
                      const PopupMenuItem<String>(
                        value: 'Edit Profile',
                        child: Row(
                          children: [
                            Icon(Icons.settings),
                            Text('   Edit Profile'),
                          ],
                        ),
                      ),
                    ];
                  },
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
        ),
        body: Center(child: LayoutBuilder(builder: (context, constraints) {
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                      child: ListView.builder(
                        itemCount: pic.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return index == 1
                              ? Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  child: Column(
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
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.9,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          pic[index]),
                                                      fit: BoxFit.fill),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100)),
                                            ),
                                          ),
                                          title: Row(
                                            children: [
                                              Text(text[index],
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontFamily:
                                                          'Urbanist-semibold',
                                                      fontWeight:
                                                          FontWeight.w600)),
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
                                                  fontFamily:
                                                      'Urbanist-regular',
                                                  fontWeight: FontWeight.w400)),
                                          trailing: GestureDetector(
                                              onTap: () {
                                                showModalBottomSheet(
                                                  context: context,
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.vertical(
                                                            top:
                                                                Radius.circular(
                                                                    15)),
                                                  ),
                                                  builder: (context) {
                                                    return SizedBox(
                                                      height: 250,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
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
                                                                        .circular(
                                                                            10),
                                                                color: Colors
                                                                    .grey
                                                                    .shade200,
                                                              ),
                                                              child:
                                                                  const Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            15.0),
                                                                child: Text(
                                                                  'Mute',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15,
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
                                                                      .grey
                                                                      .shade200,
                                                                ),
                                                                child: ListView
                                                                    .builder(
                                                                  itemCount:
                                                                      option
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
                                                                              left: 13,
                                                                              top: 13,
                                                                              bottom: 10),
                                                                          child:
                                                                              Text(
                                                                            option[index],
                                                                            style: TextStyle(
                                                                                fontSize: 15,
                                                                                color: colors[index],
                                                                                fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        index ==
                                                                                2
                                                                            ? const SizedBox()
                                                                            : const Divider(
                                                                                height: 10,
                                                                                thickness: 1,
                                                                                color: Colors.grey,
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
                                              child: const Icon(
                                                  Icons.more_vert_sharp)),
                                        ),
                                      ),
                                      Container(
                                          alignment: Alignment
                                              .centerLeft, // Aligns the RichText to the left
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
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
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        height: 300,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: frame.length,
                                          shrinkWrap: false,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          FullScreenImage(
                                                        imageUrl: frame[index],
                                                        tag:
                                                            'generate_a_unique_tag',
                                                      ),
                                                    ));
                                              },
                                              child: Container(
                                                height: 225,
                                                width: 200,
                                                margin: const EdgeInsets.only(
                                                    left: 5,
                                                    top: 10,
                                                    bottom: 10),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.asset(
                                                    frame[index],
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
                                              child: Image.asset(
                                                  'assets/heart.png'),
                                            ),
                                            SizedBox(
                                              height: 20,
                                              width: 12,
                                              child: Image.asset(
                                                  'assets/like.png'),
                                            ),
                                            const Text(
                                              '  2.8K',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12,
                                                  fontFamily:
                                                      'Urbanist-regular',
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
                                                  fontFamily:
                                                      'Urbanist-regular',
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
                                                            ? Colors
                                                                .grey.shade200
                                                            : Colors.red),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
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
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                          top: Radius.circular(
                                                              15)),
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
                                                                  TextAlign
                                                                      .center),
                                                          trailing: InkWell(
                                                            onTap: () =>
                                                                Navigator.pop(
                                                                    context),
                                                            child: const Icon(
                                                              Icons.close,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                        GetBuilder<
                                                            HomeController>(
                                                          builder:
                                                              (controller) {
                                                            return ListView
                                                                .builder(
                                                              physics:
                                                                  const NeverScrollableScrollPhysics(),
                                                              shrinkWrap: true,
                                                              scrollDirection:
                                                                  Axis.vertical,
                                                              itemCount:
                                                                  instastory1
                                                                      .length,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                return Column(
                                                                  children: [
                                                                    ListTile(
                                                                      leading: Image
                                                                          .asset(
                                                                        instastory1[
                                                                            index],
                                                                        height:
                                                                            30,
                                                                        width:
                                                                            30,
                                                                      ),
                                                                      title:
                                                                          Text(
                                                                        text1[
                                                                            index],
                                                                        style: const TextStyle(
                                                                            fontFamily:
                                                                                'Urbanist-semibold',
                                                                            fontSize:
                                                                                15),
                                                                      ),
                                                                      subtitle:
                                                                          Text(
                                                                        subtitle[
                                                                            index],
                                                                        style: const TextStyle(
                                                                            fontFamily:
                                                                                'Urbanist-medium'),
                                                                      ),
                                                                      trailing:
                                                                          Text(
                                                                        time[
                                                                            index],
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'Urbanist-medium',
                                                                            fontSize:
                                                                                12,
                                                                            color:
                                                                                Colors.grey.shade400),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              20),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        children: [
                                                                          InkWell(
                                                                              onTap: () {
                                                                                homeController.changeValue(value: index);
                                                                              },
                                                                              child: Image.asset(
                                                                                homeController.selectIndex.contains(index) ? 'assets/heart2.png' : 'assets/hearts.png',
                                                                                height: 15,
                                                                                width: 15,
                                                                              )),
                                                                          const SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                          Image
                                                                              .asset(
                                                                            'assets/comment.png',
                                                                            height:
                                                                                15,
                                                                            width:
                                                                                15,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          10,
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
                                                    color:
                                                        Colors.grey.shade200),
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
        })));
  }
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
