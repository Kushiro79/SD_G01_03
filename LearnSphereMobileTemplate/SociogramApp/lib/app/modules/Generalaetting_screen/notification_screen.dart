import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import '../../../config/app_color.dart';
import '../../../config/common_textfield.dart';

class NotificatonScreen extends StatefulWidget {
  const NotificatonScreen({super.key});

  @override
  State<NotificatonScreen> createState() => _NotificatonScreenState();
}

class _NotificatonScreenState extends State<NotificatonScreen> {
  int selectindex = 0;
  bool light = true;
  var selectWitch = [];
  var selectWitch1 = [];

  List text = [
    'Tag',
    'Comment',
    'Messages',
    'Live & Reels',
    'Following & Followers',
  ];
  List text1 = [
    'Email Notification',
    'Shopping',
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
        title: const Text('Push Notifiaction', style: TextStyle(fontSize: 18, color: Colors.black, fontFamily: 'Urbanist-semibold'),),
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
              leading: Text('Push Notification', style: TextStyle(fontSize: 18, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600),),
            ),
            ListTile(
              leading: const Text('Pause All', style: TextStyle(fontSize: 14, fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w500),),
              trailing: GFToggle(
                onChanged: (value) {},
                value: true,
                enabledThumbColor: Colors.white,
                enabledTrackColor: AppColor.purple,
                type: GFToggleType.ios,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: RichText(
                text: const TextSpan(
                    children: [
                      TextSpan(text: 'By agreeing to use this feature, you will not get\nany notifications.  ', style: TextStyle(fontSize: 12, color: Color(0xff64748B), fontWeight: FontWeight.w600, fontFamily: 'Urbanist-regular')),
                      TextSpan(text: 'Learn More', style: TextStyle(fontSize: 12, color: AppColor.purple, fontWeight: FontWeight.w600, fontFamily: 'Urbanist-regular')),
                    ]
                ),
              ),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: text.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text(text[index], style: const TextStyle(fontSize: 14, fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w500),),
                  trailing: GFToggle(
                      onChanged: (value) {},
                      value: true,
                    enabledThumbColor: Colors.white,
                    enabledTrackColor: AppColor.purple,
                    type: GFToggleType.ios,
                  ),
                );
            },),

            const ListTile(
              leading: Text('Other Notification', style: TextStyle(fontSize: 18, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600),),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: text1.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text(text1[index], style: const TextStyle(fontSize: 14, fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w500),),
                  trailing: GFToggle(
                    onChanged: (value) {},
                    value: true,
                    enabledThumbColor: Colors.white,
                    enabledTrackColor: AppColor.purple,
                    type: GFToggleType.ios,
                  ),
                );
              },),
          ],
        ),
      ),
    );
  }
}