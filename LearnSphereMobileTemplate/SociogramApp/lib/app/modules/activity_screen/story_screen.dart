import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociogram/app/modules/activity_screen/activity_screen_controller.dart';
import 'package:sociogram/config/common_button.dart';

import '../../../config/app_color.dart';

class StoryScreenView extends GetView<ActivityScreenController> {
  const StoryScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List story = [
      'assets/Stories1.png',
      'assets/Stories 03.png',
      'assets/stories2.png',
    ];
    List post = [
      'assets/archive1.png',
      'assets/archive2.png',
      'assets/archive3.png',
    ];
    List live = [
      'assets/live1.png',
      'assets/live2.png',
    ];
    List pdate = [
      '03',
      '16',
      '25',
    ];
    List pmont = [
      'Aug',
      'Sep',
      'Sep',
    ];
    List podate = [
      '02',
      '26',
      '13',
    ];
    List pomont = [
      'Dec',
      'Jan',
      'Oct',
    ];
    List play = [
      '42:12',
      '58:42',
    ];
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back, color: Colors.black,),
          ),
          title: const Text('Archived', style: TextStyle(fontSize: 18, color: Colors.black),),
          centerTitle: true,
          actions: const [
            Icon(Icons.more_vert, color: Colors.black,),
            SizedBox(width: 15,),
          ],
        ),
        body: Column(
          children: [
            TabBar(
                indicatorColor: AppColor.purple,
                tabs: [
              Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: Image.asset('assets/grid-1.png'),
                      ),
                      const Text(
                        '  Stories',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  )),
              Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: Image.asset(
                          'assets/camera1.png',
                          color: Colors.black,
                        ),
                      ),
                      const Text(
                        '  Post',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  )),
              Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: Image.asset(
                          'assets/video-play1.png',
                          color: Colors.black,
                        ),
                      ),
                      const Text(
                        '  Live',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  )),
            ]),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: SizedBox(
                height: 500,
                child: TabBarView(
                    children: <Widget> [
                      GridView.builder(
                        scrollDirection: Axis.vertical,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              height: 155,
                                width: 157,
                                child: Stack(
                                  children: [
                                    Image.asset(story[index]),
                                    Positioned(
                                      left: 10,
                                      top: 10,
                                      child: Container(
                                        height: 52,
                                        width: 44,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(10)),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(pdate[index], style: const TextStyle(fontSize: 16, color: Colors.black),),
                                            Text(pmont[index], style: const TextStyle(fontSize: 10, color: Color(0xff64748B)),),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ));
                          },
                      ),
                      GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 20,mainAxisExtent: 150),
                        itemCount: post.length,
                        itemBuilder: (context, index) {
                          return  SizedBox(
                              height: 125,
                              width:  157,
                              child: Stack(
                                children: [
                                  Image.asset(post[index],fit: BoxFit.cover,),
                                  Positioned(
                                    left:10,
                                    top: 10,
                                    child: Container(
                                      height: 52,
                                      width: 44,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10)),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(podate[index], style: const TextStyle(fontSize: 16, color: Colors.black),),
                                          Text(pomont[index], style: const TextStyle(fontSize: 10, color: Color(0xff64748B)),),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ));
                        },
                      ),
                      GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 230),
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          return SizedBox(
                              height: 155,
                              width: 157,
                              child: Center(
                                child: Stack(
                                  children: [
                                    Image.asset(live[index]),
                                    Positioned(
                                      left: 10,
                                      top: 10,
                                      child: Container(
                                        height: 52,
                                        width: 44,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(10)),
                                        child: const Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('26', style: TextStyle(fontSize: 16, color: Colors.black),),
                                            Text('Jan', style: TextStyle(fontSize: 10, color: Color(0xff64748B)),),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 10,
                                        right: 10,
                                        child: Container(
                                          height: 21,
                                          width: 53,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(100),
                                            color: Colors.black.withOpacity(0.55),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Image.asset('assets/play.png'),
                                              const SizedBox(width: 5,),
                                              Text(play[index], style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 10, fontFamily: 'Urbanist-semibold', color: Colors.white),),
                                            ],
                                          ),
                                        ),
                                    ),
                                  ],
                                ),
                              ));
                        },
                      ),
                    ],
                ),
              ),
            ),

            const Expanded(child: SizedBox(height: 100,)),
            elevated(text: 'Restore All', onPress: () {},),
            const Expanded(child: SizedBox(height: 20,)),
          ],
        ),
      ),
    );
  }
}