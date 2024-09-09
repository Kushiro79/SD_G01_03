import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/app_color.dart';
import '../../../config/app_contents.dart';
import '../../../routes/app_router.dart';
import '../../change_password/change_password_controller.dart';
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
      body: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 8),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    _menuItem(title: 'Home'),
                    _menuItem(title: 'About us'),
                    _menuItem(title: 'Contact us'),
                    _menuItem(title: 'Help'),
                  ],
                ),
                Row(
                  children: [
                    _SignInButton(context),
                    _menuItem(title: 'Register', isActive: true),
                  ],
                ),
              ],
            )
          ),
          _body(context),
        ]
      )
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

  Widget _SignInButton(BuildContext context) {
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 490,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              Image.asset(
                'assets/register4.png',
                width: 500,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height / 6),
          child: Container(
            width: 320,
            child: Column(
              children: [
                _buildForm(context),
                SizedBox(height: 20),
                _buildSignUpButton(context),
                SizedBox(height: 10),
                _buildSignInLink(context),
                SizedBox(height: 20),
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
                _loginWithButton(image: 'assets/google.png'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
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
          hintText: 'Min. 8 characters...',
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
        fillColor: Colors.grey[200],
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey.shade500),
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
          style: TextStyle(color: Colors.grey),
        ),
        TextButton(
          onPressed: () {
            context.router.push(LoginRouteView());
          },
          child: const Text(
            'Sign In',
            style: TextStyle(color: AppColor.purple),
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
