import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociogram/app/modules/birthday_screen/views/birthday_screen_view.dart';
import 'package:sociogram/config/common_button.dart';

import '../../../../config/app_color.dart';
import '../controllers/interest_screen_controller.dart';

// ignore: must_be_immutable
class InterestScreenView extends GetView<InterestScreenController> {
   InterestScreenView({Key? key}) : super(key: key);

  InterestScreenController interestScreenController = Get.put(InterestScreenController());
  @override
  Widget build(BuildContext context) {
    List interest = [
      'assets/photo.png',
      'assets/science.png',
      'assets/design.png',
      'assets/gaming.png',
      'assets/food.png',
      'assets/health.png',
      'assets/fashion.png',
      'assets/movie.png',
      'assets/education.png',
      'assets/sport.png',
      'assets/holiday.png',
      'assets/travel.png',
      'assets/community.png',
      'assets/Business.png',
    ];

    List text = [
      'Fotography',
      'Science ',
      'Design',
      'Gaming',
      'Food & drink',
      'Health',
      'Fashion',
      'Film & Media',
      'Education',
      'Sport',
      'Holiday',
      'Travel',
      'Community',
      'Business',
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
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
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                        child: TextButton(
                            onPressed: () {},
                            child: const Text('Skip', style: TextStyle(fontSize: 12, color: AppColor.purple)))),
                  ),
                ),

                const Padding(padding: EdgeInsets.only(left: 15, top: 30),
                  child: Text('Choose According\nTo Your Interests.', style: TextStyle(fontSize: 32, fontFamily: 'Urbanist-bold', fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis),
                ),

                Padding(padding: const EdgeInsets.only(left: 15, top: 20),
                  child: Text('Specify interests that you might like. ', style: TextStyle(fontSize: 14, color: Colors.grey[500], fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis),
                ),

                const SizedBox(height: 20),
                Expanded(
                  child: GetBuilder<InterestScreenController>(builder: (controller) => GridView.builder(
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 300, crossAxisSpacing: 20, mainAxisSpacing: 20, childAspectRatio: 4),
                    itemCount: 14,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          interestScreenController.changeValue(value: index);
                        },
                        child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            height: 44,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: interestScreenController.selectIndex.contains(index) ? AppColor.purple : Colors.grey.shade300),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 23,
                                  width: 23,
                                  child: Image.asset(interest[index]),
                                ),
                                const SizedBox(width: 10),
                                Text(text[index], style: TextStyle(fontSize: 14, color: interestScreenController.selectIndex.contains(index) ? AppColor.purple : Colors.black, fontFamily: 'Urbanist-semibold')),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),),
                ),

                Center(
                  child: elevated(text: 'Next', onPress: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const BirthdayScreenView()),);
                  },),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
