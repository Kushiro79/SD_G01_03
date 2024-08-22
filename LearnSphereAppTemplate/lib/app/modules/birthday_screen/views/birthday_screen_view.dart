import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociogram/app/modules/pronouns_screen/views/pronouns_screen_view.dart';

import '../../../../config/app_color.dart';
import '../../../../config/common_button.dart';
import '../../../../config/common_textfield.dart';
import '../controllers/birthday_screen_controller.dart';

class BirthdayScreenView extends GetView<BirthdayScreenController> {
  const BirthdayScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back_rounded, color: Colors.black,)),
                  trailing: Container(
                    height: 32,
                    width: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      // color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                        child: TextButton(
                            onPressed: () {},
                            child: const Text('Skip', style: TextStyle(fontSize: 12, color: AppColor.purple)))),
                  ),
                ),

                const Padding(padding: EdgeInsets.only(left: 15, top: 30),
                  child: Text('When Is Your\nBirthday ?', style: TextStyle(fontFamily: 'Urbanist-bold', fontSize: 32), overflow: TextOverflow.ellipsis),
                ),

                Padding(padding: const EdgeInsets.only(left: 15, top: 20),
                  child: Text('This information helps we provide be better\ncontent for you.', style: TextStyle(fontSize: 14, color: Colors.grey[500], fontFamily: 'Urbanist-medium'),  overflow: TextOverflow.ellipsis),
                ),

                Padding(padding: const EdgeInsets.only(top: 50, left: 27, right: 27, bottom: 10),
                  child: textfield(text: 'Enter birth date', text1: 'DD/Days'),
                ),
                Padding(padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 27),
                  child: textfield(text: 'Enter your month', text1: 'MM/Months'),
                ),

                Padding(padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 27),
                  child: textfield(text: 'Enter your year', text1: 'YY/Years'),
                ),

                const Expanded(child: SizedBox(height: 180)),
                Center(
                  child: elevated(
                    text: 'Next',
                    onPress: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PronounsScreenView()));
                    },),
                ),
                const SizedBox(height: 20,),
              ],
            ),
          ),
        );
      },

    );
  }
}
