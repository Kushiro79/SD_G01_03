import 'package:get/get.dart';

import '../controllers/forgot_screen_controller.dart';

class ForgotScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotScreenController>(
      () => ForgotScreenController(),
    );
  }
}
