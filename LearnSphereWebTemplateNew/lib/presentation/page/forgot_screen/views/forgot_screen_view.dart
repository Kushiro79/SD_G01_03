import 'package:auto_route/auto_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_router.dart';
import '../../login_screen/views/login_screen_view.dart';
import '../../../config/app_contents.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../config/app_color.dart';
import '../../../config/common_button.dart';
import '../../../config/common_textfield.dart';
import '../controllers/forgot_screen_controller.dart';

@RoutePage()
class ForgotScreenView extends GetView<ForgotScreenController> {
  ForgotScreenView({super.key});
  final _email = TextEditingController();

  Future passwordReset(BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _email.text.trim());
      showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        context: context,
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width * 0.8,
             child: Padding(
              padding: MediaQuery.of(context).padding + const EdgeInsets.only(top: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 120,
                  width: 120,
                  child: Image.asset(Appcontent.password),
                ),
                Text(
                  'Recovery password Successfully',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'Urbanist-semibold',
                  ),
                ),
                Text(
                  'Please login again to get started.',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontFamily: 'Urbanist-regular',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, bottom: 16, top: 30),
                  child: ElevatedButton(
                    onPressed: () {
                      context.router.push(LoginRouteView());
                    },
                    child: Text('Sign In'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          );
        },
      );
    } on FirebaseAuthException catch (e) {

            showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(e.message.toString()),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      body: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 8),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
          ),
          _body(context),
        ],
      ),
    );
  }

  Widget _menuItem({String title = 'Title Menu', bool isActive = false}) {
    return Padding(
      padding: const EdgeInsets.only(right: 75),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isActive ? Colors.deepPurple : Colors.grey,
              ),
            ),
            SizedBox(height: 6),
            isActive
                ? Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }

Widget _body(BuildContext context) {
  return LayoutBuilder(
    builder: (context, constraints) {
      if (constraints.maxWidth > 800) {
        // Wide layout
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'forgot_ui.png',
                    width: MediaQuery.of(context).size.width * 0.3,
                  ),
                ],
              ),
            ),
                          Padding(
                padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.1, // Set your desired right padding
                  top: MediaQuery.of(context).size.height / 6, // Keep the vertical padding
                  bottom: MediaQuery.of(context).size.height /6, // Keep the vertical padding
                ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.2,
                height: MediaQuery.of(context).size.height * 0.5,
                child: _formForgot(context),
              ),
            ),
          ],
        );
      } else {
        // Narrow layout (e.g., mobile devices)
        return Column(
          children: [
            Image.asset(
              'forgot_ui.png',
              width: constraints.maxWidth * 0.7, // Reduce image width to 70% of available width
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height / 10),
              child: Container(
                width: constraints.maxWidth * 0.9, // Adjust form width
                child: _formForgot(context),
              ),
            ),
          ],
        );
      }
    },
  );
}


  Widget _formForgot(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
           child: Text(
                'Forgot Password?',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
         Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              child: Text(
                'Enter your email account to reset your password.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
         ),
        Padding(padding: EdgeInsets.symmetric(vertical: 40)),

        TextField(
          controller: _email,
          decoration: InputDecoration(
            hintText: 'Enter email ',
            filled: true,
            fillColor: Colors.blueGrey[50],
            labelStyle: TextStyle(fontSize: 12),
            contentPadding: EdgeInsets.only(left: 30),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey[50]!),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey[50]!),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        SizedBox(height: 30),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.deepPurple[100]!,
                spreadRadius: 10,
                blurRadius: 20,
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: () {
              passwordReset(context);
            },
            child: Container(
                width: double.infinity,
                height: 50,
                child: Center(child: Text('Reset Password'))),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Already remember?',
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 5),
            GestureDetector(
              onTap: () {
                context.router.push(LoginRouteView());
              },
              child: Text(
                'Sign In',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}