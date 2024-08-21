import 'package:flutter/material.dart';
import 'package:sociogram/config/common_button.dart';

class DetailScreenView extends StatefulWidget {
  const DetailScreenView({super.key});

  @override
  State<DetailScreenView> createState() => _DetailScreenViewState();
}

class _DetailScreenViewState extends State<DetailScreenView> {
  PageController pageController = PageController();
  int selectIndex = 0;
  int selectIndex1 = 0;

  List<Color> colors = [
    Colors.black,
    const Color(0xff0153FF),
    const Color(0xff94A3B8),
  ];
  List text = [
    '6 UK',
    '8 UK',
    '10 UK',
    '11 UK',
    '12 UK',
  ];
  List review = [
    'Abhishek Prasad',
    'Akhilesh Singh',
  ];
  List review1 = [
    'The material is of high quality, comfortable to wear\nwhen sweating, amazing!',
    'Suitable for keeping your body dry, or warm in humid\nconditions.',
  ];
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back, color: Colors.black,),
          ),
          title: const Text('Detail Product', style: TextStyle(fontSize: 18, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600, color: Colors.black),),
          centerTitle: true,
          actions: [
            Center(
              child: Stack(
                children: [
                  Image.asset('assets/shopping-bag1.png', height: 24, width: 24,),
                  Positioned(
                    left: 11,
                    child: Container(
                      height: 14,
                      width: 14,
                      decoration: BoxDecoration(
                        color: const Color(0xffFF4D2D),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Center(child: Text('2', style: TextStyle(fontSize: 10, fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w500, color: Colors.white),),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 15,),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          height: 96,
          color: Colors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(child: SizedBox(height: 10,)),
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Total Price :', style: TextStyle(fontSize: 14, color: Color(0xff64748B), fontFamily: 'Urbanist-regular'),),
                  Text('\$119,00', style: TextStyle(fontSize: 20, color: Color(0xff0F172A), fontFamily: 'Urbanist'),),
                ],
              ),
              const Expanded(child: SizedBox(width: 80,)),
              product(text: 'BUY NOW', onPress: () {},),
              const SizedBox(width: 15,),
              FloatingActionButton(
                heroTag: null,
                elevation: 0,
                backgroundColor: const Color(0xff021F31),
                onPressed: () {},
                child: Image.asset('assets/shopping-prod.png', height: 24,),
              ),
              const Expanded(child: SizedBox(width: 10,)),
            ],
          ),
        ),

      );
    },);
  }
}