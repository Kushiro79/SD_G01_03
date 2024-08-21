import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociogram/app/modules/shop_screen/controllers/shop_screen_controller.dart';
import 'package:sociogram/app/modules/shop_screen/views/detail_screen.dart';

// ignore: must_be_immutable
class ViewallScreenView extends GetView<ShopScreenController>{
  ViewallScreenView({Key? key}) : super(key: key);
  ShopScreenController shopScreenController = Get.put(ShopScreenController());
  List img = [
    'assets/soffty.png',
    'assets/soffty1.png',
    'assets/sale1.png',
    'assets/sale2.png',
    'assets/soffty.png',
    'assets/soffty1.png',
    'assets/sale1.png',
    'assets/soffty.png',
  ];
  List title = [
    'Soffty Parfume',
    'Eastside Golf',
    'Taylour Perfum..',
    'Taylour Perfum..',
    'Soffty Parfume',
    'Eastside Golf',
    'Eastside Golf',
    'Taylour Perfum..',
  ];
  List subtitle = [
    '\$49,99',
    '\$59,99',
    '\$24,99',
    '\$23,99',
    '\$49,99',
    '\$59,99',
    '\$24,99',
    '\$23,99',
  ];
  List subtitle1 = [
    '\$100.00',
    '\$120.00',
    '\$90.00',
    '\$60.00',
    '\$100.00',
    '\$120.00',
    '\$60.00',
    '\$100.00',
  ];
  List discount = [
    '-50 %',
    '-50 %',
    '-15 %',
    '-40 %',
    '-25 %',
    '-70 %',
    '-15 %',
    '-40 %',
  ];
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back, color: Colors.black,),
            ),
            centerTitle: true,
            title: const Text('View all', style: TextStyle(fontSize: 18, fontFamily: 'Urbanist-semibold', color: Colors.black),),
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
                        child: const Center(
                          child: Text('2', style: TextStyle(fontSize: 10, fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w500, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 15,),
            ],
          ),
          body: SingleChildScrollView(
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const DetailScreenView(),),);
              },
              child: Column(
                children: [
                  SizedBox(
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: img.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 10, mainAxisExtent: 200),
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Stack(
                                children: [
                                  Image.asset(img[index], height: 140,),
                                  Positioned(
                                    left: 10,
                                    top: 10,
                                    child: Container(
                                      height: 24,
                                      width: 48,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: const Color(0xffFF4D2D),
                                      ),
                                      child: Center(
                                        child: Text(discount[index], style: const TextStyle(fontSize: 12, color: Colors.white, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600),),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 10,),
                                      Text(title[index], style: const TextStyle(fontSize: 16, color: Colors.black, fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w500),),
                                      Row(
                                        children: [
                                          Text(subtitle[index], style: const TextStyle(fontSize: 14, color: Color(0xffFF4D2D), fontFamily: 'Urbanist-bold', fontWeight: FontWeight.w500),),
                                          const SizedBox(width: 5,),
                                          Text(subtitle1[index], style: const TextStyle(fontSize: 14, color: Color(0xff64748B), fontFamily: 'Urbanist', fontWeight: FontWeight.w500,),),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const Expanded(child: SizedBox(width: 30,)),
                                SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: Image.asset('assets/save.png'),
                                ),
                                const Expanded(child: SizedBox(height: 10,)),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20,),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}