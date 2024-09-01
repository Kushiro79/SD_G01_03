import 'package:get/get.dart';

class LoginScreenController extends GetxController {
 //observable
  var email =''.obs;
  var password = ''.obs;
  var isValidEmail = true.obs;
  var isValidPassword  = true.obs;

  void updateEmail(String value){
    email.value = value;
    //isValidEmail.value = isEmail(value);
    bool validEmail = isEmail(value);
    print('email: $value, valid: $validEmail'); //debug test
    isValidEmail.value = validEmail;
    update();
  }


  void updatePassword(String value){
    password.value = value;
    update();
  }

  /*bool isPassValid(String password){
    return password.length >= 8 &&
    RegExp(r'[a-z]').hasMatch(password) &&
    RegExp(r'[A-Z]').hasMatch(password) &&
    RegExp(r'[0-9]').hasMatch(password) &&
    RegExp(r'[!@#$&*]').hasMatch(password);
  }*/

   bool isEmail(String email){
    final emailRegex = RegExp(
       r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  //TODO: Implement LoginScreenController

  final count = 0.obs;
  bool showPassword = true;

  void increment() => count.value++;

  changePasswordhideAndShow(){
    showPassword = !showPassword;
    update();
  }

  bool validateCredentials(){
    updateEmail(email.value);
    updatePassword(password.value);
    return isValidEmail.value && isValidPassword.value;
  }

  
}
