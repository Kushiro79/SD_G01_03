import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/app_color.dart';
import '../controllers/verification_screen_controller.dart';

@RoutePage()
class VerificationScreenView extends GetView<VerificationScreenController> {
  const VerificationScreenView({super.key});
  VerificationScreenController get controller => Get.put(VerificationScreenController());

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 70),
                  const Center(
                    child: SizedBox(
                      height: 200,
                      width: 500,
                      child: Image(image: AssetImage('assets/verify4.png')), // Updated image path
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 40, bottom: 20),
                    child: Center(
                      child: Text(
                        'Email Verification',
                        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, fontFamily: 'Urbanist'),
                      ),
                    ),
                  ),
                  const Center(
                    child: Text(
                      'Please verify your account through the link we have\n sent to your email.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Color(0xff64748B), fontFamily: 'Urbanist'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 60),
                    child: Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                          backgroundColor: AppColor.purple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        child: const Text(
                          'Verify',
                          style: TextStyle(fontSize: 16, fontFamily: 'Urbanist', color: Colors.white),
                        ),
                        onPressed: () {
                          controller.checkEmailVerified(context);
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 125),
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center, // Add this to center the text
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Didn't receive the code? Check your spam folder.\n",
                            style: TextStyle(fontSize: 14, color: Colors.grey[600], fontFamily: 'Urbanist'),
                          ),
                          const TextSpan(
                            text: 'Use another email address?',
                            style: TextStyle(fontSize: 14, color: AppColor.purple, fontFamily: 'Urbanist'),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
