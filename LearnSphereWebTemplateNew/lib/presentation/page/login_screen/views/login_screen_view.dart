import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/app_color.dart';
import '../../../routes/app_router.dart';
import '../controllers/login_screen_controller.dart';

@RoutePage()
class LoginScreenView extends GetView<LoginScreenController> {
  LoginScreenView({super.key});
  final LoginScreenController loginScreenController =
      Get.put(LoginScreenController());

  void dispose() {
    loginScreenController.dispose();
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    _menuItem(title: 'Sign In', isActive: true),
                    _registerButton(context),
                  ],
                ),
              ],
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

  Widget _registerButton(BuildContext context) {
    return GestureDetector(
        onTap: () {
          context.router.push(RegisterRouteView());
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[200]!,
                spreadRadius: 10,
                blurRadius: 12,
              ),
            ],
          ),
          child: Text(
            'Register',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
        ));
  }

  Widget _body(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Check the available width and adjust the layout accordingly
        if (constraints.maxWidth > 800) {
          // Wide layout
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.45,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: AlignmentDirectional.center,
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Text(
                        'Welcome to LearnSphere, Buddy!',
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Image.asset(
                      'assets/login_ui2.png',
                      width: MediaQuery.of(context).size.width * 0.3,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width *
                      0.1, // Set your desired right padding
                  top: MediaQuery.of(context).size.height /
                      6, // Keep the vertical padding
                  bottom: MediaQuery.of(context).size.height /
                      6, // Keep the vertical padding
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: _formLogin(context),
                ),
              ),
            ],
          );
        } else {
          // Narrow layout (e.g., mobile devices)
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  'Welcome to LearnSphere, Buddy!',
                  style: TextStyle(
                    fontSize: 30, // Reduce font size for narrow layout
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center, // Center the text
                ),
              ),
              Image.asset(
                'assets/login_ui2.png',
                width: constraints.maxWidth *
                    0.7, // Reduce image width to 70% of available width
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height / 10),
                child: Container(
                  width: constraints.maxWidth * 0.9, // Adjust form width
                  child: _formLogin(context),
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Widget _formLogin(BuildContext context) {
    return Column(
      children: [
        TextField(
          onChanged: (value) {
            loginScreenController.updateEmail(value);
          },
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
        GetBuilder<LoginScreenController>(
          builder: (context) {
            return TextField(
              onChanged: (value) {
                loginScreenController.updatePassword(value);
              },
              obscureText: loginScreenController.showPassword,
              decoration: InputDecoration(
                hintText: 'Password',
                suffixIcon: InkWell(
                  onTap: () {
                    loginScreenController.changePasswordhideAndShow();
                  },
                  child: Icon(
                    loginScreenController.showPassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: Colors.grey,
                  ),
                ),
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
            );
          },
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                context.router.push(ForgotRouteView());
              },
              child: Text(
                'Forgot Password?',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 40),
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
              loginScreenController.SigninWithEmailandPassword(context);
            },
            child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: 50,
                child: Center(child: Text('Sign In'))),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an account? Join us",
              style:
                  TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 5),
            GestureDetector(
              onTap: () {
                context.router.push(RegisterRouteView());
              },
              child: Text(
                'here!',
                style: TextStyle(
                    color: Colors.deepPurple, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
        Row(children: [
          Expanded(
            child: Divider(
              color: Colors.grey[300],
              height: 50,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text('Or continue with'),
          ),
          Expanded(
            child: Divider(
              color: Colors.grey[400],
              height: 50,
            ),
          ),
        ]),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _loginWithButton(image: 'assets/google.png'),
          ],
        ),
      ],
    );
  }

  Widget _loginWithButton({required String image, bool isActive = false}) {
    return Container(
      width: 90,
      height: 70,
      decoration: isActive
          ? BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[300]!,
                  spreadRadius: 10,
                  blurRadius: 30,
                )
              ],
              borderRadius: BorderRadius.circular(15),
            )
          : BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey[400]!),
            ),
      child: Center(
        child: Image.asset(
          image,
          width: 35,
        ),
      ),
    );
  }
}
