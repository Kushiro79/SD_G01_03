import 'package:get/get.dart';

class LiveScreenBinding extends Bindings{
  @override
  void dependencies() {
     Get.lazyPut<LiveScreenBinding>(
        () => LiveScreenBinding(),
    );
  }
}