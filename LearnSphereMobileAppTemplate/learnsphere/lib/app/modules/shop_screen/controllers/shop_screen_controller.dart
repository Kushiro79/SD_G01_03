import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShopScreenController extends GetxController {
  TextEditingController textEditingController = TextEditingController();

  var selectindex = [];
  int selectitem = 0;

  RxInt selected = 0.obs;
  RxInt selected1 = 0.obs;
  int currentindex = 0;
  final count = 0.obs;

  void increment() => count.value++;

  changevalue({int ? value}){
    if(selectindex.contains(value)){
      selectindex.remove(value);
    } else {
      selectindex.add(value);
    }
    update();
  }

  changecatwise({int ? index}) {
    currentindex = index ?? 0;
    update();
  }
}
