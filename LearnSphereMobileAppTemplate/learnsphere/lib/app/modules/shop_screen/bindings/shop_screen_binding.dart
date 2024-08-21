import 'package:get/get.dart';

import '../controllers/shop_screen_controller.dart';

class ShopScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShopScreenController>(
      () => ShopScreenController(),
    );
  }
}
