import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'activity_screen_controller.dart';

// ignore: must_be_immutable
class TimespentScreenView extends GetView<ActivityScreenController> {
   TimespentScreenView({Key? key}) : super(key: key);
   ActivityScreenController activityScreenController = Get.put(ActivityScreenController());
  List<ChartData> chartData = [
    ChartData(1, 15,0),
    ChartData(2, 23,0),
    ChartData(3, 34,0),
    ChartData(4, 25,0),
    ChartData(5, 40,0)
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back, color: Colors.black,),
        ),
        title: const Text('Time Spent', style: TextStyle(fontSize: 18, color: Colors.black, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600),),
        centerTitle: true,
        actions: [
          SizedBox(
              height: 24,
              width: 24,
              child: Image.asset('assets/info-circle1.png')),
          const SizedBox(width: 15,),
        ],
      ),

    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.y1);
  final int x;
  final double y;
  final double y1;
}
