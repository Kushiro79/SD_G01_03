import 'package:get/get.dart';

import '../controllers/filter_screen_controller.dart';

class FilterScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FilterScreenController>(
      () => FilterScreenController(),
    );
  }
}
