import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/app_color.dart';
import '../../../routes/app_router.dart';
import '../controllers/register_controller.dart';
import '../../../theme/gen/assets.gen.dart';
import 'package:google_fonts/google_fonts.dart';

@RoutePage()
class RegisterScreenView extends GetView<RegisterController> {
  RegisterScreenView({super.key});

  final RegisterController registerController = Get.put(RegisterController());
  @override
  void dispose() {
    registerController.disposeControllers();
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
                  Color.fromARGB(255, 0, 27, 73),
                  Color(0xFF117aca),
                ],
                stops: [0.1, 0.8],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
          // Content on top of the background image
          ListView(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      Image(
                        image: AssetImage(ProjectAssets.learnSphereLogo.path),
                        width:  80 ,
                        height: 80 ,
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
      padding: const EdgeInsets.only(left: 75),
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

  Widget _signInButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router.push(LoginRouteView());
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
          'Sign In',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF23235E),
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
                  _buildHeader(context),
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
                child: SizedBox(
                  width: MediaQuery.of(context).size.width *
                      0.25, // Adjust width for wide layout
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _signInButton(context),
                          _menuItem(title: 'Sign Up', isActive: true),
                        ],
                      ),
                      const SizedBox(height: 20),
                      _buildForm(context),
                      const SizedBox(height: 20),
                      _buildSignUpButton(context),
                      const SizedBox(height: 10),
                      _buildSignInLink(context),
                      const SizedBox(height: 20),
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
                      const SizedBox(height: 15),

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
              _buildHeader(context),
              Image.asset(
                'assets/register4.png',
                width: constraints.maxWidth *
                    0.9, // Adjust width for narrow layout
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
                        _signInButton(context),
                        _menuItem(title: 'Sign Up', isActive: true),
                      ]),
                      const SizedBox(height: 20),
                      _buildForm(context),
                      const SizedBox(height: 20),
                      _buildSignUpButton(context),
                      const SizedBox(height: 10),
                      _buildSignInLink(context),
                      const SizedBox(height: 20),
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

  Widget _buildHeader(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width > 850;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        screenwidth 
        ?Text(
          'Come on, Join Us!\nIt\'s Free :D',
          style: GoogleFonts.montserrat(
              fontSize: 45,
              color: Colors.white,
              shadows: [
                Shadow(
                  offset: Offset(2.0, 2.0), // position of the shadow
                  blurRadius: 4.0, // how "soft" the shadow is
                  color:
                      Colors.black.withOpacity(0.5), // shadow color and opacity
                )
              ]),
        )
        :Text(
          'Come on, Join Us!\nIt\'s Free :D',
          style: GoogleFonts.montserrat(
              fontSize: 30,
              color: Colors.white,
              shadows: [
                Shadow(
                  offset: Offset(2.0, 2.0), // position of the shadow
                  blurRadius: 4.0, // how "soft" the shadow is
                  color:
                      Colors.black.withOpacity(0.5), // shadow color and opacity
                )
              ]),
        ),
        const SizedBox(height: 10),
        const Text(
          "You won't regret it!!",
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
        const SizedBox(height: 20),
        _buildTextField(
          hintText: 'Enter your Email...',
          labelText: 'Email',
          onChanged: registerController.updateEmail,
        ),
        const SizedBox(height: 20),
        Obx(()=> _buildTextField(
          hintText: 'Min. 6 characters...',
          labelText: 'Password',
          onChanged: registerController.updatePassword,
          obscureText: registerController.showPassword.value,
          suffixIcon: IconButton(
            icon: Icon(
              registerController.showPassword.value
                  ? Icons.visibility_off
                  : Icons.visibility,
            ),
            onPressed: () {
              registerController.changePasswordhideAndShow();
            },
          ),
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

  Widget _buildSignUpButton(BuildContext context) {
    return Center(
      child: Container(
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
            registerController.createUserwithEmailandPassword(
              registerController.email,
              registerController.password,
              context,
            );
            print('Username: ${registerController.username}');
            print('Email: ${registerController.email}');
            print('Password: ${registerController.password}');
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: const SizedBox(
            width: double.infinity,
            height: 50,
            child: Center(
                child: Text(
              'Sign Up',
              style: TextStyle(color: Color(0xFF23235E)),
            )),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Already have an account?',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () {
            context.router.push(LoginRouteView());
          },
          child: const Text(
            'Sign In',
            style: TextStyle(
                color: Color.fromARGB(255, 35, 35, 94),
                fontWeight: FontWeight.bold),
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
