import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociogram/config/common_textfield.dart';

import '../../../../config/app_color.dart';
import '../../../../config/app_contents.dart';
import '../controllers/follow_screen_controller.dart';

// ignore: must_be_immutable
class FollowScreenView extends GetView<FollowScreenController> {
  FollowScreenView({Key? key}) : super(key: key);
  FollowScreenController followScreenController = Get.put(FollowScreenController());
  @override
  Widget build(BuildContext context) {
    List img = [
      'assets/Share1.png',
      'assets/Share2.png',
      'assets/Share3.png',
      'assets/Share4.png',
    ];
    List text = [
      'Share',
      'Block',
      'Notification',
      'Message',
    ];

    List profile = [
      '1.3 Followers',
      '435 Following',
      '3 Subscribe',
      'Suggestion',
    ];

    List followers = [
      'assets/02.png',
      'assets/03.png',
      'assets/04.png',
      'assets/05.png',
      'assets/03.png',
      'assets/03.png',
    ];
    List title = [
      'M.S. Dhoni',
      'Virat',
      'warn buffet',
      'Salman',
      'K. rahul',
      'Popatlal',
    ];
    List subtitle = [
      'Marketing Coordinator',
      'Web Designer',
      'President of Sales',
      'Nursing Assistant',
      'Medical Assistant',
      'Nursing Assistant',
    ];

    List followers1 = [
      'assets/02.png',
      'assets/03.png',
      'assets/04.png',
      'assets/05.png',
      'assets/03.png',
    ];
    List title1 = [
      'Popatlal',
      'warn buffet',
      'Ajay devgan',
      'President',
      'Imran Khan',
    ];
    List subtitle1 = [
      'Actris Hollywood',
      'Software Tester',
      'President of Sales',
      'Project Manager',
      'Team Leader',
    ];

    List subctitle = [
      'Ambani Ltd',
      'Audi',
    ];
    List stitle = [
      'IOT Community',
      'Experience, Smart.',
    ];
    List subctitle1 = [
      'VR Ltd',
      'Platinum',
    ];

    List suggeation = [
      'Amitabh',
      'Kathiyan',
      'Jeronim',
      'Salman',
      'Unnati',
    ];
    List suggestion1 = [
      'Director of Product',
      'Marketing Specialist',
      'Sales Engineer',
      'Barista',
      'Content Strategist',
    ];
    List filter = [
      'Most Frequent Interactions',
      'Most Appearance',
      'Least Appearance',
      'Most Frequent Interactions',
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: const Text('Profile', style: TextStyle(color: Colors.black, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600, fontSize: 18)),
        centerTitle: true,
        actions: const [
          Icon(Icons.more_vert_sharp, color: Colors.black),
          SizedBox(width: 15,),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 10, bottom: 30),
              child: textfield1(text: 'Search..', text1: 'Search'),
            ),

            // Firat List
            GetBuilder<FollowScreenController>(
              builder: (controller) => SizedBox(
                height: 44,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        followScreenController.selected.value = index;
                        followScreenController.changecatwise(index: index);
                      },
                      child: Obx(
                        () => Container(
                          height: 44,
                          width: 123,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color:
                                followScreenController.selected.value == index
                                    ? AppColor.purple
                                    : Colors.white,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                                color: followScreenController.selectindex
                                        .contains(index)
                                    ? Colors.white
                                    : AppColor.purple),
                          ),
                          child: Center(
                            child: Text(profile[index], style: TextStyle(fontSize: 14, color: followScreenController.selected.value == index ? Colors.white : AppColor.purple, fontWeight: FontWeight.w700, fontFamily: 'Urbanist-bold')),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Second List
            GetBuilder<FollowScreenController>(
              builder: (controller) {
                return Column(
                  children: [
                    followScreenController.currentindex == 0
                        ? SizedBox(
                            width: 500,
                            child: ListTile(
                              leading: const Text('All Category', style: TextStyle(fontSize: 18, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600),),
                              trailing: SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: StatefulBuilder(
                                    builder: (context, setState) {
                                      return InkWell(
                                        onTap: () {
                                          showModalBottomSheet(
                                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                                            context: context,
                                            builder: (context) {
                                              return StatefulBuilder(
                                                builder: (context, setState) {
                                                  return  SizedBox(
                                                    height: 309,
                                                    width: 375,
                                                    child: Column(
                                                      children: [
                                                        const SizedBox(height: 20),
                                                        const Text('Filter Results', style: TextStyle(fontSize: 16, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600)),
                                                        const SizedBox(height: 20),
                                                        const Divider(height: 2, color: Color(0xffE2E8F0)),
                                                        ListTile(leading: Text(filter[0], style: const TextStyle(fontSize: 16, fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w500)),
                                                          trailing: Radio(
                                                            activeColor: AppColor.purple,
                                                            value: 1,
                                                            groupValue: followScreenController.gValue,
                                                            onChanged: (value) {setState(() => followScreenController.changeValue(value: value));
                                                            },
                                                          ),
                                                        ),
                                                        ListTile(leading: Text(filter[1], style: const TextStyle(fontSize: 16, fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w500)),
                                                          trailing: Radio(
                                                            activeColor: AppColor.purple,
                                                            value: 2,
                                                            groupValue: followScreenController.gValue,
                                                            onChanged: (value) {
                                                              setState(() => followScreenController.changeValue(value: value));
                                                            },
                                                          ),
                                                        ),
                                                        ListTile(leading: Text(filter[2],
                                                            style: const TextStyle(fontSize: 16, fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w500)),
                                                          trailing: Radio(
                                                            activeColor: AppColor.purple,
                                                            value: 3,
                                                            groupValue: followScreenController.gValue,
                                                            onChanged: (value) {setState(() => followScreenController.changeValue(value: value));
                                                            },
                                                          ),
                                                        ),
                                                        ListTile(
                                                          leading: Text(filter[3],
                                                              style: const TextStyle(fontSize: 16, fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w500)),
                                                          trailing: Radio(
                                                            activeColor: AppColor.purple,
                                                            value: 4,
                                                            groupValue: followScreenController.gValue,
                                                            onChanged: (value) {
                                                              setState(() => followScreenController.changeValue(value: value));
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          );
                                        },
                                        child: Image.asset(Appcontent.setting),
                                      );
                                    },
                                  )),
                            ),
                          )
                        : followScreenController.currentindex == 1
                            ? SizedBox(
                                width: 500,
                                child: ListTile(
                                  leading: const Text('All Category', style: TextStyle(fontSize: 18, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600),),
                                  trailing: SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: Image.asset(Appcontent.setting),
                                  ),
                                ),
                              )
                            : followScreenController.currentindex == 2
                                ? SizedBox(
                                    width: 500,
                                    child: ListTile(
                                      leading: const Text('All Category', style: TextStyle(fontSize: 18, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600),),
                                      trailing: SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: Image.asset(Appcontent.setting),
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    width: 500,
                                    child: ListTile(
                                      leading: const Text('Suggested For You', style: TextStyle(fontSize: 18, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600),),
                                      trailing: SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: Image.asset(Appcontent.setting),
                                      ),
                                    ),
                                  ),
                    followScreenController.currentindex == 0
                        ? Column(
                          children: [
                            SizedBox(
                              height: 500,
                              width: 500,
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemCount: followers.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: SizedBox(
                                      height: 48,
                                      width: 48,
                                      child: Container(
                                        height: 173,
                                        width: Get.size.width,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(image: AssetImage(followers[index]),fit: BoxFit.fill),
                                            borderRadius: BorderRadius.circular(100)),
                                      ),
                                    ),
                                    title: Text(
                                      title[index],
                                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Urbanist-semibold'),
                                    ),
                                    subtitle: Text(
                                      subtitle[index],
                                      style: const TextStyle(fontSize: 14, color: Color(0xff64748B), fontFamily: 'Urbanist-regular', fontWeight: FontWeight.w400),
                                    ),
                                    trailing: Container(
                                      height: 32,
                                      width: 83,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20),
                                        border: Border.all(
                                            width: 2,
                                            color: Colors.grey.shade200),
                                      ),
                                      child: Center(
                                        child: TextButton(
                                            onPressed: () {},
                                            child: const Text('Follow', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, fontFamily: 'Urbanist-semibold', color: AppColor.purple))),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        )
                        : followScreenController.currentindex == 1
                            ? Column(
                              children: [
                                SizedBox(
                                  height: 500,
                                  width: 500,
                                  child: ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    itemCount: 5,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        leading: SizedBox(
                                          height: 48,
                                          width: 48,
                                          child: Container(
                                            height: 173,
                                            width: Get.size.width,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(image: AssetImage(followers1[index]),fit: BoxFit.fill),
                                                borderRadius: BorderRadius.circular(100)),
                                          ),
                                        ),
                                        title: Text(title1[index], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Urbanist-semibold'),),
                                        subtitle: Text(subtitle1[index], style: const TextStyle(fontSize: 14, color: Color(0xff64748B), fontFamily: 'Urbanist-regular', fontWeight: FontWeight.w400),),
                                        trailing: SizedBox(
                                          width: 110,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                height: 32,
                                                width: 83,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20),
                                                  border: Border.all(width: 1, color: Colors.grey.shade200),
                                                ),
                                                child: const Center(
                                                  child: Text('Unfollow', style: TextStyle(fontSize: 12, color: Color(0xffFF4D2D), fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600)),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  showModalBottomSheet(
                                                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                                                    context: context,
                                                    builder: (context) {
                                                      return SizedBox(
                                                        height: 357,
                                                        child: Column(
                                                          children: [
                                                            const SizedBox(height: 20),
                                                            const Text('More Options', style: TextStyle(fontSize: 16, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600),),
                                                            const Padding(
                                                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                                              child: Divider(
                                                                height: 1,
                                                                thickness: 1,
                                                                color: Color(0xffE2E8F0),
                                                              ),
                                                            ),
                                                            ListTile(
                                                              leading: Container(
                                                                height: 48,
                                                                width: 48,
                                                                  decoration: BoxDecoration(
                                                                      image: DecorationImage(image: AssetImage(followers1[3]),fit: BoxFit.fill),
                                                                      borderRadius: BorderRadius.circular(100)),
                                                              ),
                                                              title: Text(title1[1], style: const TextStyle(fontSize: 16, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600)),
                                                              subtitle: Text(subtitle1[1], style: const TextStyle(fontSize: 14, color: Color(0xff64748B), fontFamily: 'Urbanist-regular', fontWeight: FontWeight.w400)),
                                                              trailing: Container(
                                                                height: 32,
                                                                width: 96,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(100),
                                                                  color: const Color(0xffFF4D2D),
                                                                ),
                                                                child: const Center(child: Text('Unfollow', style: TextStyle(fontSize: 12, color: Colors.white, fontFamily: 'Urbanist-bold', fontWeight: FontWeight.w700))),
                                                              ),
                                                            ),
                                                            const Padding(
                                                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                                              child: Divider(
                                                                height: 1,
                                                                thickness: 1,
                                                                color: Color(0xffE2E8F0),
                                                              ),
                                                            ),
                                                            GridView.builder(
                                                              physics: const NeverScrollableScrollPhysics(),
                                                              itemCount: img.length,
                                                              scrollDirection: Axis.vertical,
                                                              shrinkWrap: true,
                                                              padding: EdgeInsets.zero,
                                                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,mainAxisExtent: 70),
                                                              itemBuilder: (context, index) {
                                                                return Column(
                                                                  children: [
                                                                    Image.asset(img[index], height: 44, width: 44,),
                                                                    const SizedBox(height: 10,),
                                                                    Text(text[index], style: const TextStyle(fontSize: 12, fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w500),),
                                                                  ],
                                                                );
                                                              },
                                                            ),
                                                            const Padding(
                                                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                                                              child: Divider(
                                                                height: 1,
                                                                thickness: 1,
                                                                color: Color(0xffE2E8F0),
                                                              ),
                                                            ),
                                                            Row(
                                                              children: [
                                                                const SizedBox(width: 30,),
                                                                SizedBox(
                                                                  height: 20,
                                                                  width: 20,
                                                                  child: Image.asset('assets/info-circle.png', color: Colors.red,),
                                                                ),
                                                                const SizedBox(width: 10,),
                                                                const Text('Report', style: TextStyle(fontSize: 16, color: Color(0xffFF4D2D), fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w500)),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                                child: const Icon(Icons.more_vert),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            )
                            : followScreenController.currentindex == 2
                                ? Column(
                                  children: [
                                    SizedBox(
                                      height: 150,
                                      width: 500,
                                      child: ListView.builder(
                                        physics: const NeverScrollableScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemCount: 2,
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                            leading: SizedBox(
                                              height: 48,
                                              width: 48,
                                              child: Container(
                                                height: 173,
                                                width: Get.size.width,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(image: AssetImage(followers1[index]),fit: BoxFit.fill),
                                                    borderRadius: BorderRadius.circular(100)),
                                              ),
                                            ),
                                            title: Text(subctitle[index], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Urbanist-semibold'),),
                                            subtitle: Text(stitle[index], style: const TextStyle(fontSize: 14, color: Color(0xff64748B), fontWeight: FontWeight.w400, fontFamily: 'Urbanist-regular'),),
                                            trailing: Container(
                                              height: 32,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20),
                                                border: Border.all(width: 1, color: Colors.grey.shade200),
                                              ),
                                              child: const Center(
                                                child: Text('Unsubscribe', style: TextStyle(fontSize: 12, color: Color(0xffFF4D2D), fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600)),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    const ListTile(
                                      leading: Text('Similar Subscriptions', style: TextStyle(fontSize: 18)),
                                      trailing: Text('Clear All', style: TextStyle(fontSize: 12, color: AppColor.purple)),
                                    ),
                                    SizedBox(
                                      height: 200,
                                      width: 500,
                                      child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        itemCount: 2,
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                            leading: SizedBox(
                                              height: 48,
                                              width: 48,
                                              child: Container(
                                                height: 173,
                                                width: Get.size.width,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(image: AssetImage(followers1[index]),fit: BoxFit.fill),
                                                    borderRadius: BorderRadius.circular(100)),
                                              ),
                                            ),
                                            title: Text(subctitle1[index], style: const TextStyle(fontSize: 14),),
                                            subtitle: Text(suggestion1[index], style: const TextStyle(fontSize: 14, color: Color(0xff64748B)),),
                                            trailing: Container(
                                              height: 32,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20),
                                                border: Border.all(width: 2, color: Colors.grey.shade200),
                                              ),
                                              child: const Center(
                                                child: Text('Unsubscribe', style: TextStyle(fontSize: 12, color: Color(0xffFF4D2D))),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                )
                                : Column(
                                  children: [
                                    SizedBox(
                                      height: 500,
                                      width: 500,
                                      child: ListView.builder(
                                        physics: const NeverScrollableScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        itemCount: 5,
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                            leading: SizedBox(
                                              height: 48,
                                              width: 48,
                                              child: Container(
                                                height: 173,
                                                width: Get.size.width,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(image: AssetImage(followers1[index]),fit: BoxFit.fill),
                                                    borderRadius: BorderRadius.circular(100)),
                                              ),
                                            ),
                                            title: Text(suggeation[index], style: const TextStyle(fontSize: 14, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600),),
                                            subtitle: Text(suggestion1[index], style: const TextStyle(fontSize: 14, color: Color(0xff64748B), fontFamily: 'Urbanist-regular', fontWeight: FontWeight.w400),),
                                            trailing: SizedBox(
                                              width: 110,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    height: 32,
                                                    width: 83,
                                                    decoration:
                                                        BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(20),
                                                      border: Border.all(
                                                          width: 2,
                                                          color: Colors.grey
                                                              .shade200),
                                                    ),
                                                    child: const Center(
                                                      child: Text('Follow',
                                                          style: TextStyle(fontSize: 12, color: AppColor.purple, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600)),
                                                    ),
                                                  ),
                                                  const Icon(Icons.close),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                )
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}