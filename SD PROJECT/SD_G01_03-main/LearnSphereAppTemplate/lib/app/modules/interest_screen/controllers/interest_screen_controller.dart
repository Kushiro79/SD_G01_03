import 'package:get/get.dart';

class InterestScreenController extends GetxController {
  //TODO: Implement InterestScreenController
  final count = 0.obs;
  var selectIndex = [];
  int seltectitem = 0;

  void increment() => count.value++;

  changeValue({int?value}){
    if(selectIndex.contains(value)){
      selectIndex.remove(value);
    }else{
      selectIndex.add(value);
    }
    update();
  }
}
