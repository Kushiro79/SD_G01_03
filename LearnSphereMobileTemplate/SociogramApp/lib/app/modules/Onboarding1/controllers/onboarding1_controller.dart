import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Onboarding1Controller extends GetxController {
  final controller = PageController(viewportFraction: 0.8, keepPage: true);
  int index = 0;
  final count = 0.obs;
 oninit({int?value}){
   index = value!;
   update();
 }

  void increment() => count.value++;
}
