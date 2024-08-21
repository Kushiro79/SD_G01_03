import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociogram/app/modules/createpin_screen/views/createpin_screen_view.dart';
import 'package:sociogram/config/common_button.dart';

import '../../../../config/app_color.dart';
import '../../../../config/app_contents.dart';
import '../controllers/faceid_screen_controller.dart';

class FaceidScreenView extends GetView<FaceidScreenController> {
  const FaceidScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                ListTile(
                  leading: GestureDetector(
                    onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back)),
                ),
                const SizedBox(
                  height: 120,
                  width: 120,
                  child: Image(image: AssetImage(Appcontent.faceid)),
                ),

                const Padding(padding: EdgeInsets.only(top: 40, bottom: 20),
                  child: Text('Enable Face ID ?', style: TextStyle(fontSize: 32, fontFamily: 'Urbanist-bold'), overflow: TextOverflow.ellipsis,),
                ),
                const Text('You can use face id to verify 2 step\n        access login your account.', style: TextStyle(fontSize: 14, color: Colors.grey, fontFamily: 'Urbanist-medium'), overflow: TextOverflow.ellipsis,),

                const Expanded(child: SizedBox(height: 320)),
                elevated(text: 'Enable Face ID', onPress: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const CreatepinScreenView()),);
                },),

                Padding(padding: const EdgeInsets.only(top: 20),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(fixedSize: const Size(327, 56), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
                    onPressed: () {},
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("No, Thanks", style: TextStyle(fontSize: 16, fontFamily: 'Urbanist', color: AppColor.purple)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
              ],
            ),
          ),
        );
      },
    );
  }
}
