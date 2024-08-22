import 'package:flutter/material.dart';
import 'package:sociogram/app/modules/Generalaetting_screen/about_screen.dart';
import 'package:sociogram/app/modules/Generalaetting_screen/closefriend_screen.dart';
import 'package:sociogram/app/modules/Generalaetting_screen/helpcenter_screen.dart';
import 'package:sociogram/app/modules/Generalaetting_screen/language_screen.dart';
import 'package:sociogram/app/modules/Generalaetting_screen/notification_screen.dart';
import 'package:sociogram/app/modules/Generalaetting_screen/security_screen.dart';

import '../../../config/common_textfield.dart';

class InviteScreen extends StatefulWidget {
  const InviteScreen({super.key});

  @override
  State<InviteScreen> createState() => _InviteScreenState();
}

class _InviteScreenState extends State<InviteScreen> {
  List img = [
    'assets/invite1.png',
    'assets/invite2.png',
    'assets/invite3.png',
    'assets/invite4.png',
    'assets/invite5.png',
    'assets/invite6.png',
  ];
  List text = [
    'Push Notifiaction',
    'Security',
    'Change Language',
    'Close Friends',
    'Help Center',
    'About Sociogram',
  ];
  List sutext = [
    "You can follow your friends who are in\nyour phone contacts.",
    "Invite your friends to join you via Link.",
    "Invite your friends to join you via Email.",
    "Invite your friends to join you via SMS.",
    "Invite your friends to join you via\nWhatsapp.",
    'Invite your friends to join you via\nTelegram.',
  ];
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back, color: Colors.black,),
            ),
            title: const Text('Follow & Invite', style: TextStyle(fontSize: 18, color: Colors.black, fontFamily: 'Urbanist-semibold'),),
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificatonScreen()));
                        }else if(index == 1){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const SecurityScreen()));
                        }else if(index == 2){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const LangyageScreen()));
                        }else if(index == 3){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ClosefriendScreen()));
                        }
                        else if(index == 4){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const HelpcenterScreen()));
                        } else if(index == 5){
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>  const AboutScreen()));
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
      },
    );
  }
}