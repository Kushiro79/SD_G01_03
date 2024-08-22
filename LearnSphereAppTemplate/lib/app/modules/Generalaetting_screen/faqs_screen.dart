import 'package:flutter/material.dart';

import '../../../config/common_textfield.dart';

class FaqsScreen extends StatefulWidget {
  const FaqsScreen({super.key});

  @override
  State<FaqsScreen> createState() => _FaqsScreenState();
}

class _FaqsScreenState extends State<FaqsScreen> {
  List text = [
    'How to recover hijacked accounts?',
    'How to reset password?',
    'Choosing who can see my stories',
    'What is two-factor authentication?',
    'Who can view my profile?',
    'What payment options are provided?',
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
        title: const Text('FAQ’s', style: TextStyle(fontSize: 18, color: Colors.black, fontFamily: 'Urbanist-semibold'),),
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
              leading: Text('How Can We Help You ?', style: TextStyle(fontSize: 18, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600),),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: text.length,
              itemBuilder: (context, index) {
                return ExpansionTile(
                  title: Text(text[index], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Urbanist-medium'),),
                  children: const [
                    ListTile(title: Text('This is tile number 1', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Urbanist-medium'),)),
                  ],
                );
            },),

            const ListTile(
              leading: Text('Looking For Something Else?', style: TextStyle(fontSize: 18, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600),),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: 1,
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
                              child: Image.asset('assets/invite4.png'),
                            ),
                          ),
                        ],
                      ),
                      title: const Text('Live Chat', style: TextStyle(fontSize: 16, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600),),
                      subtitle: const Text('Tell us about your problems in real time\n24/7 for you.', style: TextStyle(fontSize: 12, color: Color(0xff64748B), fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w500),),
                      trailing: const InkWell(child: Icon(Icons.navigate_next)),
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
