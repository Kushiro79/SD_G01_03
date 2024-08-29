import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociogram/config/bottom_navigation.dart';

import '../../../../config/app_color.dart';
import '../../../../config/app_contents.dart';
import '../../../../config/common_button.dart';
import '../controllers/pronouns_screen_controller.dart';

// ignore: must_be_immutable
class PronounsScreenView extends GetView<PronounsScreenController> {
    PronounsScreenView({Key? key}) : super(key: key);
    PronounsScreenController pronounsScreenController = Get.put(PronounsScreenController());
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back_rounded, color: Colors.black,)),
                trailing: Container(
                  height: 32,
                  width: 80,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    // color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                      child: TextButton(
                          onPressed: () {},
                          child: const Text('Skip', style: TextStyle(fontSize: 12, color: AppColor.purple, fontFamily: 'Urbanist-semibold')))),
                ),
              ),

              const Padding(padding: EdgeInsets.only(left: 15, top: 30),
                child: Text('Choose Is Your\nPronouns ?', style: TextStyle(fontFamily: 'Urbanist-bold', fontSize: 32),  overflow: TextOverflow.ellipsis),
              ),

              Padding(padding: const EdgeInsets.only(left: 15, top: 20, bottom: 35),
                child: Text('This information helps we provide be better\ncontent for you.', style: TextStyle(fontSize: 14, color: Colors.grey[500], fontFamily: 'Urbanist-medium',),  overflow: TextOverflow.ellipsis),
              ),

              Center(
                child: GetBuilder<PronounsScreenController>(builder: (context) {
                  return Container(
                    height: 62,
                    width: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      border: Border.all(color: const Color(0xffE2E8F0)),
                    ),
                    child: ListTile(
                      onTap: () => pronounsScreenController.changeValue(value: 1),
                      leading: SizedBox(
                        height: 20,
                        width: 20,
                        child: Image.asset(Appcontent.user),
                      ),
                      title: const Text('She', style: TextStyle(fontFamily: 'Urbanist-medium', fontSize: 16)),
                      trailing: Radio(
                        activeColor: AppColor.purple,
                        value: 1,
                        groupValue: pronounsScreenController.gValue,
                        onChanged: (value) {
                          pronounsScreenController.changeValue(value: value);
                        },
                      ),
                    ),
                  );
                },),
              ),

              const SizedBox(height: 20),
              Center(
                child: GetBuilder<PronounsScreenController>(builder: (context) {
                  return Container(
                    height: 62,
                    width: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      border: Border.all(color: const Color(0xffE2E8F0)),
                    ),
                    child: ListTile(
                      onTap: () => pronounsScreenController.changeValue(value: 2),
                      leading: SizedBox(
                        height: 20,
                        width: 20,
                        child: Image.asset(Appcontent.user),
                      ),
                      title: const Text('He', style: TextStyle(fontFamily: 'Urbanist-medium', fontSize: 16)),
                      trailing: Radio(
                        activeColor: AppColor.purple,
                        value: 2,
                        groupValue: pronounsScreenController.gValue,
                        onChanged: (value) {
                          pronounsScreenController.changeValue(value: value);
                        },
                      ),
                    ),
                  );
                },),
              ),

              const SizedBox(height: 20),
              Center(
                child: GetBuilder<PronounsScreenController>(builder: (context) {
                  return Container(
                    height: 62,
                    width: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      border: Border.all(color: const Color(0xffE2E8F0)),
                    ),
                    child: ListTile(
                      onTap: () => pronounsScreenController.changeValue(value: 3),
                      leading: SizedBox(
                        height: 24,
                        width: 24,
                        child: Image.asset(Appcontent.people),
                      ),
                      title: const Text('They', style: TextStyle(fontFamily: 'Urbanist-medium', fontSize: 16)),
                      trailing: Radio(
                        activeColor: AppColor.purple,
                        value: 3,
                        groupValue: pronounsScreenController.gValue,
                        onChanged: (value) {
                          pronounsScreenController.changeValue(value: value);
                        },
                      ),
                    ),
                  );
                },),
              ),

              const Expanded(child: SizedBox(height: 200)),
              Center(
                child: elevated(text: 'Next', onPress: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Bottom()),);
                },),
              ),
              const SizedBox(height: 20,),
            ],
          ),
      ),
    );
  }
}
