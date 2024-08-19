import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sociogram/app/modules/get_started/views/get_started_view.dart';
import 'package:sociogram/app/modules/login_screen/views/login_screen_view.dart';
import 'package:sociogram/config/app_color.dart';
import 'package:sociogram/config/app_contents.dart';
import 'package:sociogram/config/common_button.dart';

import '../controllers/onboarding1_controller.dart';

// ignore: must_be_immutable
class Onboarding1View extends GetView<Onboarding1Controller> {
  Onboarding1View({Key? key}) : super(key: key);

  final PageController _controller = PageController();
  Onboarding1Controller onboarding1controller =
      Get.put(Onboarding1Controller());

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(child: GetBuilder<Onboarding1Controller>(
            builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 400,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50)),
                          color: Colors.white,
                        ),
                        child: PageView(
                          controller: _controller,
                          children: const [
                            Image(image: AssetImage(Appcontent.onboarding1)),
                            Image(image: AssetImage(Appcontent.onboarding2)),
                            Image(image: AssetImage(Appcontent.onboarding3)),
                          ],
                          onPageChanged: (value) {
                            onboarding1controller.oninit(value: value);
                          },
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(30),
                            child: SmoothPageIndicator(
                              controller: _controller,
                              count: 3,
                              effect: const ExpandingDotsEffect(
                                activeDotColor: AppColor.purple,
                                dotHeight: 4,
                              ),
                            ),
                          ),
                          const Expanded(child: SizedBox(width: 80)),
                          Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: Container(
                              height: 32,
                              width: 80,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                  child: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const GetStartedView()));
                                      },
                                      child: const Text(
                                        'Skip',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: AppColor.purple, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600),
                                        overflow: TextOverflow.ellipsis,
                                      ))),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Expanded(child: SizedBox(height: 35)),
                  Padding(
                   padding: const EdgeInsets.only(left: 15),
                      child: onboarding1controller.index == 0
                          ? const Text('Always Connected\nAnywhere Anytime',
                          textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Urbanist'),
                              overflow: TextOverflow.ellipsis)
                          : onboarding1controller.index == 1
                              ? const Text('Enjoy Experiences\nWith New Friends',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 30, fontFamily: 'Urbanist'),
                                  overflow: TextOverflow.ellipsis)
                              : const Text('Discover Interesting\nThings Every Day',
                          textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 30, fontFamily: 'Urbanist'),
                                  overflow: TextOverflow.ellipsis)),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: onboarding1controller.index == 0
                        ? const Text(
                            'By using the hubline platform you can always be\nconnected anywhere anytime.',
                            style: TextStyle(fontSize: 14, color: Colors.grey, fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                          )
                        : onboarding1controller.index == 1
                            ? const Text(
                                'Enjoy your surfing experience on the hubline with\nyour new friends from all over the world.',
                                style:
                                    TextStyle(fontSize: 14, color: Colors.grey, fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w500),
                                overflow: TextOverflow.ellipsis)
                            : const Text(
                                'You can get new and interesting things every day\neven every second when you start scrolling.',
                                style:
                                    TextStyle(fontSize: 14, color: Colors.grey, fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w500),
                                overflow: TextOverflow.ellipsis),
                  ),
                  // SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 30, right: 30, bottom: 20, top: 20),
                    child: Center(
                      child: elevated(
                        text: 'Get Started',
                        onPress: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const GetStartedView()),);
                        },
                      ),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'I have an account ? ',
                        style: TextStyle(color: Colors.grey[500],fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LoginScreenView()));
                        },
                        child: const Text('Sign In',
                            style: TextStyle(
                                color: AppColor.purple,
                                fontFamily: 'Urbanist')),
                      ),
                    ],
                  ),
                  const Expanded(
                      child: SizedBox(
                    height: 10,
                  )),
                ],
              );
            },
          )),
        );
      },
    );
  }
}
