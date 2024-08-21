import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociogram/config/common_button.dart';

import '../../../../config/app_color.dart';
import '../controllers/filter_screen_controller.dart';

class FilterScreenView extends GetView<FilterScreenController> {
  const FilterScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List text1 = [
      'Latest',
      'Most Popular',
      'Name',
      'Account',
      'Most suitable',
      'Recommend',
    ];

    List category = [
      'Celebrities',
      'Influencer',
      'Actors',
      'Musicians',
      'Comedians',
      'Band',
      'Presenter',
      'Creater',
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.close, color: Colors.black),
        ),
        title: const Text('Filter Screen', style: TextStyle(fontSize: 18, color: Color(0xff0F172A), fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const Text('Sort By', style: TextStyle(fontSize: 18, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600)),

              const SizedBox(height: 20),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 165, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 4),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: const Color(0xffE2E8F0)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(text1[index], style: const TextStyle(fontSize: 14, color: AppColor.purple, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 30),
              const Text('Date', style: TextStyle(fontSize: 18, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600)),

              CalendarDatePicker2(
                config: CalendarDatePicker2Config(
                  calendarType: CalendarDatePicker2Type.range,
                ),
                value: const [],
                // onValueChanged: (dates) => _dates = dates,
              ),

              const ListTile(
                leading: Text('Category', style: TextStyle(fontSize: 18, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600)),
                trailing: Text('Show All', style: TextStyle(fontSize: 12, color: AppColor.purple, fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w500)),
              ),

              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 165, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 4),
                itemCount: 8,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: const Color(0xffE2E8F0)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(category[index], style: const TextStyle(fontSize: 12, color: AppColor.purple, fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  );
                },
              ),

              Padding(
                padding: const EdgeInsets.only(left: 20, top: 30, bottom: 20),
                child: elevated(
                  text: 'Apply',
                  onPress: () {
                  Navigator.pop(context);
                },),
              ),
            ],
          ),
        ),
      ),
    );
  }
}