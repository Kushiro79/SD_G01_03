import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sociogram/app/modules/addpost_screen/views/addpost_screen_view.dart';

class AddpostScreenController extends GetxController {
  static AddpostScreenController get to => Get.find<AddpostScreenController>();
  var selectindex = [];
  int selectitem = 0;

  final count = 0.obs;
  int gValue = 0;
  int value = 0;
  RxInt selected = 0.obs;
  int currentindex = 0;


  RxString dropdownValue = list.first.obs;

  XFile? image;
  RxString imagePath = ''.obs;
  final picker = ImagePicker();

  void increment() => count.value++;

  changevalue({int? value}) {
    if (selectindex.contains(value)) {
      selectindex.remove(value);
    } else {
      selectindex.add(value);
    }
    update();
  }

  changecatwise({int? index}) {
    currentindex = index ?? 0;
    update();
  }

  Future<void> getImage() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      image = XFile(pickedFile.path);
      imagePath.value = pickedFile.path.toString();
      update();
    } else {
    }
  }
}
