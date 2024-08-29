import 'package:get/get.dart';

import '../controllers/birthday_screen_controller.dart';

class BirthdayScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BirthdayScreenController>(
      () => BirthdayScreenController(),
    );
  }
}
