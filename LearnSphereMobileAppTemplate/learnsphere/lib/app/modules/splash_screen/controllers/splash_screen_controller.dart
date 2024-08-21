import 'package:get/get.dart';

import '../../Onboarding1/views/onboarding1_view.dart';

class SplashScreenController extends GetxController {
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 5),
      () {
        Get.to(Onboarding1View());
      },
    );
  }

  void increment() => count.value++;
}
