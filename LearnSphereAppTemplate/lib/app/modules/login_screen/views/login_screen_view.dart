import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sociogram/app/modules/forgot_screen/views/forgot_screen_view.dart';
import 'package:sociogram/app/modules/home/views/home_view.dart';
import 'package:sociogram/app/modules/register/views/register_view.dart';
import 'package:sociogram/config/app_color.dart';
import 'package:sociogram/config/app_contents.dart';


import '../../../../config/common_button.dart';
import '../controllers/login_screen_controller.dart';

// ignore: must_be_immutable
class LoginScreenView extends GetView<LoginScreenController> {
  LoginScreenView({Key? key}) : super(key: key);
    LoginScreenController loginScreenController = Get.put(LoginScreenController());

  final RxString _emailErrorText = ''.obs;
  final RxString _passwordErrorText = ''.obs;

  String get emailErrorText => _emailErrorText.value;
  String get passwordErrorText => _passwordErrorText.value;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
  }

  void updateEmailErrorText(String errorMessage) {
    _emailErrorText.value = errorMessage;
  }

  void updatePasswordErrorText(String errorMessage) {
    _passwordErrorText.value = errorMessage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10, top: 20),
                    child: Text('Welcome Back!',
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Urbanist-bold'),
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text('Please sign in with your account.',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontFamily: 'Urbanist-medium'),
                        overflow: TextOverflow.ellipsis),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 24, horizontal: 10),
                      child: GetBuilder<LoginScreenController>(
                        builder: (controller) {
                          return TextField(
                            onChanged: (value) {
                              _emailController.text = value;
                              loginScreenController.updateEmail(value);
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter your username',
                              labelText: 'Username or Email',
                              errorText:
                                  loginScreenController.isValidEmail.value
                                      ? null
                                      : _emailErrorText.value,
                              border: const OutlineInputBorder(),
                            ),
                          );
                        },
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child:
                        GetBuilder<LoginScreenController>(builder: (context) {
                      return TextField(
                        onChanged: (value) {
                          _passwordController.text = value;
                          loginScreenController.updatePassword(value);
                        },
                        obscureText: loginScreenController.showPassword,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            hintText: 'Min. 8 characters...',
                            labelText: 'Password',
                            errorText:
                                loginScreenController.isValidPassword.value
                                    ? null
                                    : _passwordErrorText.value,
                            suffixIcon: InkWell(
                              onTap: () {
                                loginScreenController
                                    .changePasswordhideAndShow();
                              },
                              child: SizedBox(
                                height: 20,
                                width: 20,
                                child: Center(
                                  child: loginScreenController.showPassword
                                      ? Image.asset(
                                          'assets/eye-slash.png',
                                          height: 24,
                                          width: 24,
                                        )
                                      : const Icon(
                                          Icons.visibility_outlined,
                                          color: Color(0xff94A3B8),
                                        ),
                                ),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(35),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade200),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(35),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade200),
                            )),
                      );
                    }),
                  ),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.to(const ForgotScreenView());
                      },
                      child: const Text('Forgot Password?',
                          style: TextStyle(
                              fontSize: 14,
                              color: AppColor.purple,
                              fontFamily: 'Urbanist-semibold'),
                          overflow: TextOverflow.ellipsis),
                    ),
                    TextButton(
                      onPressed: () {
                        // Register button press handler
                        Get.to(RegisterView());
                      },
                      child: const Text('Register',
                          style: TextStyle(
                              fontSize: 14,
                              color: AppColor.purple,
                              fontFamily: 'Urbanist-semibold'),
                              overflow:TextOverflow.ellipsis ,
                              ),
                    ),
                  ],
                ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16, top: 16),
                    child: Center(
                      child: elevated(
                        text: 'Sign In',
                        onPress: () async {
                          if (loginScreenController.validateCredentials()) {
                            print(
                                'Email: ${_emailController.text}'); // Add this
                            print(
                                'Password: ${_passwordController.text}'); // Add this

                            try {
                              await _firebaseAuth.signInWithEmailAndPassword(
                                email: _emailController.text,
                                password: _passwordController.text,
                              );
                              print('Signed in successfully');
                              Get.to(HomeView());
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                updateEmailErrorText(
                                    'No user found for that email.');
                              } else if (e.code == 'wrong-password') {
                                updatePasswordErrorText(
                                    'Wrong password provided for that user.');
                              } else {
                                updateEmailErrorText(
                                    'An unknown error occurred.');
                              }
                            }
                          }
                        },
                      ),
                    ),
                  ),
                  const Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Divider(
                          thickness: 1,
                          color: Color(0xffE2E8F0),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Center(
                            child: Text('Or',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Urbanist',
                                    color: Colors.grey))),
                      ),
                      Expanded(
                        flex: 4,
                        child: Divider(thickness: 1, color: Color(0xffE2E8F0)),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 16),
                    child: Center(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            fixedSize: const Size(327, 56),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100))),
                        onPressed: () {},
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 24,
                              width: 24,
                              child:
                                  Image(image: AssetImage(Appcontent.google)),
                            ),
                            SizedBox(width: 10),
                            Text('Sign In With Google',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontFamily: 'Urbanist-semibold'),
                                overflow: TextOverflow.ellipsis),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 16),
                    child: Center(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            fixedSize: const Size(327, 56),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100))),
                        onPressed: () {},
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 24,
                              width: 24,
                              child: Image(image: AssetImage(Appcontent.apple)),
                            ),
                            SizedBox(width: 10),
                            Text('Sign In With Apple',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontFamily: 'Urbanist-semibold'),
                                overflow: TextOverflow.ellipsis),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Expanded(
                      child: SizedBox(
                    height: 20,
                  )),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
