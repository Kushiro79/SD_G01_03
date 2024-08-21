// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociogram/app/modules/message_screen/chatscreen.dart';

import '../../../config/app_color.dart';
import '../../../config/common_textfield.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  SingingCharacter? _character = SingingCharacter.a;
  List img = [
    'assets/02.png',
    'assets/03.png',
    'assets/04.png',
    'assets/05.png',
    'assets/03.png',
  ];
  List text = [
    'M.S. Dhoni',
    'Alon musk',
    'Farrukh',
    'Popatlal',
    'Muatfa yeaf',
  ];
  List subtext = [
    'Typing Message...',
    'perfect!',
    'just ideas for next time',
    'How are you?',
    "So, what's your plan this week...",
  ];
  List time = [
    'Online',
    'Today',
    'Today',
    '27/01',
    '25/01',
  ];
  List<Color> colors = [
    const Color(0xff3BBAA6),
    const Color(0xff64748B),
    const Color(0xff64748B),
    const Color(0xff64748B),
    const Color(0xff64748B),
  ];
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          return DefaultTabController(
            length: 2,
            initialIndex: 0,
            child: Scaffold(
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
                title: const Text('Message', style: TextStyle(fontSize: 18, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600, color: Colors.black),),
                actions: [
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(builder: (context, setState) {
                              return  SizedBox(
                                height: 309,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 20),
                                    const Text('Filter Results', style: TextStyle(fontSize: 16)),
                                    const SizedBox(height: 20),
                                    const Divider(
                                        height: 2,
                                        color:
                                        Color(0xffE2E8F0)),
                                    ListTile(
                                      leading: const Text('Unread', style: TextStyle(fontSize: 16)),
                                      trailing: Radio(
                                        activeColor: AppColor.purple,
                                        value: SingingCharacter.a,
                                        groupValue: _character,
                                        onChanged: (value) {
                                          setState(() {
                                            _character = value;
                                          });
                                        },
                                      ),
                                    ),
                                    ListTile(
                                      leading: const Text('Tagged ', style: TextStyle(fontSize: 16)),
                                      trailing: Radio(
                                        activeColor: AppColor.purple,
                                        value: SingingCharacter.b,
                                        groupValue: _character,
                                        onChanged: (value) {
                                          setState(() {
                                            _character = value;
                                          });
                                        },
                                      ),
                                    ),
                                    ListTile(leading: const Text('Not Replied', style: TextStyle(fontSize: 16)),
                                      trailing: Radio(
                                        activeColor: AppColor.purple,
                                        value: SingingCharacter.c,
                                        groupValue: _character,
                                        onChanged: (value) {
                                          setState(() {
                                            _character = value;
                                          });
                                        },
                                      ),
                                    ),
                                    ListTile(
                                      leading: const Text('Request', style: TextStyle(fontSize: 16)),
                                      trailing: Radio(
                                        activeColor: AppColor.purple,
                                        value: SingingCharacter.d,
                                        groupValue: _character,
                                        onChanged: (value) {
                                          setState(() {
                                            _character = value;
                                          });
                                        },
                                      ),
                                    ),
                                    const Expanded(child: SizedBox(height: 10,)),
                                  ],
                                ),
                              );
                            },);
                          },
                      );
                    },
                      child: Image.asset('assets/setting-4.png', height: 24, width: 24,)),
                  const SizedBox(width: 15,),
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: General(text: 'Search'),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: TabBar(
                        indicatorColor: Color(0xff3BBAA6),
                          labelColor: Colors.black,
                          labelStyle: TextStyle(fontSize: 16, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600, color: Colors.black),
                          tabs: [
                        Tab(text: 'General',),
                        Tab(text: 'Request',),
                      ]),
                    ),

                    const SizedBox(height: 20,),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatScreen(),));
                      },
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: img.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              ListTile(
                                leading: Container(
                                  height: 44,
                                  width: 44,
                                  margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                                  child: Container(
                                    height: 173,
                                    width: Get.size.width,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(image: AssetImage(img[index],),fit: BoxFit.fill),
                                        borderRadius: BorderRadius.circular(100)),
                                  ),
                                ),
                                title: Text(text[index], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'Urbanist-regular', color: Colors.black)),
                                subtitle: Text(subtext[index], style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'Urbanist-regular', color: colors[index])),
                                trailing: Text(time[index], style: const TextStyle(fontSize: 12, fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w500, color: Color(0xff64748B)),),
                              ),
                              const SizedBox(height: 10,),
                            ],
                          );
                        },),
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
                                height: 44,
                                width: 44,
                                margin:
                                const EdgeInsets.symmetric(horizontal: 10),
                                child: Container(
                                  height: 173,
                                  width: Get.size.width,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(image: AssetImage(img[index],),fit: BoxFit.fill),
                                      borderRadius: BorderRadius.circular(100)),
                                ),
                              ),
                              title: Text(text[index], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'Urbanist-regular', color: Colors.black)),
                              subtitle: Text(subtext[index], style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'Urbanist-regular', color: colors[index])),
                              trailing: Text(time[index], style: const TextStyle(fontSize: 12, fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w500, color: Color(0xff64748B)),),
                            ),
                            const SizedBox(height: 10,),
                          ],
                        );
                      },),
                  ],
                ),
              ),
            ),
          );
        },
    );
  }
}
enum SingingCharacter {a, b, c, d}