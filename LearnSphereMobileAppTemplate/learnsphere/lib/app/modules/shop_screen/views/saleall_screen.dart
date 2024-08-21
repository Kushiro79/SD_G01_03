import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociogram/app/modules/shop_screen/controllers/shop_screen_controller.dart';
import 'package:sociogram/app/modules/shop_screen/views/detail_screen.dart';

// ignore: must_be_immutable
class SaleallScreenView extends GetView<ShopScreenController>{
  SaleallScreenView({Key? key}) : super(key: key);
  ShopScreenController shopScreenController = Get.put(ShopScreenController());

  @override
  Widget build(BuildContext context) {
    List sale = [
      'assets/sale1.png',
      'assets/sale2.png',
      'assets/soffty2..png',
      'assets/sale1.png',
      'assets/soffty.png',
      'assets/soffty1.png',
    ];
    List saletitle = [
      'Red Nike Shoes',
      'Nike Shoes',
      'Nike uio',
      'Red Nike Shoes',
      'Nike',
      'Nike Golf',
    ];
    List saleprice = [
      '\$119,99',
      '\$129,99',
      '\$24,99',
      '\$23,99',
      '\$49,99',
      '\$59,99',
    ];
    List saleprice1 = [
      '\$189.00',
      '\$169.00',
      '\$60.00',
      '\$100.00',
      '\$100.00',
      '\$120.00',
    ];
    List discount = [
      '-10 %',
      '-10 %',
      '-15 %',
      '-40 %',
      '-25 %',
      '-70 %',
    ];
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => const DetailScreenView(),));
              },
              child: Column(
                children: [
                  SizedBox(
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: sale.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 15, bottom: 15),
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
                                      child: Center(child: Text(discount[index], style: const TextStyle(fontSize: 12, fontFamily: 'Urbanist-semibold', color: Colors.white),)),
                                    ),
                                    const SizedBox(height: 10,),
                                    Text(saletitle[index], style: const TextStyle(fontSize: 16, fontFamily: 'Urbanist-medium'), overflow: TextOverflow.ellipsis,),
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
                                  child: Image.asset('assets/archive-add.png', color: Colors.grey,)),
                              const SizedBox(width: 10,),
                            ],
                          ),
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