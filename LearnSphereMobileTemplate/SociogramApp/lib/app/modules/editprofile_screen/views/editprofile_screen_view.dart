import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociogram/app/modules/editpictre_screen/views/editpictre_screen_view.dart';
import 'package:sociogram/config/common_textfield.dart';

import '../../../../config/app_color.dart';
import '../controllers/editprofile_screen_controller.dart';

// ignore: must_be_immutable
class EditprofileScreenView extends GetView<EditprofileScreenController> {
  EditprofileScreenView({Key? key}) : super(key: key);
  EditprofileScreenController editprofileScreenController = Get.put(EditprofileScreenController());
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back, color: Colors.black,),
              ),
              title: const Text('Edit Profile', style: TextStyle(fontSize: 18, color: Colors.black)),
              centerTitle: true,
              actions: [
                SizedBox(
                    height: 24,
                    width: 24,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EditpictreScreenView()));
                      },
                      child: Image.asset('assets/arrow-right.png'),
                    )),
                const SizedBox(width: 15,),
              ],
            ),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 173,
                        width: Get.size.width,
                        decoration: const BoxDecoration(
                          image: DecorationImage(image: AssetImage('assets/Banner.png',),fit: BoxFit.fill),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                        ),
                      ),
                      Positioned(
                        right: 10,
                        top: 15,
                        child: SizedBox(
                          height: 40,
                          width: 186,
                          child: InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => EditpictreScreenView()));
                              },
                              child: Container(
                                height: 40,
                                width: 186,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.grey.withOpacity(0.3),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 16,
                                      width: 16,
                                      child: Image.asset('assets/camera.png'),
                                    ),
                                    const SizedBox(width: 10,),
                                    const Text('Change Background', style: TextStyle(fontSize: 14, color: Colors.white, fontFamily: 'Urbanist-semibold'),),
                                  ],
                                ),
                              ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 30,
                        bottom: -50,
                        child: Stack(
                          children: [
                           Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.indigo.shade300,
                              border: Border.all(color: Colors.white, width: 5),
                              shape: BoxShape.circle,
                              image: const DecorationImage(image: AssetImage('assets/InstaStory.png'),),
                            ),
                          ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                height: 32,
                                width: 32,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: AppColor.Secondary,
                                    border: Border.all(
                                        color: Colors.white, width: 3)),
                                child: Center(
                                  child: Image.asset(
                                    'assets/camera.png',
                                    height: 16,
                                    width: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 60),
                  const TabBar(
                    indicatorColor: AppColor.purple,
                    tabs: [
                      Tab(
                        child: Text('General', style: TextStyle(color: Colors.black, fontSize: 16)),
                      ),
                      Tab(
                        child: Text('Information', style: TextStyle(color: Colors.black, fontSize: 16)),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Column(
                      children: [
                        textfield3(text1: 'Name', text: 'Enter your name'),
                        textfield3(text1: 'Username', text: 'Enter your username'),
                        textfield3(text1: 'Bio Profile', text: 'Enter your Bio'),
                        textfield3(text1: 'Phone', text: 'Enter your number'),
                        textfield3(text1: 'Date of Birth', text: 'Enter your Date'),
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
