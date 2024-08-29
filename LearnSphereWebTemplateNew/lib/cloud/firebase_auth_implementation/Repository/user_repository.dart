import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {

  static UserRepository get to => Get.find();

  final _db = FirebaseFirestore.instance;
  
  
}