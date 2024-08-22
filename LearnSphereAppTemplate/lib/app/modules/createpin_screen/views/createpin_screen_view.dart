import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:sociogram/app/modules/interest_screen/views/interest_screen_view.dart';

import '../../../../config/common_button.dart';
import '../controllers/createpin_screen_controller.dart';

class CreatepinScreenView extends GetView<CreatepinScreenController> {
  const CreatepinScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ListTile(
              leading: GestureDetector(
                onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back)),
            ),

            const Padding(padding: EdgeInsets.only(top: 40, bottom: 20),
              child: Text('Enter Your Pin', style: TextStyle(fontSize: 32, fontFamily: 'Urbanist-bold')),
            ),
            const Text('Please enter your pin code to\n         verify access login.', style: TextStyle(fontSize: 14, fontFamily: 'Urbanist-medium', color: Color(0xff64748B))),

            Padding(padding: const EdgeInsets.only(top: 40),
              child: OTPTextField(
                length: 4,
                width: MediaQuery.of(context).size.width,
                fieldWidth: 50,
                fieldStyle: FieldStyle.box,
                textFieldAlignment: MainAxisAlignment.spaceEvenly,
              ),
            ),

            Padding(padding: const EdgeInsets.only(left: 8,bottom: 16, top: 30),
              child: elevated(text: 'Verify',onPress: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) => InterestScreenView()),);
              },),
            ),
          ],
        ),
      ),
    );
  }
}
