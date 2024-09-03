import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/common_textfield.dart';
import 'user_setting_controller.dart';

@RoutePage()
class UserSettingScreenView extends GetView<ActivityScreenController> {
  const UserSettingScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    List img = [
      'assets/security-user.png',
      'assets/info-circle1.png',
      'assets/direct.png',
      'assets/login.png',
      'assets/sms-notification.png',
      'assets/document.png',
    ];
    List text = [
      'Privacy',
      'Account Created',
      'History Device',
      'History Login',
      'History E-mail',
      'History Username',
    ];
    List sutext = [
      "You made your account mode on view\nPublic.",
      "You crerated your account on\nDecember 28, 2019.",
      "History of devices connected to your\naccount.",
      "History history of devices logged in with\nyour account",
      "History of email changes in your\naccount",
      'History of username changes in your\naccount',
    ];
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            title: const Text(
              'Account History',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontFamily: 'Urbanist-semibold',
                  fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
            actions: [
              SizedBox(
                  height: 24,
                  width: 24,
                  child: Image.asset('assets/setting-4.png')),
              const SizedBox(
                width: 15,
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 30),
                  child: textfield1(text: 'Search..', text1: 'Search'),
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: img.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: InkWell(
                        onTap: () {},
                        child: ListTile(
                          leading: Stack(
                            children: [
                              Container(
                                height: 48,
                                width: 48,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: const Color(0xffF8F9FD),
                                ),
                              ),
                              Positioned(
                                top: 11,
                                left: 0,
                                right: 0,
                                child: SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: Image.asset(img[index]),
                                ),
                              ),
                            ],
                          ),
                          title: Text(
                            text[index],
                            style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Urbanist-semibold',
                                fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(
                            sutext[index],
                            style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xff64748B),
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Urbanist-medium'),
                          ),
                          trailing: const Icon(Icons.navigate_next),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
