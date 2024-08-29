import 'package:get/get.dart';

class ProflieScreenController extends GetxController {
  //TODO: Implement ProflieScreenController

  int currentindex = 0;
  RxInt selected = 0.obs;
  final count = 0.obs;

  void increment() => count.value++;

  changecatwise({int? index}) {
    currentindex = index ?? 0;
    update();
  }
}
