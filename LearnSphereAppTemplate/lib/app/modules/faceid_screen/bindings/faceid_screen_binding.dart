import 'package:get/get.dart';

import '../controllers/faceid_screen_controller.dart';

class FaceidScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FaceidScreenController>(
      () => FaceidScreenController(),
    );
  }
}
