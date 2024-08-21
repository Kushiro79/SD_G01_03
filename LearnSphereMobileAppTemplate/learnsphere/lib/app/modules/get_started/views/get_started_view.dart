import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociogram/app/modules/login_screen/views/login_screen_view.dart';
import 'package:sociogram/app/modules/register/views/register_view.dart';
import 'package:sociogram/config/app_color.dart';
import 'package:sociogram/config/app_contents.dart';
import 'package:sociogram/config/common_button.dart';

import '../controllers/get_started_controller.dart';

class GetStartedView extends GetView<GetStartedController> {
  const GetStartedView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Center(
              child: Column(
                children: [
                  const Expanded(child: SizedBox(height: 40)),
                  const Image(image: AssetImage(Appcontent.getstarted), height: 315),
                  Container(
                    height: 350,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text('Get Started', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, fontFamily: 'Urbanist-bold'), overflow: TextOverflow.ellipsis),
                        Text('Sign in or register for see what\n\t\t\t\t\t\t\t\t\thappening near you.', style: TextStyle(fontSize: 14, color: Colors.grey.shade500, fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 56,
                              width: 155.5,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade200),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: Image.asset(Appcontent.google),
                                  ),
                                  const Text('Google', style: TextStyle(fontSize: 16, color: Colors.black, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                            Container(
                              height: 56,
                              width: 155.5,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade200),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: Image.asset(Appcontent.apple),
                                  ),
                                  const Text('Apple', style: TextStyle(fontSize: 16, color: Colors.black, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(padding: const EdgeInsets.only(left: 8, right: 8),
                          child: elevated(text: 'Login with Email',
                              onPress: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreenView()),);
                              }),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don’t have an account ? ', style: TextStyle(color: Colors.grey[500], fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis),
                            InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterView()));
                              },
                              child: const Text('Register', style: TextStyle(color: AppColor.purple, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ),
                      ],
                    ),
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
