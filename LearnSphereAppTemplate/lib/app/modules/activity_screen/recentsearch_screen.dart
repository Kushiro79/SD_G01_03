// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociogram/app/modules/activity_screen/activity_screen_controller.dart';

import '../../../config/app_color.dart';
import '../../../config/common_textfield.dart';

class RecentsearchScreenView extends GetView<ActivityScreenController> {
  RecentsearchScreenView({Key? key}) : super(key: key);
  List proflie = [
    'assets/01.png',
    'assets/location.png',
    'assets/03.png',
    'assets/hastag.png',
  ];
  List title = [
    'M.S Dhoni',
    'Santa Fe, New Mexico.',
    'Alon musk',
    '#taylorswiftfans',
  ];
  List subtitle = [
    'Taylor Swift',
    'Official Fans',
    'Anysong Taylor Swift',
    '10.2K Followers',
  ];
  List text = [
    'Gaming',
    'Cosplayer',
    'Imlek',
    'Fotography',
    'Gong Xie',
    'Art',
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
           title: const Text('History Search', style: TextStyle(fontSize: 18, color: Colors.black),),
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
           children: [
             Padding(
               padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
               child: textfield1(text: 'Search..', text1: 'Search'),
             ),

             const ListTile(
               leading: Text('Recent Search', style: TextStyle(fontSize: 18, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600)),
               trailing: Text('Clear All', style: TextStyle(fontSize: 12, color: AppColor.purple, fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w500)),
             ),
             ListView.builder(
               physics: const NeverScrollableScrollPhysics(),
               scrollDirection: Axis.vertical,
               shrinkWrap: true,
               itemCount: 4,
               itemBuilder: (context, index) {
                 return Column(
                   children: [
                     ListTile(
                       leading: SizedBox(
                         height: 56,
                         width: 56,
                         child: CircleAvatar(backgroundImage: AssetImage(proflie[index])),
                       ),
                       title: Text(title[index], style: const TextStyle(fontSize: 16, fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w500)),
                       subtitle: Text(subtitle[index], style: const TextStyle(fontSize: 12, color: Color(0xff64748B), fontFamily: 'Urbanist-regular', fontWeight: FontWeight.w400)),
                       trailing: const Icon(Icons.close),
                     ),
                     Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                       child: index == 3 ? const SizedBox() : const Divider(
                         height: 1,
                         thickness: 1,
                         color: Color(0xffE2E8F0),
                       ),
                     ),
                   ],
                 );
               },),

             const SizedBox(height: 20,),
             const ListTile(
               leading: Text('Most Searched', style: TextStyle(fontSize: 18, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600)),
               trailing: Text('Clear All', style: TextStyle(fontSize: 12, color: AppColor.purple, fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w500)),
             ),
             Expanded(
               child: GridView.builder(
                 physics: const NeverScrollableScrollPhysics(),
                 gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 165, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 4),
                 itemCount: 6,
                 itemBuilder: (context, index) {
                   return GestureDetector(
                     onTap: () {},
                     child: Padding(padding: const EdgeInsets.only(left: 8, right: 8),
                       child: Container(
                         height: 48,
                         width: MediaQuery.of(context).size.width,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(100),
                           border: Border.all(color: const Color(0xffE2E8F0)),
                         ),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             const SizedBox(width: 10),
                             Text(text[index], style: const TextStyle(fontSize: 12, color: AppColor.purple, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600)),
                           ],
                         ),
                       ),
                     ),
                   );
                 },
               ),
             ),
           ],
         ),
       );
     },
   );
  }
}