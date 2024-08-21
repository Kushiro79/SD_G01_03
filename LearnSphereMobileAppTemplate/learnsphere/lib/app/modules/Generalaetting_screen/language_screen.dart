import 'package:flutter/material.dart';
import 'package:sociogram/config/app_color.dart';

import '../../../config/common_textfield.dart';

class LangyageScreen extends StatefulWidget {
  const LangyageScreen({super.key});

  @override
  State<LangyageScreen> createState() => _LangyageScreenState();
}

class _LangyageScreenState extends State<LangyageScreen> {
  // ignore: prefer_typing_uninitialized_variables
  var _character;
  List img = [
    'assets/Country1.png',
    'assets/Country2.png',
    'assets/Country3.png',
    'assets/Country4.png',
    'assets/Country5.png',
    'assets/Country6.png',
    'assets/Country7.png',
    'assets/Country8.png',
  ];
  List text = [
    'English (US)',
    'English (GBR)',
    'France (FR)',
    'Spain (ES)',
    'Italy (IT)',
    'Singapore (SG)',
    'Netherlands (NT)',
    'canada (CA)',
  ];
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back, color: Colors.black,),
            ),
            title: const Text('Change Language', style: TextStyle(fontSize: 18, color: Colors.black, fontFamily: 'Urbanist-semibold'),),
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
                  leading: Text('Select Language', style: TextStyle(fontSize: 18, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600),),
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: img.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Image.asset(img[index], height: 24, width: 24,),
                      title: Text(text[index], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Urbanist-medium'),),
                      trailing: Radio(
                        activeColor: AppColor.purple,
                        value: text[index],
                        groupValue: _character,
                        onChanged: (value) {
                          setState(() {
                            _character = value;
                          });
                        },),
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

