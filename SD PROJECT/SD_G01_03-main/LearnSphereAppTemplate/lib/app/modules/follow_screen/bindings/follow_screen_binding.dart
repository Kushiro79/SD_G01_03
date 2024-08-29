import 'package:get/get.dart';

import '../controllers/follow_screen_controller.dart';

class FollowScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FollowScreenController>(
      () => FollowScreenController(),
    );
  }
}
