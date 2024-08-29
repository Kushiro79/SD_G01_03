import 'package:flutter/material.dart';

Widget textfield(
    {required String text,
    IconData? icon,
     IconData? subicon,
    IconData? subicone,
    required String text1}) {
  return TextField(
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        labelText: text1,
        hintText: text,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(35),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(35),
          borderSide: BorderSide(color: Colors.grey.shade200),
        )),
  );
}

Widget textfield1(
    {required String text,
    IconData? icon,
    String? subicon,
    IconData? subicone,
    required String text1}) {
  return TextField(
    decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        hintText: text,
        labelText: text1,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(35),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(35),
          borderSide: BorderSide(color: Colors.grey.shade200),
        )),
  );
}

Widget textfield2({IconData? icon, IconData? subicon, IconData? subicone}) {
  return SizedBox(
    height: 32,
    width: 239,
    child: TextField(
      style: const TextStyle(color: Colors.grey),
      decoration: InputDecoration(
        suffixIcon: Icon(subicon),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(35),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(35),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
    ),
  );
}

// Edit profile
Widget textfield3(
    {required String text,
    required String text1,
    IconData? icon,
    IconData? subicon,
    IconData? subicone}) {
  return SizedBox(
    height: 74,
    width: 350,
    child: TextField(
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: text1,
        hintText: text,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(35),
          borderSide: const BorderSide(color: Color(0xffE2E8F0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(35),
          borderSide: const BorderSide(color: Color(0xffE2E8F0)),
        ),
      ),
    ),
  );
}

// Live comment textfield
Widget livetextfield({required String text,}) {
  return SizedBox(
    height: 44,
    width: 215,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.40),
        borderRadius: BorderRadius.circular(35),
      ),
      child: TextField(
        style: const TextStyle(color: Colors.white, fontSize: 12, fontFamily: 'Urbanist-medium'),
        decoration: InputDecoration(
          hintText: text,hintStyle: const TextStyle(color: Colors.white, fontFamily: 'Urbanist-medium'),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35),
            borderSide:  BorderSide(color: Colors.grey.withOpacity(0.40)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35),
            borderSide:  BorderSide(color: Colors.grey.withOpacity(0.40)),
          ),
        ),
      ),
    ),
  );
}

// General Settings and Search
// ignore: non_constant_identifier_names
Widget General({required String text,}) {
  return Padding(
    padding: const EdgeInsets.only(left: 10),
    child: TextField(
      autofocus: false,
      style: const TextStyle(fontSize: 16, color: Color(0xFF94A3B8)),
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.all(15),
          child: Image.asset('assets/search.png',height: 20,width: 20,),
        ),
        filled: true,
        fillColor: const Color(0xffF8F9FD),
        hintText: 'search...',hintStyle: const TextStyle(color: Colors.grey, fontFamily: 'Urbanist-regular', fontSize: 16),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xff3BBAA6)),
          borderRadius: BorderRadius.circular(25.7),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: const BorderSide(color: Color(0xffF8F9FD)),
          borderRadius: BorderRadius.circular(25.7),
        ),
      ),
    ),
  );
}
