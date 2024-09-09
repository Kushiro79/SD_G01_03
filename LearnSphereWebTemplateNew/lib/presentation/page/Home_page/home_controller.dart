import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  // final controller = PageController(viewportFraction: 0.8, keepPage: true);
  var selectIndex = [];
  var selectIndex1 = [];
  int seltectitem = 0;
  final count = 0.obs;

  void increment() => count.value++;

  changeValue({int ? value}) {
    if(selectIndex.contains(value)) {
      selectIndex.remove(value);
    }
    else {
      selectIndex.add(value);
    }
    update();
  }

  changeValue1({int ? value}) {
    if(selectIndex1.contains(value)) {
      selectIndex1.remove(value);
    }
    else {
      selectIndex1.add(value);
    }
    update();
  }
}
