import 'package:get/get.dart';

class SerachScreenController extends GetxController {
  var selectIndex = [];
  int seltectitem = 0;
  final count = 0.obs;

  RxInt selected = 0.obs;
  int currentIndex = 0;

  void increment() => count.value++;

  changeValue({int ? value}) {
    if(selectIndex.contains(value)){
      selectIndex.remove(value);
    } else {
      selectIndex.add(value);
    }
    update();
  }

  changeCatWiseIndex({int ? index}) {
    currentIndex = index ?? 0;
    update();
  }
}
