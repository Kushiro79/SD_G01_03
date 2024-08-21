import 'package:get/get.dart';

class EditpictreScreenController extends GetxController {
  //TODO: Implement EditprofileScreenController
  var selectIndex = [];
  int seltectitem = 0;

  RxInt selected = 0.obs;
  RxInt select = 0.obs;
  final count = 0.obs;

  void increment() => count.value++;

  changeValue({int? value}) {
    if (selectIndex.contains(value)) {
      selectIndex.remove(value);
    } else {
      selectIndex.add(value);
    }
    update();
  }
}
