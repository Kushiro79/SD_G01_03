import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociogram/app/modules/shop_screen/controllers/shop_screen_controller.dart';
import 'package:sociogram/app/modules/shop_screen/views/detail_screen.dart';

import '../../../../config/app_contents.dart';

class SearchScreenView extends StatefulWidget {
  const SearchScreenView({super.key});

  @override
  State<SearchScreenView> createState() => _SearchScreenViewState();
}

class _SearchScreenViewState extends State<SearchScreenView> {
TextEditingController textEditingController = TextEditingController();
  List recent = [
    'Cosmetics',
    'Baseball cap',
  ];
  List text = [
    'Pants',
    'Dress',
    'Clothing',
    'Blouse',
    'Jersey',
    'Apparel',
  ];
  List img = [
    'assets/sale1.png',
    'assets/soffty2..png',
  ];
  List title = [
    'Taylour Perfum..',
    'Taylour Perfum..',
    'Soffty Parfume',
    'Eastside Golf',
  ];
  List subtitle = [
    '\$24,99',
    '\$23,99',
    '\$49,99',
    '\$59,99',
  ];
  List sale = [
    'assets/tshirt.png',
    'assets/soffty1.png',
    'assets/tshirt3.png',
    'assets/soffty.png',
  ];
  List saletitle = [
    'Dallas Mavericks...',
    'Los Angels Edition',
    'Nike NBA Shirt',
    'Nike NBA Sleeve',
  ];
  List saleprice = [
    '\$119,99',
    '\$119,99',
    '\$129,99',
    '\$119.99',
  ];
  List saleprice1 = [
    '\$189.00',
    '\$189.00',
    '\$139.00',
    '\$189.00',
  ];
  List discount = [
    'New',
    'Special',
    '-10 %',
    '-10 %',
  ];
  List<Color> colors = [
    const Color(0xff0153FF),
    const Color(0xffE1B600),
    const Color(0xffFF4D2D),
    const Color(0xffFF4D2D),
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
            body: SizedBox(
              height: Get.size.height,
              width: Get.size.width,
              child: SingleChildScrollView(
                child: GetBuilder<ShopScreenController>(
                    builder: (context) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Searchbar
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(
                              height: 56,
                              width: 327,
                              color: Colors.white,
                              child: TextField(
                                controller: textEditingController,
                                onSubmitted: (value) {
                                  setState(() {});
                                },
                                style: const TextStyle(color: Colors.grey, fontSize: 16, fontFamily: 'Urbanist-medium'),
                                decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Image.asset('assets/search.png',height: 20,width: 20,),
                                  ),
                                  hintText: 'Search...',hintStyle: const TextStyle(color: Colors.grey, fontFamily: 'Urbanist-medium', fontSize: 16),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(35),
                                    borderSide:  const BorderSide(color: Colors.white),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(35),
                                      borderSide:  const BorderSide(color: Colors.white)),
                                ),
                              ),
                            ),
                          ),
                          // Searchbar filter
                          textEditingController.text == ""? Column(
                            children: [
                              const ListTile(
                                leading: Text('Recent Search', style: TextStyle(fontSize: 18, fontFamily: 'Urbanist-semibold'),),
                                trailing: Text('Clear All', style: TextStyle(fontSize: 12, fontFamily: 'Urbanist-medium', color: Color(0xff3BBAA6)),),
                              ),

                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: recent.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: Image.asset(Appcontent.clock),
                                    ),
                                    title: Text(recent[index], style: const TextStyle(fontSize: 16, fontFamily: 'Urbanist-regular')),
                                    trailing: const Icon(Icons.close),
                                  );
                                },),

                              const ListTile(
                                leading: Text('Trending Search', style: TextStyle(fontSize: 18, fontFamily: 'Urbanist-semibold'),),
                                trailing: Text('Clear All', style: TextStyle(fontSize: 12, fontFamily: 'Urbanist-medium', color: Color(0xff3BBAA6)),),
                              ),

                              GridView.builder(
                                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 165, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 4),
                                itemCount: text.length,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Padding(padding: const EdgeInsets.only(left: 8, right: 8),
                                    child: Container(
                                      height: 48,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),
                                        border: Border.all(color: const Color(0xffE2E8F0)),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(text[index], style: const TextStyle(fontSize: 12, color: Color(0xff3BBAA6), fontFamily: 'Urbanist-semibold')),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                              const ListTile(
                                leading: Text('Popular Search', style: TextStyle(fontSize: 18, fontFamily: 'Urbanist-semibold'),),
                                trailing: Text('Clear All', style: TextStyle(fontSize: 12, fontFamily: 'Urbanist-medium', color: Color(0xff3BBAA6)),),
                              ),

                              GridView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: img.length,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 15),
                                itemBuilder: (context, index) {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 15),
                                        child: Image.asset(img[index], height: 140,),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 15),
                                          child: Row(
                                            children: [
                                              Text(title[index], style: const TextStyle(fontSize: 16, color: Colors.black, fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w500),),
                                              const Expanded(child: SizedBox(width: 10,)),
                                              Image.asset('assets/archive-add.png', height: 24, width: 24,),
                                              const SizedBox(width: 5,),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 15),
                                          child: Row(
                                            children: [
                                              Text(subtitle[index], style: const TextStyle(fontSize: 14, color: Color(0xff3BBAA6), fontFamily: 'Urbanist-bold', fontWeight: FontWeight.w500),),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ) : Column(
                            children: [
                              ListTile(
                                leading: const Text('32 Results', style: TextStyle(fontSize: 18, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600),),
                                trailing: Image.asset('assets/setting-4.png', height: 24, width: 24,),
                              ),
                              SizedBox(
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: sale.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 15, bottom: 15),
                                      child: GestureDetector(
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
                                                    width: 57,
                                                    decoration: BoxDecoration(
                                                      color: colors[index],
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                    child: Center(child: Text(discount[index], style: const TextStyle(fontSize: 12, fontFamily: 'Urbanist-semibold', color: Colors.white),)),
                                                  ),
                                                  const SizedBox(height: 5,),
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
                                                child: Image.asset('assets/archive-add.png', color: Colors.grey,)),
                                            const SizedBox(width: 15,),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                ),
              ),
            ),
          );
        },
    );
  }
}
