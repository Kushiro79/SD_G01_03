import 'package:get/get.dart';

import '../controllers/proflie_screen_controller.dart';

class ProflieScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProflieScreenController>(
      () => ProflieScreenController(),
    );
  }
}
