import 'package:get/get.dart';

class PostdetailScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostdetailScreenBinding>(
          () => PostdetailScreenBinding(),
    );
  }
}
