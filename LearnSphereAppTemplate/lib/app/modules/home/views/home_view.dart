// ignore_for_file: unrelated_type_equality_checks
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociogram/app/modules/addpost_screen/views/addpost_screen_view.dart';
import 'package:sociogram/app/modules/home/views/showimage_view.dart';
import 'package:sociogram/app/modules/home/views/store_view.dart';
import 'package:sociogram/app/modules/message_screen/Message_screen.dart';
import 'package:sociogram/app/modules/setting_page/setting_page.dart';
import 'package:sociogram/config/app_color.dart';
import 'package:story_view/story_view.dart';

import '../../../../config/app_contents.dart';
import '../../notification_screen/notification.dart';
import '../controllers/home_controller.dart';

// ignore: must_be_immutable
class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  // final PageController _controller = PageController();
  HomeController homeController = Get.put(HomeController());
  final StoryController storyController = StoryController();

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
    'You Have A Great Smiles',
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
          backgroundColor: Colors.white,
          body: ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              // Story and Message
              Stack(
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                      width: Get.size.width,
                      child: Image.asset(
                        Appcontent.backgraund,
                        fit: BoxFit.fill,
                      )),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 24, child: Image(image: AssetImage(Appcontent.hubline))),
                        const SizedBox(width: 5,),
                        const Text('Sociogram', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, fontFamily: 'Urbanist')),
                        const Expanded(child: SizedBox(width: 160,),
                        ),
                        SizedBox(
                          height: 32,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const MessageScreen(),)),
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      height: 24,
                                        child: Image.asset(Appcontent.messager)),
                                    Positioned(
                                      left: 11,
                                      bottom: 11,
                                      child: Container(
                                        height: 14,
                                        width: 14,
                                        decoration: BoxDecoration(
                                          color: AppColor.purple,
                                          borderRadius: BorderRadius.circular(100),
                                        ),
                                        child: const Center(
                                          child: Text('3', style: TextStyle(fontSize: 10, fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w500, color: Colors.white),),
                                        ),
                                      ),
                                    ),
                                  ],
                                    ),
                              ),
                              const SizedBox(width: 10),
                              GestureDetector(
                                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationScreen(),)),
                                child: Stack(
                                  children: [
                                    SizedBox(
                                        height: 24,
                                        child: Image.asset(Appcontent.notification)),
                                    Positioned(
                                      left: 10,
                                      child: Container(
                                        height: 14,
                                        width: 14,
                                        decoration: BoxDecoration(
                                          color: AppColor.purple,
                                          borderRadius: BorderRadius.circular(100),
                                        ),
                                        child: const Center(
                                          child: Text('3', style: TextStyle(fontSize: 10, fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w500, color: Colors.white),),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              InkWell(
                                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddpostScreenView(),)),
                                  child: SizedBox(
                                    height: 24,
                                      child: Image.asset(Appcontent.addpostst))),

                                      //ADD SETTINGS BUTTON HERE
                                      GestureDetector(
                                        onTap: () => Navigator.push(context,
                                        MaterialPageRoute(
                                          builder: (context)=> SettingsPage(),
                                          ),
                                      ),
                                      child: SizedBox(
                                        height: 24,
                                        child: Icon(
                                          Icons.settings,
                                          color: AppColor.purple,
                                        ),
                                      ),
                                  ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10,),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: -50,
                    left: 20,
                    right: 0,
                    child: Container(
                      height: 90,
                      width: Get.size.width,
                      alignment: Alignment.center,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddpostScreenView(),)),
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      height: 60,
                                      width: 60,
                                      margin:
                                      const EdgeInsets.symmetric(horizontal: 10),
                                      child: Container(
                                        height: 173,
                                        width: Get.size.width,
                                        decoration: BoxDecoration(
                                            image: const DecorationImage(image: AssetImage('assets/05.png',),fit: BoxFit.fill),
                                            borderRadius: BorderRadius.circular(100)),
                                      ),
                                    ),
                                    Positioned(
                                      left: 50,
                                      bottom: 0,
                                        child: Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.circular(100),
                                          ),
                                          child: const Icon(Icons.add, color: Colors.white, size: 15),
                                        ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10,),
                                const Text('Add Story', style: TextStyle(fontSize: 10, fontFamily: 'Urbanist-regular', fontWeight: FontWeight.w400,),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -50,
                    left: 100,
                    right: 0,
                    child: Container(
                      height: 90,
                      width: Get.size.width,
                      alignment: Alignment.center,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: instastory.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Get.to(const StoryViewScreen());
                            },
                            child: Column(
                              children: [
                                Container(
                                    height: 60,
                                    width: 60,
                                    margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                    child: Container(
                                      height: 173,
                                      width: Get.size.width,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(image: AssetImage(instastory[index]),fit: BoxFit.fill),
                                        borderRadius: BorderRadius.circular(100)),
                                    ),
                                ),
                                const SizedBox(height: 10,),
                                const Text('Alon musk', style: TextStyle(fontSize: 10, fontFamily: 'Urbanist-regular', fontWeight: FontWeight.w400,),),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50,),

              // Post
              SizedBox(
                height: 550,
                width: Get.width,
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView.builder(
                    itemCount: pic.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return index == 1 ? Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: ListTile(
                              leading: SizedBox(
                                height: 48,
                                width: 48,
                                child: Container(
                                  height: 173,
                                  width: Get.size.width,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(image: AssetImage(pic[index]),fit: BoxFit.fill),
                                      borderRadius: BorderRadius.circular(100)),
                                ),
                              ),
                              title: Row(
                                children: [
                                  Text(text[index], style: const TextStyle(fontSize: 16, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600)),
                                  Image.asset('assets/badge-check.png', height: 20, width: 20,),
                                ],
                              ),
                              subtitle: const Text('3 Minutes Ago', style: TextStyle(fontSize: 12, color: Colors.grey, fontFamily: 'Urbanist-regular', fontWeight: FontWeight.w400)),
                              trailing: GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                                      ),
                                      builder: (context) {
                                        return SizedBox(
                                          height: 250,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 15),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Container(
                                                  height: 50,
                                                  width: 375,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: Colors.grey.shade200,
                                                  ),
                                                  child: const Padding(
                                                    padding: EdgeInsets.all(15.0),
                                                    child: Text('Mute', style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),),
                                                  ),
                                                ),
                                                Container(
                                                    height: 150,
                                                    width: 375,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      color: Colors.grey.shade200,
                                                    ),
                                                    child: ListView.builder(
                                                      itemCount: option.length,
                                                      itemBuilder: (context, index) {
                                                        return Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets.only(left: 13, top: 13, bottom: 10),
                                                              child: Text(option[index], style: TextStyle(fontSize: 15, color: colors[index], fontWeight: FontWeight.bold),),
                                                            ),
                                                            index == 2 ?  const SizedBox() : const Divider(
                                                              height: 10,
                                                              thickness: 1,
                                                              color: Colors.grey,
                                                            ),
                                                          ],
                                                        );
                                                      },)
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },);
                                  },
                                  child: const Icon(Icons.more_vert_sharp)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: RichText(
                                text: const TextSpan(
                                  children: [
                                    TextSpan(
                                        text: "Hey guys! I really  love the city pop hit Plastic  Love\nand I'm working on a cover...",
                                        style: TextStyle(fontSize: 14, color: Colors.grey, fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w400)),
                                    TextSpan(
                                        text: "See More",
                                        style: TextStyle(fontSize: 14, color: AppColor.purple, fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w500)),
                                  ],
                                )),
                          ),
                          // Post
                          SizedBox(
                            width: 400,
                            height: 300,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: frame.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => FullScreenImage(imageUrl: frame[index],tag:  "generate_a_unique_tag",),));
                                  },
                                  child: Container(
                                  height: 225,
                                  width: 200,
                                  margin: const EdgeInsets.only(left: 5, top: 10, bottom: 10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(frame[index], fit: BoxFit.cover,),
                                  ),
                              ),
                                );
                            },),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30, right: 20, top: 5),
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
                                const Text('  2.8K', style: TextStyle(color: Colors.grey, fontSize: 12, fontFamily: 'Urbanist-regular', fontWeight: FontWeight.w400), overflow: TextOverflow.ellipsis,),
                                const Expanded(child: SizedBox(width: 185)),
                                const Text('948 Comment', style: TextStyle(fontSize: 12, color: Colors.grey, fontFamily: 'Urbanist-regular', fontWeight: FontWeight.w400), overflow: TextOverflow.ellipsis,),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              // Like
                              const SizedBox(width: 20,),
                              GetBuilder<HomeController>(
                                builder: (controller) {
                                  return GestureDetector(
                                    onTap: () {
                                      homeController.changeValue1(value: index);
                                    },
                                    child: Container(
                                      height: 36,
                                      width: 36,
                                      decoration: BoxDecoration(
                                        // color: Colors.red,
                                        border: Border.all(color: homeController.selectIndex1.contains(index) ? Colors.grey.shade200 : Colors.red),
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                      child: Center(child: Image.asset(homeController.selectIndex1.contains(index) ? 'assets/hearts.png' : 'assets/heart2.png' , height: 16, width: 16,)),
                                    ),
                                  );
                                },

                              ),
                              // Comment
                              const SizedBox(width: 10,),
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                                    ),
                                    builder: (context) {
                                      return SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            ListTile(
                                              title: const Text('Comments', style: TextStyle(fontSize: 15, fontFamily: 'Urbanist-semibold'), textAlign: TextAlign.center),
                                              trailing: InkWell(
                                                onTap: () => Navigator.pop(context),
                                                child: const Icon(Icons.close, color: Colors.black,),
                                              ),
                                            ),
                                            GetBuilder<HomeController>(
                                              builder: (controller) {
                                                return ListView.builder(
                                                  physics: const NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  scrollDirection: Axis.vertical,
                                                  itemCount: instastory1.length,
                                                  itemBuilder: (context, index) {
                                                    return Column(
                                                      children: [
                                                        ListTile(
                                                          leading: Image.asset(instastory1[index], height: 30, width: 30,),
                                                          title: Text(text1[index], style: const TextStyle(fontFamily: 'Urbanist-semibold', fontSize: 15),),
                                                          subtitle: Text(subtitle[index], style: const TextStyle(fontFamily: "Urbanist-medium"),),
                                                          trailing: Text(time[index], style: TextStyle(fontFamily: "Urbanist-medium" , fontSize: 12, color: Colors.grey.shade400),),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 20),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              InkWell(
                                                                  onTap: () {
                                                                    homeController.changeValue(value: index);
                                                                  },
                                                                  child: Image.asset(homeController.selectIndex.contains(index) ? 'assets/heart2.png' :'assets/hearts.png', height: 15, width: 15,)),
                                                              const SizedBox(width: 10,),
                                                              Image.asset('assets/comment.png', height: 15, width: 15,),
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(height: 10,),
                                                      ],
                                                    );
                                                  },);
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    },);
                                },
                                child: Container(
                                  height: 36,
                                  width: 36,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey.shade200),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Center(child: Image.asset('assets/comment.png', width: 16, height: 16,),),
                                ),
                              ),
                              // Repost
                              const SizedBox(width: 10,),
                              Container(
                                height: 36,
                                width: 36,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.shade200),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Center(child: Image.asset('assets/repost.png', height: 16, width: 16,)),
                              ),
                              // Share
                              const SizedBox(width: 10,),
                              Container(
                                height: 36,
                                width: 36,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.shade200),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Center(child: Image.asset('assets/send.png', height: 16, width: 16,)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20,),
                        ],
                      ): Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: ListTile(
                              leading: SizedBox(
                                height: 48,
                                width: 48,
                                child: Container(
                                  height: 173,
                                  width: Get.size.width,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(image: AssetImage(pic[index]),fit: BoxFit.fill),
                                      borderRadius: BorderRadius.circular(100)),
                                ),
                              ),
                              title: Row(
                                children: [
                                  Text(text[index], style: const TextStyle(fontSize: 16, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600)),
                                index != 0 ?  Image.asset('assets/badge-check.png', height: 20, width: 20,): const SizedBox(),
                                ],
                              ),
                              subtitle: const Text('3 Minutes Ago', style: TextStyle(fontSize: 12, color: Colors.grey, fontFamily: 'Urbanist-regular', fontWeight: FontWeight.w400)),
                              trailing: GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                                      ),
                                      builder: (context) {
                                        return SizedBox(
                                          height: 250,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 15),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Container(
                                                  height: 50,
                                                  width: 375,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: Colors.grey.shade200,
                                                  ),
                                                  child: const Padding(
                                                    padding: EdgeInsets.all(15.0),
                                                    child: Text('Mute', style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),),
                                                  ),
                                                ),
                                                Container(
                                                  height: 150,
                                                  width: 375,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: Colors.grey.shade200,
                                                  ),
                                                  child: ListView.builder(
                                                    itemCount: option.length,
                                                    itemBuilder: (context, index) {
                                                      return Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.only(left: 13, top: 13, bottom: 10),
                                                            child: Text(option[index], style: TextStyle(fontSize: 15, color: colors[index], fontWeight: FontWeight.bold),),
                                                          ),
                                                          index == 2 ?  const SizedBox() : const Divider(
                                                             height: 10,
                                                             thickness: 1,
                                                             color: Colors.grey,
                                                           ),
                                                        ],
                                                      );
                                                  },)
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },);
                                },
                                  child: const Icon(Icons.more_vert_sharp)),
                            ),
                          ),
                          RichText(
                              text: const TextSpan(
                            children: [
                              TextSpan(
                                  text: "Hey guys! I really  love the city pop hit Plastic  Love\nand I'm working on a cover...",
                                  style: TextStyle(fontSize: 14, color: Colors.grey, fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w400)),
                              TextSpan(
                                  text: "See More",
                                  style: TextStyle(fontSize: 14, color: AppColor.purple, fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w500)),
                            ],
                          )),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => FullScreenImage(imageUrl:index==2? Appcontent.post4 : Appcontent.post1,tag:  "generate_a_unique_tag",),));
                                  },
                                  child: SizedBox(
                                    height: 137,
                                    width: 327,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                        child: Image.asset(index==2? Appcontent.post4 : Appcontent.post1, fit: BoxFit.cover, )),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => FullScreenImage(imageUrl:index==2? Appcontent.post5 : Appcontent.post2,tag:  "generate_a_unique_tag",),));
                                      },
                                      child: SizedBox(
                                        height: 82,
                                        width: 161,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                            child: Image.asset(index==2? Appcontent.post5 : Appcontent.post2, fit: BoxFit.cover)),
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => FullScreenImage(imageUrl:index==2? Appcontent.post6 : Appcontent.post3,tag:  "generate_a_unique_tag",),));
                                      },
                                      child: SizedBox(
                                        height: 82,
                                        width: 161,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                            child: Image.asset(index==2? Appcontent.post6 : Appcontent.post3, fit: BoxFit.cover,)),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30, right: 20, top: 5),
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
                                const Text('  2.8K', style: TextStyle(color: Colors.grey, fontSize: 12, fontFamily: 'Urbanist-regular', fontWeight: FontWeight.w400), overflow: TextOverflow.ellipsis,),
                                const Expanded(child: SizedBox(width: 185)),
                                const Text('948 Comment', style: TextStyle(fontSize: 12, color: Colors.grey, fontFamily: 'Urbanist-regular', fontWeight: FontWeight.w400), overflow: TextOverflow.ellipsis,),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              // Like
                              const SizedBox(width: 20,),
                              GetBuilder<HomeController>(
                                builder: (controller) {
                                  return GestureDetector(
                                    onTap: () {
                                      homeController.changeValue1(value: index);
                                    },
                                    child: Container(
                                      height: 36,
                                      width: 36,
                                      decoration: BoxDecoration(
                                        // color: Colors.red,
                                        border: Border.all(color: homeController.selectIndex1.contains(index) ? Colors.grey.shade200 : Colors.red),
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                      child: Center(child: Image.asset(homeController.selectIndex1.contains(index) ? 'assets/hearts.png' : 'assets/heart2.png' , height: 16, width: 16,)),
                                    ),
                                  );
                                },

                              ),
                              // Comment
                              const SizedBox(width: 10,),
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                                      ),
                                      builder: (context) {
                                        return SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              ListTile(
                                                title: const Text('Comments', style: TextStyle(fontSize: 15, fontFamily: 'Urbanist-semibold'), textAlign: TextAlign.center),
                                                trailing: InkWell(
                                                  onTap: () => Navigator.pop(context),
                                                  child: const Icon(Icons.close, color: Colors.black,),
                                                ),
                                              ),
                                              GetBuilder<HomeController>(
                                                builder: (controller) {
                                                  return ListView.builder(
                                                    physics: const NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    scrollDirection: Axis.vertical,
                                                    itemCount: instastory1.length,
                                                    itemBuilder: (context, index) {
                                                      return Column(
                                                        children: [
                                                          ListTile(
                                                            leading: Image.asset(instastory1[index], height: 30, width: 30,),
                                                            title: Text(text1[index], style: const TextStyle(fontFamily: 'Urbanist-semibold', fontSize: 15),),
                                                            subtitle: Text(subtitle[index], style: const TextStyle(fontFamily: "Urbanist-medium"),),
                                                            trailing: Text(time[index], style: TextStyle(fontFamily: "Urbanist-medium" , fontSize: 12, color: Colors.grey.shade400),),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.only(left: 20),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: [
                                                                InkWell(
                                                                    onTap: () {
                                                                      homeController.changeValue(value: index);
                                                                    },
                                                                    child: Image.asset(homeController.selectIndex.contains(index) ? 'assets/heart2.png' :'assets/hearts.png', height: 15, width: 15,)),
                                                                const SizedBox(width: 10,),
                                                                Image.asset('assets/comment.png', height: 15, width: 15,),
                                                              ],
                                                            ),
                                                          ),
                                                          const SizedBox(height: 10,),
                                                        ],
                                                      );
                                                    },);
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      },);
                                },
                                child: Container(
                                  height: 36,
                                  width: 36,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey.shade200),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Center(child: Image.asset('assets/comment.png', width: 16, height: 16,),),
                                ),
                              ),
                              // Repost
                              const SizedBox(width: 10,),
                              Container(
                                height: 36,
                                width: 36,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.shade200),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Center(child: Image.asset('assets/repost.png', height: 16, width: 16,)),
                              ),
                              // Share
                              const SizedBox(width: 10,),
                              Container(
                                height: 36,
                                width: 36,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.shade200),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Center(child: Image.asset('assets/send.png', height: 16, width: 16,)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20,),
                        ],
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        );
  }
}