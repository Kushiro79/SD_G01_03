import 'package:get/get.dart';

import '../controllers/serach_screen_controller.dart';

class SerachScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SerachScreenController>(
      () => SerachScreenController(),
    );
  }
}
