import 'package:get/get.dart';

class LiveScreenController extends GetxController{

  final count = 0.obs;

  // RxString dropdownValue = list.first.obs;

  void increment() => count.value++;
}