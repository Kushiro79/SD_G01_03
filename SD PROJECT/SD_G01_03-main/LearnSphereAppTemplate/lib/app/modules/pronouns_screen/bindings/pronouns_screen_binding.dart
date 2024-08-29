import 'package:get/get.dart';

import '../controllers/pronouns_screen_controller.dart';

class PronounsScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PronounsScreenController>(
      () => PronounsScreenController(),
    );
  }
}
