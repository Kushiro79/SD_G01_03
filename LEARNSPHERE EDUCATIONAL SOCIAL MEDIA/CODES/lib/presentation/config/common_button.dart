import 'package:flutter/material.dart';
import 'app_color.dart';

Widget elevated({required String text,void Function()? onPress}){

  return ElevatedButton(
      style: ElevatedButton.styleFrom(fixedSize: const Size(327, 56), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)), elevation: 0, backgroundColor: AppColor.purple),
      onPressed: onPress,
      child: Text(text, style: const TextStyle(fontSize: 16, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600)));
}
// Profile button
Widget elevated1({required String text,void Function()? onPress}){
  return ElevatedButton(
      style: ElevatedButton.styleFrom(fixedSize: const Size(255, 56), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)), backgroundColor: AppColor.purple, elevation: 0),
      onPressed: onPress,
      child: Text(text, style: const TextStyle(fontSize: 16, fontFamily: 'Urbanist-semibold')));
}
// Product button
Widget product({required String text,void Function()? onPress}){
  return ElevatedButton(
      style: ElevatedButton.styleFrom(fixedSize: const Size(149, 56), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)), backgroundColor: AppColor.purple, elevation: 0),
      onPressed: onPress,
      child: Text(text, style: const TextStyle(fontSize: 16, fontFamily: 'Urbanist-semibold')));
}