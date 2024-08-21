import 'package:flutter/material.dart';
import 'package:sociogram/app/modules/notification_screen/followrequest_screen.dart';

import '../../../config/common_textfield.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List img = [
    'assets/02.png',
    'assets/03.png',
  ];
  List text = [
    'Rudiey03 ',
    'Alfarend, and 87 other\npeople  ',
  ];
  List text1 = [
    'following you',
    'like your story.',
  ];
  List button = [
    'Follow',
    'See More',
  ];

  List text01 = [
    'Andhi12 ',
    'Aldytore_ ',
  ];
  List text02 = [
    'following you',
    'mentioned you in\na comment.',
  ];
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back, color: Colors.black,),
            ),
            centerTitle: true,
            title: const Text('Notification', style: TextStyle(fontSize: 18, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600, color: Colors.black),),
            actions: const [
              Center(child: Text('2 News', style: TextStyle(fontSize: 14, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600, color: Color(0xffFF4D2D)),)),
              SizedBox(width: 15,),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              General(text: 'Search'),
              ListTile(
                leading: const Text('Newest', style: TextStyle(fontSize: 18, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600),),
                trailing: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const FollowrequestScreen(),));
                  },
                    child: const Text('View All  ', style: TextStyle(fontSize: 12, fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w500, color: Color(0xff3BBAA6)),)),
              ),

              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: img.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: Stack(
                          children: [
                            Container(
                              height: 48,
                              width: 48,
                                decoration: BoxDecoration(
                                    image: DecorationImage(image: AssetImage(img[index]),fit: BoxFit.fill),
                                    borderRadius: BorderRadius.circular(100)),
                            ),
                            Positioned(
                              left: 33,
                                child: Container(
                                  height: 16,
                                  width: 16,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffFF4D2D),
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(color: Colors.white, width: 2)
                                  ),
                                ),
                            ),
                          ],
                        ),
                        title: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(text: text[index], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'Urbanist-regular', color: Colors.black)),
                              TextSpan(text: text1[index], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, fontFamily: 'Urbanist-regular', color: Colors.black)),
                            ]
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10,),
                            Container(
                              height: 32,
                              width: 83,
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xffE2E8F0), width: 1),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(child: Text(button[index], style: const TextStyle(fontSize: 12, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600, color: Color(0xff3BBAA6)),)),
                            ),
                          ],
                        ),
                        trailing: const Text('Today', style: TextStyle(fontSize: 12, fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w500, color: Color(0xff64748B)),),
                      ),
                      const SizedBox(height: 15,),
                    ],
                  );
              },),

              ListTile(
                leading: const Text('This Month', style: TextStyle(fontSize: 18, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600),),
                trailing: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const FollowrequestScreen(),));
                  },
                    child: const Text('View All  ', style: TextStyle(fontSize: 12, fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w500, color: Color(0xff3BBAA6)),)),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: img.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: Container(
                          height: 48,
                          width: 48,
                            decoration: BoxDecoration(
                                image: DecorationImage(image: AssetImage(img[index]),fit: BoxFit.fill),
                                borderRadius: BorderRadius.circular(100)),
                        ),
                        title: RichText(
                          text: TextSpan(
                              children: [
                                TextSpan(text: text01[index], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'Urbanist-regular', color: Colors.black)),
                                TextSpan(text: text02[index], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, fontFamily: 'Urbanist-regular', color: Colors.black)),
                              ]
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10,),
                            Container(
                              height: 32,
                              width: 83,
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xffE2E8F0), width: 1),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(child: Text(button[index], style: const TextStyle(fontSize: 12, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600, color: Color(0xff3BBAA6)),)),
                            ),
                          ],
                        ),
                        trailing: const Text('2 Months', style: TextStyle(fontSize: 12, fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w500, color: Color(0xff64748B)),),
                      ),
                      const SizedBox(height: 15,),
                    ],
                  );
                },),
            ],
          ),
        );
      },
    );
  }
}
