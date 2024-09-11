import 'package:auto_route/auto_route.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utils/custom_toast.dart';
import '../../config/app_contents.dart';
import '../../routes/app_router.dart';

class ChangePasswordController extends GetxController {
  final count = 0.obs;

  void increment() => count.value++;

  final oldpassword = TextEditingController();
  final newpassword = TextEditingController();
  final confirmpassword = TextEditingController();

  Future<void> changePassword(BuildContext context) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        if (newpassword.text == confirmpassword.text) {
          // Create a credential for re-authentication
            AuthCredential credential = EmailAuthProvider.credential(
            email: user.email!,
            password: oldpassword.text,
          );
       
          

          // Re-authenticate the user
          await user.reauthenticateWithCredential(credential);

          await user.updatePassword(newpassword.text);
          _showSuccessDialog(context);
        } else {
          showCustomToast(context, 'Password does not match');
        }
      } else {
        showCustomToast(context, 'Please login first');
      }
    } on FirebaseAuthException catch (e) {
      showCustomToast(context, e.message.toString());
    } catch (e) {
      showCustomToast(context,'An unexpected error occurred');
    }
  }

  void _showSuccessDialog(BuildContext context) {
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
            padding:
                MediaQuery.of(context).padding + const EdgeInsets.only(top: 25),
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
  }


  
}
