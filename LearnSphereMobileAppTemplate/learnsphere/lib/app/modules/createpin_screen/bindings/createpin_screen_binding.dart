import 'package:get/get.dart';

import '../controllers/createpin_screen_controller.dart';

class CreatepinScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreatepinScreenController>(
      () => CreatepinScreenController(),
    );
  }
}
