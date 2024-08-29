import 'package:get/get.dart';

class AddpostScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddpostScreenBinding>(
      () => AddpostScreenBinding(),
    );
  }
}
