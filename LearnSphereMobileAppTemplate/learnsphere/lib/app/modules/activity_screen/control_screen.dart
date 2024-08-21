// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociogram/app/modules/activity_screen/activity_screen_controller.dart';

import '../../../config/app_color.dart';
import '../../../config/common_textfield.dart';

class ControlScreenView extends GetView<ActivityScreenController>{
  ControlScreenView({Key? key}) : super(key: key);

  ActivityScreenController activityScreenController = Get.put(ActivityScreenController());

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
            title: const Text('Content Control', style: TextStyle(fontSize: 18, color: Colors.black, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600),),
            centerTitle: true,
            actions: [
              SizedBox(
                  height: 24,
                  width: 24,
                  child: Image.asset('assets/setting-4.png')),
              const SizedBox(width: 15,),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                  child: textfield1(text: 'Search..', text1: 'Search'),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10, top: 20),
                  child: Text('What is Content Control?', style: TextStyle(fontSize: 18, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600),),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 20, top: 20),
                  child: RichText(
                    text: const TextSpan(
                        children: [
                          TextSpan(text: "This setting controls the sensitive content you see from accounts you don't follow.", style: TextStyle(fontSize: 14, color: Color(0xff64748B), fontFamily: 'Urbanist-regular', fontWeight: FontWeight.w400)),
                          TextSpan(text: " Learn More.", style: TextStyle(fontSize: 14, color: AppColor.purple, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600)),
                        ]),
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.only(left: 10, top: 20),
                  child: Text('Choose The Settings Control.', style: TextStyle(fontSize: 18, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600),),
                ),

                const SizedBox(height: 20,),
                StatefulBuilder(
                  builder: (context, setState) {
                    return Column(
                      children: [
                        ListTile(
                          leading: const Text('Aggressive', style: TextStyle(fontSize: 16, fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w500)),
                          trailing: Radio(
                            activeColor: AppColor.purple,
                            value: 0,
                            groupValue: activityScreenController.gValue,
                            onChanged: (value) {setState(() => activityScreenController.changeValue(value: value));
                            },
                          ),
                        ),
                        ListTile(
                          leading: const Text('Standard', style: TextStyle(fontSize: 16, fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w500)),
                          trailing: Radio(
                            activeColor: AppColor.purple,
                            value: 1,
                            groupValue: activityScreenController.gValue,
                            onChanged: (value) {setState(() => activityScreenController.changeValue(value: value));
                            },
                          ),
                        ),
                        ListTile(
                          leading: const Text('Less', style: TextStyle(fontSize: 16, fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w500)),
                          trailing: Radio(
                            activeColor: AppColor.purple,
                            value: 2,
                            groupValue: activityScreenController.gValue,
                            onChanged: (value) {setState(() => activityScreenController.changeValue(value: value));
                            },
                          ),
                        ),
                        ListTile(
                          leading: const Text('No Control', style: TextStyle(fontSize: 16, fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w500)),
                          trailing: Radio(
                            activeColor: AppColor.purple,
                            value: 3,
                            groupValue: activityScreenController.gValue,
                            onChanged: (value) {setState(() => activityScreenController.changeValue(value: value));
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}