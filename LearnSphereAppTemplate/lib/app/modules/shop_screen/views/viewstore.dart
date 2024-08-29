import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sociogram/app/modules/shop_screen/views/detail_screen.dart';
import 'package:sociogram/config/app_color.dart';
import 'package:sociogram/config/common_button.dart';

class ViewStorescreen extends StatefulWidget {
  const ViewStorescreen({super.key});

  @override
  State<ViewStorescreen> createState() => _ViewStorescreenState();
}

class _ViewStorescreenState extends State<ViewStorescreen> {
  int selectIndex = 0;

  List img1 = [
    'assets/infomation.png',
    'assets/option1.png',
    'assets/Share3.png',
    'assets/Share4.png',
  ];
  List text1 = [
    'Report',
    'Link',
    'Location',
    'Message',
  ];
  List text = [
    'Filter',
    'Best Seller',
    'Pricing',
  ];
  List img = [
    'assets/sale1.png',
    'assets/sale2.png',
  ];
  List title = [
    'Nike Air',
    'Nike Golf',
  ];
  List subtitle = [
    '\$629,99',
    '\$59,99',
  ];
  List subtitle1 = [
    '\$699,00',
    '\$120.00',
  ];
  List discount = [
    '-10 %',
    '-50 %',
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return DefaultTabController(
          length: 3,
          initialIndex: 0,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              title: const Text('View Store', style: TextStyle(fontSize: 18, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600, color: Colors.black),),
              centerTitle: true,
              actions: [
                // Bottom Sheet
                GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                        context: context,
                        builder: (context) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 15,),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Detail Store', style: TextStyle(fontSize: 16, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600),),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                child: Divider(height: 1, thickness: 1, color: Color(0xffE2E8F0),),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                              image: const DecorationImage(image: AssetImage('assets/05.png',),fit: BoxFit.fill),
                                              borderRadius: BorderRadius.circular(100)),
                                        ),
                                        Positioned(
                                          left: 45,
                                          bottom: 0,
                                          child: Container(
                                            height: 16,
                                            width: 16,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(100),
                                              color: const Color(0xff0AD67E),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 10,),
                                    const Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('ASIAN Store', style: TextStyle(fontSize: 14, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600),),
                                        Text('4,4M Followers', style: TextStyle(fontSize: 12, fontFamily: 'Urbanist-regular', fontWeight: FontWeight.w600, color: Color(0xff64748B)),),
                                      ],
                                    ),
                                    const Expanded(child: SizedBox(width: 100,)),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          fixedSize: const Size(83, 32),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)), backgroundColor: AppColor.purple, ),
                                      onPressed: () {},
                                      child: const Text('Follow', style: TextStyle(fontSize: 12, fontFamily: 'Urbanist-bold', fontWeight: FontWeight.w700)),
                                    ),
                                    const SizedBox(width: 20,),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                child: Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: Color(0xffE2E8F0),
                                ),
                              ),
                              GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: img1.length,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,mainAxisExtent: 70),
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Image.asset(img1[index], height: 44, width: 44,),
                                      const SizedBox(height: 10,),
                                      Text(text1[index], style: const TextStyle(fontSize: 12, fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w500),),
                                    ],
                                  );
                                },
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                child: Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: Color(0xffE2E8F0),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text('Desctription', style: TextStyle(fontSize: 16, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600), textAlign: TextAlign.start,),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 20, top: 15),
                                child: Text('Nike,  Inc.  is  an  American  multinational  corporation\nengaged  in  the  worldwide  sale  of  footwear,\napparel,  equipment,  accessories  and  services.  The\ncompany  is  headquartered  near  Beaverton,\nOregon,  in  the  Portland  metropolitan  area.', style: TextStyle(fontSize: 14, fontFamily: 'Urbanist-regular', fontWeight: FontWeight.w400, color: Color(0xff64748B)), textAlign: TextAlign.start,),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Icon(Icons.more_vert, color: Colors.black,)),
                const SizedBox(width: 15,),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20,),
                  Stack(
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            image: const DecorationImage(image: AssetImage('assets/05.png',),fit: BoxFit.fill),
                            borderRadius: BorderRadius.circular(100)),
                      ),
                      Positioned(
                        right: 10,
                        bottom: 0,
                        child: Container(
                          height: 16,
                          width: 16,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: const Color(0xff0AD67E),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15,),
                  const Text('ASIAN Store', style: TextStyle(fontSize: 18, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/location1.png', height: 16,),
                      const Text('  Beaverton US', style: TextStyle(fontSize: 12, fontFamily: 'Urbanist-regular', fontWeight: FontWeight.w400),),
                    ],
                  ),
                  const SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                        width: 90,
                        child: ListTile(
                          title: Row(
                            children: [
                              RatingBar.builder(
                                itemSize: 20,
                                initialRating: 5,
                                minRating: 1,
                                itemCount: 1,
                                itemBuilder: (context, index) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (value) {},
                              ),
                              const Text('4.8', style: TextStyle(fontSize: 18, fontFamily: 'Urbanist-semibold'),),
                            ],
                          ),
                          subtitle: const Text('Rating', style: TextStyle(fontSize: 12, fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w500, color: Color(0xff64748B)),),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                        width: 100,
                        child: ListTile(
                          title: Text('5.467', style: TextStyle(fontSize: 18, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600),),
                          subtitle: Text('Products', style: TextStyle(fontSize: 12, fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w500, color: Color(0xff64748B)),),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                        width: 100,
                        child: ListTile(
                          title: Text('4,4M', style: TextStyle(fontSize: 18, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600),),
                          subtitle: Text('Followers', style: TextStyle(fontSize: 12, fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w500, color: Color(0xff64748B)),),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 60,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      elevated1(text: 'Follow', onPress: () {},),
                      const SizedBox(width: 15,),
                      FloatingActionButton(
                        backgroundColor: const Color(0xff021F31),
                        onPressed: () {},
                        child: Image.asset('assets/message.png', height: 24,),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25,),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TabBar(
                      indicatorColor: AppColor.purple,
                      tabs: <Widget>[
                        Tab(
                          child: Text('Product', style: TextStyle(color: Colors.black, fontFamily: 'Urbanist-medium', fontSize: 16),),
                        ),
                        Tab(child: Text('Category', style: TextStyle(color: Colors.black, fontFamily: 'Urbanist-medium', fontSize: 16),),
                        ),
                        Tab(
                          child: Text('Reviews', style: TextStyle(color: Colors.black, fontFamily: 'Urbanist-medium', fontSize: 16),),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 10),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 44,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: text.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectIndex = index;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      width: 110,
                                      decoration: BoxDecoration(
                                        color: selectIndex == index ? AppColor.purple : Colors.white,
                                        borderRadius: BorderRadius.circular(100),
                                        border: Border.all(color: selectIndex == index ? Colors.white : AppColor.purple),
                                      ),
                                      child: Center(
                                        child: Text(text[index], style: TextStyle(fontSize: 14, color: selectIndex == index ? Colors.white : AppColor.purple, fontFamily: 'Urbanist-bold')),
                                      ),
                                    ),
                                    const SizedBox(width: 10,),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20,),
                        SizedBox(
                          height: 210,
                          child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: img.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisExtent: 240),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const DetailScreenView(),),);
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
                                        const Expanded(child: SizedBox(width: 30,)),
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
