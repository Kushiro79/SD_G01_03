import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_field/intl_phone_number_field.dart';
import 'package:sociogram/app/modules/verification_screen/views/verification_screen_view.dart';

import '../../../../config/app_contents.dart';
import '../../../../config/common_button.dart';
import '../controllers/pnumber_screen_controller.dart';

class PnumberScreenView extends GetView<PnumberScreenController> {
  const PnumberScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Form(
            child: SafeArea(
              child: Padding(padding: const EdgeInsets.only(left: 8, right: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                          child: Image.asset(Appcontent.back, height: 24,)),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 10,top: 40),
                      child: Text('What is Your\nPhone Number ?', style: TextStyle(fontSize: 32, fontFamily: 'Urbanist-bold'), textAlign: TextAlign.start, overflow: TextOverflow.ellipsis),
                    ),

                    Padding(padding: const EdgeInsets.only(left: 10, top: 25),
                      child: Text('This information helps us verify your account to\nmake it more secure.', style: TextStyle(fontSize: 14, fontFamily: 'Urbanist-medium', color: Colors.grey.shade500), overflow: TextOverflow.ellipsis),
                    ),

                    const SizedBox(height: 40),
                    Padding(padding: const EdgeInsets.only(left: 8, right: 8),
                        child: InternationalPhoneNumberInput(
                          betweenPadding: 15,
                          dialogConfig: DialogConfig(backgroundColor: Colors.white, textStyle: const TextStyle(color: Colors.black), selectedItemColor: Colors.grey, searchBoxBackgroundColor: Colors.grey),
                          countryConfig: CountryConfig(
                            flagSize: 24,
                              textStyle: const TextStyle(fontSize: 16, fontFamily: 'Urbanist-bold', color: Colors.black),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(width: 1.5, color: Colors.teal.shade300),
                              )
                          ),
                          validator: (number) {
                            if(number.number.isEmpty){
                              return "The phone number cannot be left empty";
                            }
                            return null;
                          },
                          phoneConfig: PhoneConfig(
                            hintStyle: const TextStyle(color: Colors.black, fontFamily: 'Urbanist-regular'),
                            radius: 100,
                            borderWidth: 1.5,
                            enabledColor:Colors.teal.shade300,
                            focusedColor: Colors.teal.shade300,
                            backgroundColor: Colors.white,
                          ),
                        )
                    ),

                    Padding(padding: const EdgeInsets.only(bottom: 16, top: 30),
                      child: Center(
                        child: elevated(text: 'Continue',onPress: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const VerificationScreenView()),);
                        },),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
