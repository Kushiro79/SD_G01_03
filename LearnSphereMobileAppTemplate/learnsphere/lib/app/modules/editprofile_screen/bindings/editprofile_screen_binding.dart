import 'package:get/get.dart';

import '../controllers/editprofile_screen_controller.dart';

class EditprofileScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditprofileScreenController>(
      () => EditprofileScreenController(),
    );
  }
}
