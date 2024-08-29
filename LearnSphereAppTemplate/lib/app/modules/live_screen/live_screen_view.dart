import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociogram/app/modules/live_screen/live_screen_controller.dart';
import 'package:sociogram/config/common_textfield.dart';

class LiveScreenView extends GetView<LiveScreenController> {
  const LiveScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List img = [
      'assets/02.png',
      'assets/03.png',
      'assets/04.png',
    ];
    List text = [
      'M.S. Dhoni',
      'Alon musk',
      'Ronald konal',
    ];
    List subtext = [
      'Awesome dude! Where are you?',
      'Soo great!!!',
      'Thanks for sharing destination',
    ];
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: SizedBox(
            height: Get.size.height,
            width: Get.size.width,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                          height: Get.size.height,
                          width: Get.size.width,
                          child: Image.asset('assets/livepic.png', fit: BoxFit.fill,)),
                      Padding(
                        padding: const EdgeInsets.only(top: 30, left: 5),
                        child: ListTile(
                          leading: Container(
                            height: 56,
                            width: 56,
                              decoration: BoxDecoration(
                                  image: const DecorationImage(image: AssetImage('assets/05.png',),),
                                  borderRadius: BorderRadius.circular(100)),
                          ),
                          title: const Text('Williamson', style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'Urbanist-semibold'),),
                          subtitle: Row(
                            children: [
                              const SizedBox(width: 3,),
                              Container(
                                height: 20,
                                width: 39,
                                decoration: BoxDecoration(
                                  color: const Color(0xffE12F0F),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Center(child: Text('Live', style: TextStyle(fontSize: 12, color: Colors.white, fontFamily: 'Urbanist-semibold'),)),
                              ),
                              const SizedBox(width: 10,),
                              const Text(
                                '00:03:27',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xffE2E8F0),
                                    fontFamily: 'Urbanist-medium'),
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 24,
                                child: Image.asset('assets/eye-slash.png', color: Colors.white,),
                              ),
                              const SizedBox(width: 10,),
                              GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: const Icon(Icons.close, color: Colors.white,)),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 30,
                        left: 0,
                        right: 0,
                        child: Column(
                          children: [
                            ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: img.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: Container(
                                    height: 50,
                                    width: 50,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(image: AssetImage(img[index]),),
                                          borderRadius: BorderRadius.circular(100)),
                                  ),
                                  title: Text(
                                    text[index],
                                    style: const TextStyle(
                                        fontFamily: 'Urbanist-semibold',
                                        fontSize: 14,
                                        color: Colors.white),
                                  ),
                                  subtitle: Text(
                                    subtext[index],
                                    style: const TextStyle(
                                        fontFamily: 'Urbanist-regular',
                                        fontSize: 12,
                                        color: Color(0xffE2E8F0)),
                                  ),
                                );
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10, top: 30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  livetextfield(
                                    text: 'Add Comment',
                                  ),
                                  Container(
                                    height: 44,
                                    width: 44,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Colors.grey.withOpacity(0.40),
                                    ),
                                    child: Center(
                                        child: Image.asset(
                                      'assets/send-2.png',
                                      height: 20,
                                    )),
                                  ),
                                  Container(
                                    height: 44,
                                    width: 44,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: const Color(0xffE12F0F),
                                    ),
                                    child: Center(
                                        child: Image.asset(
                                      'assets/heart1.png',
                                      height: 20,
                                    )),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
