import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/app_color.dart';
import '../../../routes/app_router.dart';
import '../controllers/register_controller.dart';

@RoutePage()
class RegisterScreenView extends GetView<RegisterController> {
  RegisterScreenView({Key? key}) : super(key: key);

  final RegisterController registerController = Get.put(RegisterController());
  @override
  void dispose() {
    registerController.disposeControllers();
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
              'assets/background4.jpg',
              fit: BoxFit.cover, // Makes the image cover the entire screen
            ),
          ),
          // Content on top of the background image
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
                          _signInButton(context),
                          _menuItem(title: 'Register', isActive: true),
                        ],
                      ),
                    ],
                  )),
              _body(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _menuItem({String title = 'Title Menu', bool isActive = false}) {
    return Padding(
      padding: const EdgeInsets.only(left: 75),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
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

  Widget _signInButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router.push(LoginRouteView());
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
          'Sign In',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    Image.asset(
                      'assets/register4.png',
                      width: 500,
                    ),
                  ],
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
                  width: MediaQuery.of(context).size.width *
                      0.25, // Adjust width for wide layout
                  child: Column(
                    children: [
                      _buildForm(context),
                      SizedBox(height: 20),
                      _buildSignUpButton(context),
                      SizedBox(height: 10),
                      _buildSignInLink(context),
                      SizedBox(height: 20),
                      /*Row(children: [
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
                      ]),*/
                      SizedBox(height: 15),

                      //_loginWithButton(image: 'assets/google.png'),
                    ],
                  ),
                ),
              ),
            ],
          );
        } else {
          // Narrow layout (Column)
          return Column(
            children: [
              _buildHeader(),
              Image.asset(
                'assets/register4.png',
                width: constraints.maxWidth *
                    0.9, // Adjust width for narrow layout
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height / 10),
                child: Container(
                  width: constraints.maxWidth * 0.9,
                  child: Column(
                    children: [
                      _buildForm(context),
                      SizedBox(height: 20),
                      _buildSignUpButton(context),
                      SizedBox(height: 10),
                      _buildSignInLink(context),
                      SizedBox(height: 20),
                      /*Row(children: [
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
                      SizedBox(height: 15),*/
                      //_loginWithButton(image: 'assets/google.png'),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Widget _buildHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Register',
          style: TextStyle(
            fontSize: 45,
            fontWeight: FontWeight.bold,
            fontFamily: 'Urbanist-bold',
          ),
        ),
        SizedBox(height: 10),
        Text(
          "Hi buddy, we're glad to see you join us!",
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
            fontFamily: 'Urbanist-medium',
          ),
        ),
      ],
    );
  }

  Widget _buildForm(BuildContext context) {
    return Column(
      children: [
        _buildTextField(
          hintText: 'Enter your Username...',
          labelText: 'Username',
          onChanged: registerController.updateUsername,
        ),
        SizedBox(height: 20),
        _buildTextField(
          hintText: 'Enter your Email...',
          labelText: 'Email',
          onChanged: registerController.updateEmail,
        ),
        SizedBox(height: 20),
        _buildTextField(
          hintText: 'Min. 6 characters...',
          labelText: 'Password',
          onChanged: registerController.updatePassword,
          obscureText: registerController.showPassword,
          suffixIcon: IconButton(
            icon: Icon(
              registerController.showPassword
                  ? Icons.visibility_off
                  : Icons.visibility,
            ),
            onPressed: () {
              registerController.changePasswordhideAndShow();
            },
          ),
        ),
      ],
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

  Widget _buildSignUpButton(BuildContext context) {
    return Center(
      child: Container(
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
            registerController.createUserwithEmailandPassword(
              registerController.email,
              registerController.password,
              context,
            );
            print('Username: ${registerController.username}');
            print('Email: ${registerController.email}');
            print('Password: ${registerController.password}');
          },
          child: Container(
            width: double.infinity,
            height: 50,
            child: Center(child: Text('Sign Up')),
          ),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account?',
          style: TextStyle(
            color: Colors.black54,
             fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () {
            context.router.push(LoginRouteView());
          },
          child: const Text(
            'Sign In',
            style:
                TextStyle(color: AppColor.purple, 
                fontWeight: FontWeight.bold
                ),
          ),
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