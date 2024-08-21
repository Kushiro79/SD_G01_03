import 'package:get/get.dart';

class PronounsScreenController extends GetxController {
  //TODO: Implement PronounsScreenController

  final count = 0.obs;
  int gValue = 0;

  void increment() => count.value++;

  changeValue({int?value}){
    gValue  = value??0;
    update();
  }
}
