import 'package:flutter/material.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController message = TextEditingController();

  List img = [
    'assets/chat1.png',
    'assets/chat2.png',
    'assets/chat3.png',
    'assets/chat4.png',
    'assets/chat5.png',
    'assets/chat6.png',
  ];
  List text = [
    'Camera',
    'Galery',
    'Document',
    'Audio',
    'Location',
    'Contact',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: Colors.white,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton:  Container(
            height: 40,
            color: Colors.white,
            child: Center(
              child: ListTile(
                leading: Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage(
                          'assets/05.png',
                        ),
                      ),
                      borderRadius: BorderRadius.circular(100)),
                ),
                title: SizedBox(
                  height: 40,
                  child: TextField(
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                      hintText: 'Type something in here...',
                      hintStyle: const TextStyle(
                          color: Color(0xffCBD5E1),
                          fontFamily: 'Urbanist-medium',
                          fontWeight: FontWeight.w500),
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      height: 300,
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            topLeft: Radius.circular(20),
                                          )),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 15,),
                                          const Center(child: Text('More Menu', style: TextStyle(fontSize: 16, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600),)),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                            child: Divider(height: 2, thickness: 1, color: Color(0xffE2E8F0),),
                                          ),
                                          GridView.builder(
                                            itemCount: img.length,
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 4),
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
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Image.asset('assets/happyemoji.png', height: 16, width: 16,)),
                          const SizedBox(width: 10,),
                          InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      height: 300,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                                        color: Colors.white,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          const Center(
                                              child: Text(
                                                'More Menu',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: 'Urbanist-semibold',
                                                    fontWeight: FontWeight.w600),
                                              )),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 20),
                                            child: Divider(
                                              height: 2,
                                              thickness: 1,
                                              color: Color(0xffE2E8F0),
                                            ),
                                          ),
                                          GridView.builder(
                                            itemCount: img.length,
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 4),
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
                                                  Image.asset(
                                                    img[index],
                                                    height: 44,
                                                    width: 44,
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    text[index],
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        fontFamily:
                                                        'Urbanist-medium',
                                                        fontWeight:
                                                        FontWeight.w500),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: const Icon(Icons.more_vert, color: Colors.grey, size: 16)),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                trailing: SizedBox(
                  height: 40,
                  width: 40,
                  child: FloatingActionButton(
                    heroTag: null,
                    backgroundColor: const Color(0xff3BBAA6),
                    elevation: 0,
                    onPressed: () {},
                    child: Image.asset(
                      'assets/send.png',
                      height: 24,
                      width: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // bottomNavigationBar:
          // Chat info
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                Stack(
                  children: [
                    SizedBox(
                      height: 32,
                      width: 32,
                      child: Container(
                        decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage('assets/05.png'),
                            ),
                            borderRadius: BorderRadius.circular(100)),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 18,
                      child: Container(
                        height: 12,
                        width: 12,
                        decoration: BoxDecoration(
                          color: const Color(0xff0AD67E),
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Colors.white, width: 1),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

          ),
          // Chat

        );
      }

}
