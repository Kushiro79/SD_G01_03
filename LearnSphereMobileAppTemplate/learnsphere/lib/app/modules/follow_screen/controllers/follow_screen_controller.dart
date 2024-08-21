import 'package:get/get.dart';

class FollowScreenController extends GetxController {
  //TODO: Implement FollowScreenController

  var selectindex = [];
  int selectitem = 0;
  final count = 0.obs;

  int gValue = 0;

  RxInt selected = 0.obs;
  int currentindex = 0;

  void increment() => count.value++;

  changevalue({int? value}) {
    if (selectindex.contains(value)) {
      selectindex.remove(value);
    } else {
      selectindex.add(value);
    }
    update();
  }

  changecatwise({int? index}) {
    currentindex = index ?? 0;
    update();
  }

  changeValue({int? value}) {
    gValue = value ?? 0;
    update();
  }
}
