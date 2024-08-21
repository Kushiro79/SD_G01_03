
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociogram/app/modules/addpost_screen/controllers/addpost_screen_controller.dart';
import 'package:sociogram/app/modules/editpictre_screen/controllers/editpictre_screen_controller.dart';
import 'package:sociogram/app/modules/postdetail_screen/postdetail_screen_view.dart';
import 'package:sociogram/config/app_color.dart';

List<String> list = <String>['All Images', 'Videos', 'Snapchat', 'Facebook'];
// ignore: must_be_immutable
class AddpostScreenView extends GetView<EditpictreScreenController> {
  AddpostScreenView({Key? key}) : super(key: key);
  AddpostScreenController addpostScreenController = Get.put(AddpostScreenController());


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: InkWell(onTap: () => Navigator.pop(context),child: const Icon(Icons.close, color: Colors.black,)),
          centerTitle: true,
          title: GetBuilder<AddpostScreenController>(
            builder: (context) {
              return GestureDetector(
                  onTap: () {},
                  child: addpostScreenController.selected.value == 0 ? const Text('New Post', style: TextStyle(fontSize: 18, color: Color(0xff0F172A), fontFamily: 'Urbanist-semibold')) : addpostScreenController.selected.value == 1 ? const Text('New Story', style: TextStyle(fontSize: 18, color: Color(0xff0F172A), fontFamily: 'Urbanist-semibold')) : addpostScreenController.selected.value == 2 ? const Text('New Reels', style: TextStyle(fontSize: 18, color: Color(0xff0F172A), fontFamily: 'Urbanist-semibold')) : const Text('New Live', style: TextStyle(fontSize: 18, color: Color(0xff0F172A), fontFamily: 'Urbanist-semibold')));
            },
          ),
          actions: [
            GetBuilder<AddpostScreenController>(
              builder: (context) {
                return GestureDetector(
                    onTap: () {},
                    child: addpostScreenController.selected.value == 0 ? SizedBox(
                            height: 24,
                            width: 24,
                            child: InkWell(onTap: () {
                              Navigator.push(Get.context!, MaterialPageRoute(builder: (context) => const PostdetailScreenView()));
                            },child: Image.asset('assets/arrow-right.png', color: AppColor.purple,)),) : const Icon(Icons.settings, color: Colors.black,));
              },
            ),
            const SizedBox(width: 15,),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 10, top: 10),
          child: BottomAppBar(
            elevation: 0,
            child: GetBuilder<AddpostScreenController>(
              builder: (controller) => SizedBox(
                height: 44,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        addpostScreenController.selected.value = index;
                        addpostScreenController.changecatwise(index: index);
                      },
                      child: Obx(
                        () => Container(
                          height: 44,
                          width: 123,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: addpostScreenController.selected.value == index ? Colors.teal : Colors.white,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: addpostScreenController.selectindex.contains(index) ? Colors.white : const Color(0xffE2E8F0)),
                          ),
                          child: Center(
                            child: Text("",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: addpostScreenController.selected.value == index ? Colors.white : const Color(0xff3BBAA6), fontFamily: 'Urbanist-bold')),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
    );
  }
}
