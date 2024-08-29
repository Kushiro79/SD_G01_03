import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociogram/app/modules/shop_screen/views/detail_screen.dart';
import 'package:sociogram/app/modules/shop_screen/views/saleall_screen.dart';
import 'package:sociogram/app/modules/shop_screen/views/viewall_screen.dart';
import 'package:sociogram/config/common_textfield.dart';

import '../../../../config/app_color.dart';
import '../controllers/shop_screen_controller.dart';

// ignore: must_be_immutable
class ShopScreenView extends GetView<ShopScreenController> {
  ShopScreenView({Key? key}) : super(key: key);
  ShopScreenController shopScreenController = Get.put(ShopScreenController());
  @override
  Widget build(BuildContext context) {
    List text = [
      'All',
      'Fashion',
      'Electronic',
      'Sport',
    ];
    List img = [
      'assets/soffty.png',
      'assets/soffty1.png',
    ];
    List title = [
      'Nike',
      'Nike Airbones',
    ];
    List subtitle = [
      '\$49,99',
      '\$59,99',
    ];
    List subtitle1 = [
      '\$100.00',
      '\$120.00',
    ];
    List sale = [
      'assets/sale2.png',
      'assets/sale1.png',
      'assets/sale2.png',
      'assets/sale1.png',
    ];
    List saletitle = [
      'Nike Shoes',
      'Red Nike Shoes',
      'Nike Shoes',
      'Red Nike Shoes',
    ];
    List saleprice = [
      '\$119,99',
      '\$129,99',
      '\$119,99',
      '\$129,99',
    ];
    List saleprice1 = [
      '\$189.00',
      '\$169.00',
      '\$189.00',
      '\$169.00',
    ];
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back, color: Colors.black,),
            ),
            title: const Text('Marketplace', style: TextStyle(fontSize: 18, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600, color: Colors.black),),
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
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Searchbar
                General(text: 'Search..'),
                const SizedBox(height: 20,),
                GetBuilder<ShopScreenController>(
                  builder: (controller) => SizedBox(
                    height: 44,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: text.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            shopScreenController.selected.value = index;
                            shopScreenController.changevalue(value: index);
                          },
                          child: Container(
                            width: 90,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(color: shopScreenController.selected.value == index ? AppColor.purple : Colors.white,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: shopScreenController.selectindex.contains(index) ? AppColor.purple : const Color(0xffE2E8F0)),
                            ),
                            child: Center(
                              child: Text(text[index], style: TextStyle(fontSize: 14, color: shopScreenController.selected.value == index ? Colors.white : AppColor.purple, fontFamily: 'Urbanist-bold')),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                ListTile(
                  leading: const Text('Recommendations', style: TextStyle(fontSize: 18, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600),),
                  trailing: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ViewallScreenView(),));
                    },
                      child: const Text('View All', style: TextStyle(fontSize: 12, fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w500, color: AppColor.purple))),
                ),

                // Recommendations
                SizedBox(
                  height: 210,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: img.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisExtent: 500),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const DetailScreenView(),));
                        },
                        child: Column(
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
                                      child: const Center(
                                        child: Text('-50 %', style: TextStyle(fontSize: 12, color: Colors.white, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600),),
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
                                      Text(title[index], style: const TextStyle(fontSize: 16, color: Colors.black, fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w500),overflow: TextOverflow.ellipsis,),
                                      Row(
                                        children: [
                                          Text(subtitle[index], style: const TextStyle(fontSize: 14, color: Color(0xffFF4D2D), fontFamily: 'Urbanist-bold', fontWeight: FontWeight.w500),),
                                          const SizedBox(width: 5,),
                                          Text(subtitle1[index], style: const TextStyle(fontSize: 14, color: Color(0xff64748B), fontFamily: 'Urbanist', fontWeight: FontWeight.w500, decoration: TextDecoration.lineThrough),),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 30,),
                                SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: Image.asset('assets/save.png'),
                                ),
                                const Expanded(child: SizedBox(height: 20,)),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                ListTile(
                  leading: const Text('Falsh Sale', style: TextStyle(fontSize: 18, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600),),
                  trailing: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SaleallScreenView(),));
                    },
                      child: const Text('View All', style: TextStyle(fontSize: 12, fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w500, color: AppColor.purple))),
                ),

                // Falsh Sale
                SizedBox(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: sale.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 15, bottom: 15),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const DetailScreenView(),));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(sale[index], height: 100, width: 100,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 24,
                                        width: 45,
                                        decoration: BoxDecoration(
                                          color: const Color(0xffFF4D2D),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: const Center(child: Text('-10 %', style: TextStyle(fontSize: 12, fontFamily: 'Urbanist-semibold', color: Colors.white),)),
                                      ),
                                      const SizedBox(height: 10,),
                                      Text(saletitle[index], style: const TextStyle(fontSize: 16, fontFamily: 'Urbanist-medium'),),
                                      Row(
                                        children: [
                                          Text(saleprice[index], style: const TextStyle(fontSize: 16, fontFamily: 'Urbanist-bold', color: Color(0xffFF4D2D)),),
                                          const SizedBox(width: 10,),
                                          Text(saleprice1[index], style: const TextStyle(fontSize: 16, fontFamily: 'Urbanist', color: Color(0xff64748B), decoration: TextDecoration.lineThrough),),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const Expanded(child: SizedBox(width: 120,)),
                              SizedBox(
                                  height: 24,
                                  child: Image.asset('assets/archive-add.png',color: Colors.grey,)),
                                const SizedBox(width: 10,),
                              ],
                            ),
                          ),
                        );
                      },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}