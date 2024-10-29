import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_router.dart';
import '../../../config/app_contents.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../utils/custom_toast.dart';
import '../controllers/forgot_screen_controller.dart';
import "package:google_fonts/google_fonts.dart";

@RoutePage()
class ForgotScreenView extends GetView<ForgotScreenController> {
  ForgotScreenView({super.key});

  final TextEditingController _email = TextEditingController();

  forgotpasswordEmail(String value) {
    _email.text = value;
  }

  Future<void> passwordReset(BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _email.text.trim());
      _showSuccessDialog(context);
    } on FirebaseAuthException catch (e) {
      if (_email.text.isEmpty) {
        showCustomToast(context, 'Please enter an email');
      } else {
        showCustomToast(context, e.message.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF117aca),
                  Color(0xFF000000),
                  
                ],
                stops: [0.2, 0.9],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Content
          ListView(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 8,
            ),
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
              ),
              _body(context),
            ],
          ),
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
            const SizedBox(height: 6),
            isActive
                ? Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  )
                : const SizedBox(),
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
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/forgot_ui.png',
                      width: MediaQuery.of(context).size.width * 0.3,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width *
                      0.05, // Set your desired right padding
                  top: MediaQuery.of(context).size.height /
                      6, // Keep the vertical padding
                  bottom: MediaQuery.of(context).size.height /
                      6, // Keep the vertical padding
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
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
                'assets/forgot_ui.png',
                width: constraints.maxWidth *
                    0.7, // Reduce image width to 70% of available width
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height / 10),
                child: SizedBox(
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
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: Text(
            'Forgot Password?',
            style: GoogleFonts.montserrat(
                fontSize: 35,
                color: Colors.white,
                shadows: [
                  Shadow(
                    offset: const Offset(2.0, 2.0), // position of the shadow
                    blurRadius: 4.0, // how "soft" the shadow is
                    color: Colors.black
                        .withOpacity(0.5), // shadow color and opacity
                  )
                ]),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
          child: Text(
            'Enter your email account to reset your password.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 40)),
        TextField(
          controller: _email,
          decoration: InputDecoration(
            hintText: 'Enter email ',
            filled: true,
            fillColor: Colors.blueGrey[50],
            labelStyle: const TextStyle(fontSize: 12),
            contentPadding: const EdgeInsets.only(left: 30),
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
        const SizedBox(height: 30),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.deepPurple[100]!,
                spreadRadius: 5,
                blurRadius: 10,
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: () {
              passwordReset(context);
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const SizedBox(
              width: double.infinity,
              height: 50,
              child: Center(child: Text('Reset Password', style: TextStyle(color: Color(0xFF23235E)))),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Already remember?',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 5),
            GestureDetector(
              onTap: () {
                context.router.push(LoginRouteView());
              },
              child: const Text(
                'Sign In',
                style: TextStyle(
                  color: Color(0xFF117aca),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showSuccessDialog(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          content: SizedBox(
            height:
                screenheight > 555 ? screenheight * 0.2 : screenheight * 0.3,
            width: screenwidth > 555 ? screenwidth * 0.2 : screenwidth * 0.8,
            child: Padding(
              padding: MediaQuery.of(context).padding +
                  const EdgeInsets.only(top: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 120,
                    width: 120,
                    child: Image.asset(Appcontent.password),
                  ),
                  const Text(
                    'Recovery password Successfully',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Urbanist-semibold',
                    ),
                  ),
                  const Text(
                    'Please login again to get started.',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontFamily: 'Urbanist-regular',
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8, bottom: 16, top: 30),
                    child: ElevatedButton(
                      onPressed: () {
                        context.router.push(LoginRouteView());
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text('Sign In'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
