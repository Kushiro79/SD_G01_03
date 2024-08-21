import 'package:flutter/material.dart';

import '../../../config/common_textfield.dart';

class FollowrequestScreen extends StatefulWidget {
  const FollowrequestScreen({super.key});

  @override
  State<FollowrequestScreen> createState() => _FollowrequestScreenState();
}

class _FollowrequestScreenState extends State<FollowrequestScreen> {
  List img = [
    'assets/02.png',
    'assets/03.png',
    'assets/04.png',
    'assets/05.png',
    'assets/03.png',
  ];
  List text = [
    'Rudiey03 following you',
    'Albertfs following you.',
    'Talista12 following you.',
    'Aldyroy following you.',
    'Xaviero following you.',
  ];
  List time = [
    'Today',
    'Yesterday',
    'Yesterday',
    '29/01',
    '28/01',
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
              leading: InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back, color: Colors.black,),
              ),
              centerTitle: true,
              title: const Text('Notification', style: TextStyle(fontSize: 18, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600, color: Colors.black),),
              actions: const [
                Center(child: Text('1 News', style: TextStyle(fontSize: 14, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600, color: Color(0xffFF4D2D)),)),
                SizedBox(width: 15,),
              ],
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                General(text: 'Search'),
                const ListTile(
                  leading: Text('Newest', style: TextStyle(fontSize: 18, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600),),
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
                          title: Text(text[index], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'Urbanist-regular', color: Colors.black)),
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
                                child: const Center(child: Text('Follow', style: TextStyle(fontSize: 12, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600, color: Color(0xff3BBAA6)),)),
                              ),
                            ],
                          ),
                          trailing: Text(time[index], style: const TextStyle(fontSize: 12, fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w500, color: Color(0xff64748B)),),
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
