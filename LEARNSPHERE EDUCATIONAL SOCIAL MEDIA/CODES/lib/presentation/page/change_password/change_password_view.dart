import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'change_password_controller.dart';

@RoutePage()
class ChangePasswordPage extends GetView<ChangePasswordController> {
  ChangePasswordPage({super.key});
  @override
  ChangePasswordController controller = Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: const Color(0xFF1A1F3B),
      body: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 8),
        children: [
          
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
            const SizedBox(height: 6),
            isActive
                ? Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
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
      // Check the available width and adjust the layout accordingly
      if (constraints.maxWidth > 800) {
        // Wide layout
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/forgot_ui.png',
                    width: MediaQuery.of(context).size.width * 0.4,

                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height / 10),
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
              width: constraints.maxWidth * 0.9, // Adjust image width
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
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Padding(
          padding:  EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: Text(
            'Change Password?',
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color : Colors.white,
            ),
          ),
        ),
        const Padding(
          padding:  EdgeInsets.symmetric(horizontal: 0, vertical: 10),
          child:  Text(
            'Change your old password to new password',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
        TextField(
          obscureText: true,
          controller: controller.oldpassword,
          decoration: InputDecoration(
            hintText: 'Enter Old Password ',
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
        Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.02)),
        TextField(
          obscureText: true,
          controller: controller.newpassword,
          decoration: InputDecoration(
            hintText: 'Enter New Password ',
            filled: true,
            fillColor: Colors.blueGrey[50],
            labelStyle:const  TextStyle(fontSize: 12),
            contentPadding:const EdgeInsets.only(left: 30),
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
        Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.02)),
        TextField(
          obscureText: true,
          controller: controller.confirmpassword,
          decoration: InputDecoration(
            hintText: 'Confirm New Password ',
            filled: true,
            fillColor: Colors.blueGrey[50],
            labelStyle:const TextStyle(fontSize: 12),
            contentPadding:const EdgeInsets.only(left: 30),
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
            boxShadow: const [
              BoxShadow(
                color: Color(0xFF117aca),
                spreadRadius: 10,
                blurRadius: 20,
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: () {
              controller.changePassword(context);
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const SizedBox(
                width: double.infinity,
                height: 50,
                child: Center(child: Text('Reset Password'))),
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
