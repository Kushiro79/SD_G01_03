import 'package:get/get.dart';

import '../controllers/interest_screen_controller.dart';

class InterestScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InterestScreenController>(
      () => InterestScreenController(),
    );
  }
}
