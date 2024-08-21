import 'package:get/get.dart';

class ActivityScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ActivityScreenBinding>(
          () => ActivityScreenBinding(),
    );
  }
}
