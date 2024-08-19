import 'package:flutter/material.dart';
import 'package:sociogram/app/modules/Generalaetting_screen/Loginactivity_screen.dart';

import '../../../config/common_textfield.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  List img = [
    'assets/key.png',
    'assets/location1.png',
    'assets/lock.png',
    'assets/archive.png',
  ];
  List text = [
    'Change Password',
    'Login Activity',
    'Two Step Authentication',
    'Saved For Login',
  ];
  List img1 = [
    'assets/activity.png',
    'assets/lock-circle.png',
  ];
  List text1 = [
    'History Devices Login',
    'Privacy Information',
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
        title: const Text('Security', style: TextStyle(fontSize: 18, color: Colors.black, fontFamily: 'Urbanist-semibold'),),
        centerTitle: true,
        actions: [
          SizedBox(
              height: 24,
              width: 24,
              child: Image.asset('assets/setting-4.png')),
          const SizedBox(width: 15,),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
              child: General(text: 'Search'),
            ),
            const ListTile(
              leading: Text('General Security', style: TextStyle(fontSize: 18, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600),),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: img.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    if(index == 0){
                    }else if(index == 1){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginactivityScreen(),));
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: ListTile(
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
                            child: SizedBox(
                              height: 24,
                              width: 24,
                              child: Image.asset(img[index], color: Colors.black,),
                            ),
                          ),
                        ],
                      ),
                      title: Text(text[index], style: const TextStyle(fontSize: 14, fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w600),),
                      trailing: const Icon(Icons.navigate_next),
                    ),
                  ),
                );
              },),

            const ListTile(
              leading: Text('History & Data Information', style: TextStyle(fontSize: 18, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600),),
            ),

            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: img1.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: ListTile(
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
                            child: SizedBox(
                              height: 24,
                              width: 24,
                              child: Image.asset(img1[index]),
                            ),
                          ),
                        ],
                      ),
                      title: Text(text1[index], style: const TextStyle(fontSize: 14, fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w600),),
                      trailing: const Icon(Icons.navigate_next),
                    ),
                  ),
                );
              },),
          ],
        ),
      ),
    );
  }
}