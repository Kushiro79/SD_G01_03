// ignore_for_file: file_names
import 'package:flutter/material.dart';

import '../../../config/app_color.dart';
import '../../../config/common_textfield.dart';

class LoginactivityScreen extends StatefulWidget {
  const LoginactivityScreen({super.key});

  @override
  State<LoginactivityScreen> createState() => _LoginactivityScreenState();
}

class _LoginactivityScreenState extends State<LoginactivityScreen> {
  List text = [
    'Washington, US',
    'Paris, Prancis',
  ];
  List text1 =[
    'Chrome, ID : MX2023R',
    'Mozila, ID : M0231K',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back, color: Colors.black,),
        ),
        title: const Text('Login Activity', style: TextStyle(fontSize: 18, color: Colors.black, fontFamily: 'Urbanist-semibold'),),
        centerTitle: true,
        actions: [
          SizedBox(
              height: 24,
              width: 24,
              child: Image.asset('assets/setting-4.png')),
          const SizedBox(width: 15,),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
            child: General(text: 'Search'),
          ),
          const ListTile(
            leading: Text('Recent Activity ', style: TextStyle(fontSize: 18, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600),),
          ),
          ListTile(
            leading: Stack(
              children: [
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: const Color(0xffF8F9FD),
                  ),
                ),
                Positioned(
                    top: 11,
                    left: 0,
                    right: 0,
                    child: Image.asset('assets/location-tick.png', height: 24,)),
              ],
            ),
            title: const Text('Washington, US', style: TextStyle(fontSize: 14, fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w600),),
            subtitle: const Row(
              children: [
                Text('Online  ', style: TextStyle(fontSize: 12, fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w600, color: AppColor.purple),),
                Text('This Iphone 13', style: TextStyle(fontSize: 12, fontFamily: 'Urbanist-regular', fontWeight: FontWeight.w400, color: Color(0xff94A3B8)),),
              ],
            ),
            trailing: const Icon(Icons.navigate_next),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Divider(
              height: 20,
              thickness: 1,
              color: Color(0xffE2E8F0),
            ),
          ),
          
          const ListTile(
            leading: Text('Past Activity ', style: TextStyle(fontSize: 18, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600),),
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: text.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Stack(
                  children: [
                    Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: const Color(0xffF8F9FD),
                      ),
                    ),
                    Positioned(
                        top: 11,
                        left: 0,
                        right: 0,
                        child: Image.asset('assets/location-cross.png', height: 24,)),
                  ],
                ),
                // Image.asset('assets/location-cross.png', height: 24,),
                title: Text(text[index], style: const TextStyle(fontSize: 14, fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w600),),
                subtitle: Row(
                  children: [
                    const Text('Offline  ', style: TextStyle(fontSize: 12, fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w600, color: Color(0xffFF4D2D)),),
                    Text(text1[index], style: const TextStyle(fontSize: 12, fontFamily: 'Urbanist-regular', fontWeight: FontWeight.w400, color: Color(0xff94A3B8)),),
                  ],
                ),
                trailing: const Icon(Icons.navigate_next),
              );
          },)
        ],
      ),
    );
  }
}
