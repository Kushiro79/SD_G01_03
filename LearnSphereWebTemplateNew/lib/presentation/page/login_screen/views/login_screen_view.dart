import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
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
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/background4.jpg', // Your background image
              fit: BoxFit.cover,
            ),
          ),
          // Content on top of the background
          ListView(
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
        if (constraints.maxWidth > 800) {
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
                      width: MediaQuery.of(context).size.width * 0.4,
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
                      0.05, // Set your desired right padding
                  top: MediaQuery.of(context).size.height /
                      6, // Keep the vertical padding
                  bottom: MediaQuery.of(context).size.height /
                      6, // Keep the vertical padding
                  
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: _formLogin(context),
                ),
              ),
            ],
          );
        } else {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  'Welcome to LearnSphere, Buddy!',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Image.asset(
                'assets/login_ui2.png',
                width: constraints.maxWidth * 0.7,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height / 10),
                child: Container(
                  width: constraints.maxWidth * 0.9,
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
        SizedBox(height: 20),
        _buildTextField(
          hintText: 'Enter your Email...',
          labelText: 'Email',
          onChanged: loginScreenController.updateEmail,
        ),
        SizedBox(height: 20),
        _buildTextField(
          hintText: 'Min. 6 characters...',
          labelText: 'Password',
          onChanged: loginScreenController.updatePassword,
          obscureText: loginScreenController.showPassword,
          suffixIcon: IconButton(
            icon: Icon(
              loginScreenController.showPassword
                  ? Icons.visibility_off
                  : Icons.visibility,
            ),
            onPressed: () {
              loginScreenController.changePasswordhideAndShow();
            },
          ),
        ),
      
      SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () {
              context.router.push(ForgotRouteView());
            },
            child: const Text(
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
          TextButton(
              onPressed: () {
                context.router.push(RegisterRouteView());
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.only(
                  left: 4,
                ), // Removes all padding
                minimumSize: Size(0, 0), // Optionally adjust the minimum size
                tapTargetSize:
                    MaterialTapTargetSize.shrinkWrap, // Shrinks the hitbox
              ),
              child: const Text(
                'here',
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

  Widget _loginWithButton({required String image}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[400]!),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Image.asset(image, width: 40),
        ),
      ),
    );
  }

   Widget _buildTextField({
    required String hintText,
    required String labelText,
    required Function(String) onChanged,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return TextField(
      onChanged: onChanged,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        suffixIcon: suffixIcon,
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
  }
}
