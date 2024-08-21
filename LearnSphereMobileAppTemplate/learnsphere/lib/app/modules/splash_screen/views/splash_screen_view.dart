import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociogram/config/app_contents.dart';

import '../controllers/splash_screen_controller.dart';

// ignore: must_be_immutable
class SplashScreenView extends GetView<SplashScreenController> {
  SplashScreenView({Key? key}) : super(key: key);

    @override
  SplashScreenController controller = Get.put(SplashScreenController());
   @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashScreenController>(builder: (controller) => const Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 60.57,
                width: 50,
                child: Image(image: AssetImage(Appcontent.hubline))),
            SizedBox(width: 10,),
            Text('Sociogram', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, fontFamily: 'Urbanist')),
          ],
        ),
      ),
    ));
  }
}
