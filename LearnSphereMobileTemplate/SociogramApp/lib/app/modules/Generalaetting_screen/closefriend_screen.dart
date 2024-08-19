import 'package:flutter/material.dart';
import 'package:sociogram/config/common_button.dart';

import '../../../config/common_textfield.dart';

class ClosefriendScreen extends StatefulWidget {
  const ClosefriendScreen({super.key});

  @override
  State<ClosefriendScreen> createState() => _ClosefriendScreenState();
}

class _ClosefriendScreenState extends State<ClosefriendScreen> {
  @override
  Widget build(BuildContext context) {
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
        title: const Text('Close Friends', style: TextStyle(fontSize: 18, color: Colors.black, fontFamily: 'Urbanist-semibold'),),
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
          const SizedBox(height: 50,),
          Center(child: Image.asset('assets/closefriends.png', height: 120, width: 120,)),
          const SizedBox(height: 20,),
          const Center(child: Text('Close Friends', style: TextStyle(fontSize: 18, color: Colors.black, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600),)),
          const Center(child: Text('You can choose to share stories with just\n                   the people you select.', style: TextStyle(fontSize: 14, color: Color(0xff64748B), fontFamily: 'Urbanist-regular', fontWeight: FontWeight.w400),)),

          const Expanded(child: SizedBox(height: 350,)),
          Center(child: elevated(text: 'Done', onPress: () {},)),
          const SizedBox(height: 20,),
        ],
      ),
    );
  }
}
