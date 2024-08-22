import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociogram/app/modules/editpictre_screen/controllers/editpictre_screen_controller.dart';

import '../../../../config/app_color.dart';

// ignore: must_be_immutable
class EditpictreScreenView extends GetView<EditpictreScreenController> {
  EditpictreScreenView({Key? key}) : super(key: key);
  EditpictreScreenController editpictreScreenController = Get.put(EditpictreScreenController());

  @override
  Widget build(BuildContext context) {
    List button = [
      'Filter',
      'Brightness',
      'Crop',
      'Saturation',
    ];
    List crop = [
      'assets/Original.png',
      'assets/Custom.png',
      'assets/Symmetric.png',
    ];
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back, color: Colors.black),
            ),
            title: const Text('Edit Picture', style: TextStyle(fontSize: 18, color: Colors.black, fontFamily: 'Urbanist-semibold')),
            centerTitle: true,
            actions: [
              SizedBox(
                height: 24,
                width: 24,
                child: Image.asset('assets/arrow-right.png'),
              ),
              const SizedBox(width: 15,),
            ],
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  color: const Color(0xffF8F9FD),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            height: 223,
                              child: Image.asset('assets/Rectangle 22760.png')),
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                              child: Image.asset('assets/Crop.png'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 321.5,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20),),),
                  child: Column(
                    children: [
                      ListTile(
                        leading: InkWell(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.close, color: Colors.black,),
                        ),
                        title: const Center(child: Text('Crop', style: TextStyle(fontSize: 16, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600),)),
                        trailing: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Save', style: TextStyle(fontSize: 16, color: AppColor.purple, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600),),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Image.asset('assets/tilt.png'),
                      const SizedBox(height: 10),
                      GetBuilder<EditpictreScreenController>(builder: (context) {
                        return Container(
                          height: 76,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: crop.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                height: 76,
                                width: 105,
                                child: InkWell(
                                  onTap: () {
                                    editpictreScreenController.select.value = index;
                                  },
                                  child: Obx(
                                        () => Image.asset(crop[index], color: editpictreScreenController.select.value == index ? Colors.black : Colors.grey,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 44,
                        child: GetBuilder<EditpictreScreenController>(
                          builder: (controller) {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: button.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    editpictreScreenController.selected.value = index;
                                  },
                                  child: Obx(() => Container(
                                    height: 44,
                                    width: 100,
                                    margin: const EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                      color: editpictreScreenController.selected.value == index ? AppColor.purple : Colors.white,
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(color: editpictreScreenController.selectIndex.contains(index) ? Colors.white : AppColor.purple),
                                    ),
                                    child: Center(
                                      child: Text(button[index], style: TextStyle(fontSize: 14, color: editpictreScreenController.selected.value == index ? Colors.white : AppColor.purple, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600)),
                                    ),
                                  )),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      const Expanded(child: SizedBox(height: 20,)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
