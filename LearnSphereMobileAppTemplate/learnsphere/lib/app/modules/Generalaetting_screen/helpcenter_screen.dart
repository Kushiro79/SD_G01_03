import 'package:flutter/material.dart';
import 'package:sociogram/app/modules/Generalaetting_screen/faqs_screen.dart';
import 'package:sociogram/app/modules/Generalaetting_screen/privacy_screen.dart';

import '../../../config/common_textfield.dart';

class HelpcenterScreen extends StatefulWidget {
  const HelpcenterScreen({super.key});

  @override
  State<HelpcenterScreen> createState() => _HelpcenterScreenState();
}

class _HelpcenterScreenState extends State<HelpcenterScreen> {
  List img = [
    'assets/invite1.png',
    'assets/invite2.png',
    'assets/invite3.png',
    'assets/invite4.png',
    'assets/invite4.png',
  ];
  List text = [
    'Report a Problem',
    'Security',
    'FAQ’s',
    'Live Chat',
    'Privacy Policy',
  ];
  List sutext = [
    "If there are problems, immediately tell\nus about the problems you are\nexperiencing.",
    "Learn what you can do if something you\npost is taken down system.",
    "If you need more information about us,\nyou can get it through the FAQ’s menu.",
    "Tell us about your problems in real time\n24/7 for you.",
    "Learn more about the terms and\nconditions of using our app.",
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
        title: const Text('Help Center', style: TextStyle(fontSize: 18, color: Colors.black, fontFamily: 'Urbanist-semibold'),),
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
            const SizedBox(height: 20,),
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
                    }else if(index == 2){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const FaqsScreen()));
                    }else if(index == 3){}
                    else if(index == 4){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const PrivacyScreen()));
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
                              child: Image.asset(img[index]),
                            ),
                          ),
                        ],
                      ),
                      title: Text(text[index], style: const TextStyle(fontSize: 16, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600),),
                      subtitle: Text(sutext[index], style: const TextStyle(fontSize: 12, color: Color(0xff64748B), fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w500),),
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
