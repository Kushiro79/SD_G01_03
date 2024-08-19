import 'package:get/get.dart';

import '../controllers/pnumber_screen_controller.dart';

class PnumberScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PnumberScreenController>(
      () => PnumberScreenController(),
    );
  }
}
