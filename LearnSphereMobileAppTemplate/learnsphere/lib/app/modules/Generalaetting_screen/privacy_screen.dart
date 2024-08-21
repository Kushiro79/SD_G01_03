import 'package:flutter/material.dart';

import '../../../config/app_color.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({super.key});

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {

  List text = [
    'Learn more about privacy policy.',
    'What products does this policy cover?',
    'What do we collect about you?',
    'Why the policy was implemented?',
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
            title: const Text('Privacy Policy', style: TextStyle(fontSize: 18, color: Colors.black, fontFamily: 'Urbanist-semibold'),),
            centerTitle: true,
            actions: const [
              Icon(Icons.menu, color: Colors.black,),
              SizedBox(width: 15,),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 257,
                  width: MediaQuery.of(context).size.width,
                  color: AppColor.purple,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20,),
                        const Text('Last Updated : 12 Jan 2023', style: TextStyle(fontSize: 14, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600, color: Color(0xffF8F9FD)),),
                        const SizedBox(height: 20,),
                        const Text('Privacy Policy Sociogram.', style: TextStyle(fontSize: 24, fontFamily: 'Urbanist', fontWeight: FontWeight.w700, color: Color(0xffF8F9FD)),),
                        const SizedBox(height: 20,),
                        const Text("Privacy policy is a page that contains statements\nto provide information about the system or how it\nworks. We don't sell any of your information.", style: TextStyle(fontSize: 14, fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w500, color: Color(0xffF8F9FD)),),

                        const SizedBox(height: 25,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 44,
                              width: 157,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: Colors.white)
                              ),
                              child: OutlinedButton(
                                onPressed: () {},
                                child: const Text('About Us', style: TextStyle(fontSize: 14, color: Colors.white, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600),),
                              ),
                            ),
                            const SizedBox(width: 15,),
                            SizedBox(
                              height: 44,
                              width: 157,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.white,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                                child: const Text('Learn More', style: TextStyle(fontSize: 14, color: AppColor.purple, fontFamily: 'Urbanist', fontWeight: FontWeight.w700),),
                              ),
                            ),
                          ],
                        ),
                        const Expanded(child: SizedBox(height: 10,)),
                      ],
                    ),
                  ),
                ),
                const ListTile(
                  leading: Text('What is Privacy Policy?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Urbanist-semibold'),),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: RichText(text: const TextSpan(
                    children: [
                      TextSpan(text: 'A privacy policy is a legal statement or document\nthat discloses some or all of the ways in which a\nparty collects, uses, discloses and manages\ncustomer or client data.... ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'Urbanist-regular', color: Color(0xff64748B)),),
                      TextSpan(text: 'Learn More.', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'Urbanist-regular', color: AppColor.purple),),
                    ]
                  )),
                ),

                const SizedBox(height: 15,),
                const ListTile(
                  leading: Text('How Can We Help You ?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Urbanist-semibold'),),
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: text.length,
                  itemBuilder: (context, index) {
                    return ExpansionTile(
                      onExpansionChanged: (value) {
                        setState(() {
                        });
                      },
                      title: Text(text[index], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Urbanist-medium'),),
                      // trailing: _customTileExpanded ? const Icon(Icons.remove) : const Icon(Icons.add),
                      children: const [
                        ListTile(title: Text('This is tile number 1', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Urbanist-medium'),)),
                      ],
                    );
                },)
              ],
            ),
          ),
        );
      },
    );
  }
}