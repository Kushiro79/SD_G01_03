import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/app_color.dart';
import '../../../config/app_contents.dart';
import '../../../routes/app_router.dart';
import '../controllers/register_controller.dart';

@RoutePage()
class RegisterView extends GetView<RegisterController> {
  RegisterView({Key? key}) : super(key: key);

  final RegisterController registerController = Get.put(RegisterController());

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
// ignore: must_be_immutable
class RegisterScreenView extends GetView<RegisterController> {
  RegisterScreenView({Key? key}) : super(key: key);
  RegisterController registerController = Get.put(RegisterController());
  
  @override
   void dispose() {
    registerController.disposeControllers();
  }
  
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Image.asset(
                          Appcontent.back,
                          height: 24,
                        )),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10, top: 40),
                    child: Text('Register',
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Urbanist-bold'),
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    child: Text('Please input your form register.',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Urbanist-medium'),
                        overflow: TextOverflow.ellipsis),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 70, left: 10, right: 10, bottom: 10),
                    child:
                        GetBuilder<RegisterController>(builder: (controller) {
                      return TextField(
                          onChanged: (value) {
                            registerController.updateUsername(value);
                          },
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              hintText: 'Enter your Username...',
                              labelText: 'Username',
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade200),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade200),
                              )));
                    }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child:
                        GetBuilder<RegisterController>(builder: (controller) {
                      return TextField(
                        onChanged: (value) {
                          registerController.updateEmail(value);
                        },
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            hintText: 'Enter your Email...',
                            labelText: 'Email',
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: GetBuilder<RegisterController>(builder: (context) {
                      return TextField(
                        onChanged: (value) {
                          registerController.updatePassword(value);
                        },
                        obscureText: registerController.showPassword,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            hintText: 'Min. 8 characters...',
                            labelText: 'Password',
                            suffixIcon: InkWell(
                              onTap: () {
                                registerController.changePasswordhideAndShow();
                              },
                              child: SizedBox(
                                height: 20,
                                width: 20,
                                child: Center(
                                  child: registerController.showPassword
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
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                              text: 'Note : ',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black)),
                          TextSpan(
                              text: 'With sign up, you agree to the ',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey)),
                          TextSpan(
                              text: 'Terms & Conditions\n',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black)),
                          TextSpan(
                              text: 'and ',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey)),
                          TextSpan(
                              text: 'Privacy Policy.',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: elevated(
                      text: 'Sign Up',
                      onPress: () {
                        registerController.createUserwithEmailandPassword(
                            registerController.email,
                            registerController.password,
                            context
                            );
                        print('Username : ' + registerController.username);
                        print('Email : ' + registerController.email);
                        print('password : ' + registerController.password);
                      },
                    ),
                  ),
                  const Expanded(child: SizedBox(height: 150)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account ? ',
                          style: TextStyle(color: Colors.grey[500]),
                          overflow: TextOverflow.ellipsis),
                      InkWell(
                        onTap: () {
                          context.router.push(LoginRouteView());
                        },
                        child: const Text('Sign In',
                            style: TextStyle(
                                color: AppColor.purple, fontFamily: 'Urbanist'),
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),

            ),
          ),
          _body(context),
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
                _buildSignUpButton(),
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

  Widget _buildSignUpButton() {
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
