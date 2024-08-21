import 'package:get/get.dart';

class RegisterController extends GetxController {
  final count = 0.obs;

  bool showPassword = true;

  void increment() => count.value++;

  changePasswordhideAndShow(){
    showPassword = !showPassword;
    update();
  }

}
