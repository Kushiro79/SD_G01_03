import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:sociogram/app/modules/interest_screen/views/interest_screen_view.dart';
import 'package:sociogram/config/app_contents.dart';
import '../../../../config/app_color.dart';
import '../../../../config/common_button.dart';
import '../controllers/verification_screen_controller.dart';

class VerificationScreenView extends GetView<VerificationScreenController> {
  const VerificationScreenView({Key? key}) : super(key: key);

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
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Image.asset(Appcontent.back, height: 24),
                  ),
                ),
                const Expanded(
                  child: Center(
                    child: SizedBox(
                      height: 120,
                      width: 120,
                      child: Image(image: AssetImage(Appcontent.verification)),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 40, bottom: 20),
                  child: Center(
                    child: Text(
                      'OTP Verification',
                      style: TextStyle(fontSize: 32, fontFamily: 'Urbanist-bold'),
                    ),
                  ),
                ),
                const Center(
                  child: Text(
                    'Enter the verification code we just\n     sent on your email address.',
                    style: TextStyle(fontSize: 14, fontFamily: 'Urbanist-medium', color: Color(0xff64748B)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: OTPTextField(
                    style: const TextStyle(fontFamily: 'Urbanist-bold', color: AppColor.purple),
                    length: 4,
                    width: MediaQuery.of(context).size.width,
                    fieldWidth: 50,
                    fieldStyle: FieldStyle.box,
                    textFieldAlignment: MainAxisAlignment.spaceEvenly,
                    onCompleted: (pin) {
                      // Handle OTP verification here
                      controller.checkEmailVerified();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: ListTile(
                    leading: Text(
                      'Resend code in',
                      style: TextStyle(fontSize: 12, color: Colors.grey[500], fontFamily: 'Urbanist-semibold'),
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: const Text(
                      '2:13',
                      style: TextStyle(fontSize: 12, color: AppColor.purple, fontFamily: 'Urbanist-semibold'),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16, top: 15),
                  child: Center(
                    child: elevated(
                      text: 'Verify',
                      onPress: () {
                        controller.checkEmailVerified();
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 160),
                Center(
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "Didn't receive the code? Check your email spam.\n",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        TextSpan(
                          text: "                 Use another email address?",
                          style: TextStyle(fontSize: 14, color: AppColor.purple),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
