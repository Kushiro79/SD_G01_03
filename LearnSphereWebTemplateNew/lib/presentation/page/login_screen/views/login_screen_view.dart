import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../theme/gen/assets.gen.dart';
import 'package:get/get.dart';
import '../../../routes/app_router.dart';
import '../controllers/login_screen_controller.dart';
import 'package:google_fonts/google_fonts.dart';

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
    final screenwidth = MediaQuery.of(context).size.width > 850;

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF000000),
                  Color(0xFF117aca),
                  
                ],
                stops: [0.05,0.7],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Content on top of the background
          ListView(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05),
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: screenwidth
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(children: [
                              Image(
                                image: AssetImage(
                                    ProjectAssets.learnSphereLogo.path),
                                width:  80 ,
                                height: 80 ,
                              ),
                              const SizedBox(width: 20),
                              Text('Learn',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize:  30 ,
                                      color: Colors.white)),
                              Text(
                                'Sphere',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF004ff9),
                                    fontSize:   30 ),
                              )
                            ]),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(children: [
                              Image(
                                image: AssetImage(
                                    ProjectAssets.learnSphereLogo.path),
                                width: 80,
                                height: 80,
                              ),
                              const SizedBox(width: 20),
                              Text("Learn",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                      color: Colors.white)),
                              Text(
                                "Sphere",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF004ff9),
                                    fontSize: 30),
                              )
                            ]),
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
      padding: const EdgeInsets.only(right: 75),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isActive ? Colors.white : Colors.grey,
              ),
            ),
            const SizedBox(height: 6),
            isActive
                ? Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  )
                : const SizedBox(),
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
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[200]!,
                spreadRadius: 5,
                blurRadius: 10,
              ),
            ],
          ),
          child: const Text(
            'Sign Up',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF23235E),
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
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.45,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: AlignmentDirectional.topStart,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Text(
                        'Welcome back to LearnSphere! Ready to dive back into learning?',
                        style: GoogleFonts.montserrat(
                            fontSize: 45,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                offset:
                                Offset(2.0, 2.0), // position of the shadow
                                blurRadius: 4.0, // how "soft" the shadow is
                                color: Colors.black.withOpacity(
                                    0.5), // shadow color and opacity
                              )
                            ]),
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
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _menuItem(title: 'Sign In', isActive: true),
                          _registerButton(context),
                        ],
                      ),
                      _formLogin(context),
                    ],
                  ),
                ),
              ),
            ],
          );
        } else {
          //mobile layout
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                        'Welcome back to LearnSphere! Ready to dive back into learning?',
                        style: GoogleFonts.montserrat(
                            fontSize: 30,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                offset:
                                Offset(2.0, 2.0), // position of the shadow
                                blurRadius: 4.0, // how "soft" the shadow is
                                color: Colors.black.withOpacity(
                                    0.5), // shadow color and opacity
                              )
                            ]),
                      ),
              ),
              Image.asset(
                'assets/login_ui2.png',
                width: constraints.maxWidth * 0.9,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height / 10),
                child: SizedBox(
                  width: constraints.maxWidth * 0.9,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _menuItem(title: 'Sign In', isActive: true),
                          _registerButton(context),
                        ],
                      ),
                      _formLogin(context),
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

  Widget _formLogin(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        _buildTextField(
          hintText: 'Enter your Email...',
          labelText: 'Email',
          onChanged: loginScreenController.updateEmail,
        ),
        const SizedBox(height: 20),
        Obx(()=> _buildTextField(
          hintText: 'Min. 6 characters...',
          labelText: 'Password',
          onChanged: loginScreenController.updatePassword,
          obscureText: loginScreenController.showPassword.value,
          suffixIcon: IconButton(
            icon: Icon(
              loginScreenController.showPassword.value
                  ? Icons.visibility_off
                  : Icons.visibility,
            ),
            onPressed: () {
              loginScreenController.changePasswordhideAndShow();
            },
          ),
        ),
        ),
        const SizedBox(height: 10),
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
                  color: Color(0xFF23235E),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 40),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: const[
            BoxShadow(
                color: Colors.white,
                spreadRadius: 5,
                blurRadius: 10,
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: () {
              loginScreenController.SigninWithEmailandPassword(context);
              
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                height: 50,
                child: const Center(child: Text('Sign In', style: TextStyle(color: Color(0xFF23235E)),))),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Don't have an account? Join us",
              style:
                  TextStyle(color: Colors.white, ),
            ),
            TextButton(
              onPressed: () {
                context.router.replace(RegisterRouteView());
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.only(
                  left: 4,
                ), // Removes all padding
                minimumSize:
                    const Size(0, 0), // Optionally adjust the minimum size
                tapTargetSize:
                    MaterialTapTargetSize.shrinkWrap, // Shrinks the hitbox
              ),
              child: const Text(
                'here',
                style: TextStyle(
                    color: Color(0xFF23235E), fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
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
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           // _loginWithButton(image: 'assets/google.png'),
          ],
        ),*/
      ],
    );
  }

  Widget _loginWithButton({required String image}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          padding: const EdgeInsets.all(10),
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
    );
  }
}
