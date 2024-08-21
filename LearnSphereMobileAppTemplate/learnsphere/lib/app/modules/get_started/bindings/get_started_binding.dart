import 'package:get/get.dart';

import '../controllers/get_started_controller.dart';

class GetStartedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetStartedController>(
      () => GetStartedController(),
    );
  }
}
