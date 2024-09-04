import 'package:get/get.dart';

class ActivityScreenController extends GetxController{
  List<String> list = <String>['1 Weeks', '2 Weeks', '3 Weeks', '4 Weeks'];

  int gValue = 0;
  final count = 0.obs;
  final selected  = "".obs;

  // RxString dropdownValue = list.first.obs;



  void increment() => count.value++;

  void setSelected(String value){
    selected.value = value;
  }

  changeValue({int? value}) {
    gValue = value ?? 0;
    update();
  }
}