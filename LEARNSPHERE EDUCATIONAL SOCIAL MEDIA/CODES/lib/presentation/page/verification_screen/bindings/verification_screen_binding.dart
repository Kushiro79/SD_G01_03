import 'package:get/get.dart';

import '../controllers/verification_screen_controller.dart';

class VerificationScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerificationScreenController>(
      () => VerificationScreenController(),
    );
  }
}
