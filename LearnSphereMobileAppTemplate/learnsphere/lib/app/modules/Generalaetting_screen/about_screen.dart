import 'package:flutter/material.dart';

import '../../../config/app_color.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    List img1 = [
      'assets/security-time.png',
      'assets/security-user.png',
    ];
    List text1 = [
      'All Security',
      'Your World.',
    ];
    List subtext = [
      'By using our services, you will get a\nguarantee of data security for life.',
      'You can find your friends all over the\nworld just by using our service.',
    ];
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
            title: const Text('About Sociogram', style: TextStyle(fontSize: 18, color: Colors.black, fontFamily: 'Urbanist-semibold'),),
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
                        const Text('Stay Connected Anywhere\nAnytime.', style: TextStyle(fontSize: 24, fontFamily: 'Urbanist', fontWeight: FontWeight.w700, color: Color(0xffF8F9FD)),),
                        const SizedBox(height: 20,),
                        const Text("We are a service provider in the form of a social\nmedia application by sharing free photos and\nvideos available on iPhone and Android.", style: TextStyle(fontSize: 14, fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w500, color: Color(0xffF8F9FD)),),

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
                                child: const Text('Learn More', style: TextStyle(fontSize: 14, color: Colors.white, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600),),
                              ),
                            ),
                            const SizedBox(width: 15,),
                            SizedBox(
                              height: 44,
                              width: 157,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.white,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                                child: const Text('Get Started', style: TextStyle(fontSize: 14, color: AppColor.purple, fontFamily: 'Urbanist', fontWeight: FontWeight.w700),),
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
                  leading: Text('What You Can Do?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Urbanist-semibold'),),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: RichText(text: const TextSpan(
                      children: [
                        TextSpan(text: "Lorem Ipsum is simply dummy text of the printing and\ntypesetting industry. Lorem Ipsum has been the industry's\nstandard dummy text ever since the 1500s, when an unknown\nprinter took a galley of type and scrambled it to make a type\nspecimen book.\n\n", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'Urbanist-regular', color: Color(0xff64748B)),),
                        TextSpan(text: "Lorem Ipsum is simply dummy text of the printing and\ntypesetting industry.", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'Urbanist-regular', color: Color(0xff64748B)),),
                      ]
                  )),
                ),

                const SizedBox(height: 30,),
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
                        child: ExpansionTile(
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
                          title: Text(text1[index], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Urbanist-medium'),),
                          subtitle:  Text(subtext[index], style: const TextStyle(fontSize: 14, fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w500, color: Color(0xff64748B),),),
                          children: [
                            ListTile(title: Text(subtext[index], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Urbanist-medium'),)),
                          ],
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
