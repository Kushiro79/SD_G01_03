import 'package:get/get.dart';

import '../controllers/onboarding1_controller.dart';

class Onboarding1Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Onboarding1Controller>(
      () => Onboarding1Controller(),
    );
  }
}
