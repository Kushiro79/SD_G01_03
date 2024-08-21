import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociogram/app/modules/filter_screen/views/filter_screen_view.dart';
import 'package:sociogram/app/modules/shop_screen/views/detail_screen.dart';
import 'package:sociogram/config/app_contents.dart';
import 'package:sociogram/config/common_textfield.dart';

import '../../../../config/app_color.dart';
import '../controllers/serach_screen_controller.dart';

// ignore: must_be_immutable
class SerachScreenView extends GetView<SerachScreenController> {
  SerachScreenView({Key? key}) : super(key: key);
  SerachScreenController serachScreenController =
      Get.put(SerachScreenController());

  @override
  Widget build(BuildContext context) {

    List text = [
      'All',
      'Popular',
      'Account',
      'Hastag',
      'Post',
      'Sound',
      'Shop',
      'Live',
    ];

    List text1 = [
      'Gaming',
      'Cosplayer',
      'Imlek',
      'Fotography',
      'Gong Xie',
      'Art',
    ];

    List img = [
      Appcontent.popular1,
      Appcontent.popular2,
      Appcontent.popular3,
      Appcontent.popular4,
      Appcontent.popular5,
      Appcontent.popular6,
      Appcontent.popular4,
      Appcontent.popular3,
    ];

    List proflie = [
      'assets/02.png',
      'assets/03.png',
      'assets/04.png',
      'assets/05.png',
      'assets/03.png',
    ];

    List history = [
      'UX Design   ',
      'Bessie Coop',
      'Adam Malik',
    ];

    List title = [
      'Virat Kohli',
      'M.S. Dhoni',
      'Alon musk',
      'Popatlal',
      'Khan Ali',
    ];
    List subtitle = [
      'Taylor Swift',
      'Official Fans',
      'Anysong Taylor Swift',
      'Taylor Swift Videos',
      'Taylor Swift The Era Tour',
    ];

    List title1 = [
      '#Virat Kohli',
      '#M.S. Dhoni',
      '#Alon musk',
      '#Popatlal',
      '#Khan Ali',
    ];
    List subtitle1 = [
      '12.7K Followers',
      '10.3K Followers',
      '10.2K Followers',
      '8.7K Followers',
      '8.5K Followers',
    ];

    List stext = [
      'Love Story',
      'Shake It Off',
      'Style',
      'Gorgeous',
    ];
    List sutext = [
      '01:20',
      '01:23',
      '01:02',
      '01:12',
    ];

    List shop = [
      'assets/soffty.png',
      'assets/soffty1.png',
      'assets/sale1.png',
      'assets/sale2.png',
      'assets/tshirt3.png',
      'assets/tshirt.png',
    ];
    List shtext = [
      'Nike Shoes',
      'Jordan',
      'Nike Shoes',
      'Nike Ayolr',
      'Jordan vigno',
      'Jordan',
    ];
    List subtext = [
      '19.99  ',
      '23.99',
      '24.99',
      '37.99  ',
      '23.99  ',
      '24.99',
    ];
    List subtext1 = [
      '\$39.00',
      '',
      '',
      '\$67.00',
      '\$57.99',
      '',
    ];

    List frame = [
      'assets/Frame.png',
      'assets/Frame1.png',
    ];
    List play = [
      '01:12',
      '01:32',
    ];
    List disco = [
      '-20%',
      '-25%',
      '-45%',
      '-15%',
      '-50%',
      '-50%',
    ];
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back, color: Colors.black),
            ),
            centerTitle: true,
            title: const Text('Search',
                style: TextStyle(fontSize: 18, color: Colors.black)),
            actions: [
              SizedBox(
                height: 24,
                width: 24,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FilterScreenView()));
                  },
                  child: Image.asset(Appcontent.setting, color: Colors.black),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
            ],
          ),
          body: SafeArea(
            child: SizedBox(
              height: Get.size.height,
              width: Get.size.width,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
                  child: Column(
                    children: [
                      General(text: 'Search...'),
                      const SizedBox(height: 30),
                      GetBuilder<SerachScreenController>(
                        builder: (controller) => SizedBox(
                          height: 44,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 8,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  serachScreenController.selected.value = index;
                                  serachScreenController.changeCatWiseIndex(index: index);
                                },
                                child: Obx(
                                  () => Container(
                                    height: 44,
                                    width: 80,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    decoration: BoxDecoration(
                                      color: serachScreenController
                                                  .selected.value ==
                                              index
                                          ? AppColor.purple
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                          color: serachScreenController
                                                  .selectIndex
                                                  .contains(index)
                                              ? Colors.white
                                              : AppColor.purple),
                                    ),
                                    child: Center(
                                      child: Text(text[index],
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: serachScreenController
                                                          .selected.value ==
                                                      index
                                                  ? Colors.white
                                                  : AppColor.purple,
                                              fontFamily: 'Urbanist-bold',
                                              fontWeight: FontWeight.w700)),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      GetBuilder<SerachScreenController>(
                        builder: (controller) {
                          return Column(
                            children: [
                              serachScreenController.currentIndex == 0 ? SizedBox(
                                      height: 600,
                                      width: double.infinity,
                                      child: Column(
                                        children: [
                                          const ListTile(
                                            leading: Text('Recent Search', style: TextStyle(fontSize: 18, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600)),
                                            trailing: Text('Clear All', style: TextStyle(fontSize: 12, color: AppColor.purple, fontWeight: FontWeight.w500, fontFamily: 'Urbanist-medium')),
                                          ),
                                          ListView.builder(
                                            physics: const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemCount: history.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(left: 10, bottom: 20),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      height: 20,
                                                      width: 20,
                                                      child: Image.asset(Appcontent.clock),
                                                    ),
                                                    const SizedBox(
                                                      width: 20,
                                                    ),
                                                    Text(history[index], style: const TextStyle(fontSize: 16, fontFamily: 'Urbanist-regular', fontWeight: FontWeight.w400)),
                                                    const Expanded(child: SizedBox(width: 210,)),
                                                    const Icon(Icons.close, size: 18,),
                                                    const SizedBox(width: 10,),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                          const ListTile(
                                            leading: Text('Trending Search', style: TextStyle(fontSize: 18, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600)),
                                            trailing: Text('Clear All', style: TextStyle(fontSize: 12, color: AppColor.purple, fontWeight: FontWeight.w500, fontFamily: 'Urbanist-medium')),
                                          ),
                                          Expanded(
                                            child: GridView.builder(
                                              physics: const NeverScrollableScrollPhysics(),
                                              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 165, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 4),
                                              itemCount: text1.length,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding: const EdgeInsets.only(left: 8, right: 8),
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
                                                        const SizedBox(width: 10),
                                                        Text(text1[index], style: const TextStyle(fontSize: 14, color: AppColor.purple, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600)),
                                                      ]
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ) : serachScreenController.currentIndex == 1 ? GridView.builder(
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  crossAxisSpacing: 10),
                                          itemCount: img.length,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return Container(
                                              color: Colors.white,
                                              child: Image.asset(img[index]),
                                            );
                                          },
                                        ) : serachScreenController.currentIndex == 2 ? ListView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              scrollDirection: Axis.vertical,
                                              shrinkWrap: true,
                                              itemCount: proflie.length,
                                              itemBuilder: (context, index) {
                                                return ListTile(
                                                  leading: SizedBox(
                                                    height: 56,
                                                    width: 56,
                                                    child: CircleAvatar(
                                                        backgroundImage:
                                                            AssetImage(proflie[
                                                                index])),
                                                  ),
                                                  title: Text(title[index],
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          fontFamily:
                                                              'Urbanist-medium',
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                  subtitle: Text(
                                                      subtitle[index],
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          color:
                                                              Color(0xff64748B),
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily:
                                                              'Urbanist-regular')),
                                                );
                                              },
                                            ) : serachScreenController.currentIndex == 3 ? ListView.builder(
                                                  physics: const NeverScrollableScrollPhysics(),
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  shrinkWrap: true,
                                                  itemCount: 5,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return ListTile(
                                                      leading: const SizedBox(
                                                        height: 48,
                                                        width: 48,
                                                        child: CircleAvatar(
                                                            backgroundImage:
                                                                AssetImage(
                                                                    'assets/hastag.png')),
                                                      ),
                                                      title: Text(title1[index],
                                                          style:
                                                              const TextStyle(
                                                                  fontSize:
                                                                      16)),
                                                      subtitle: Text(
                                                          subtitle1[index],
                                                          style: const TextStyle(
                                                              fontSize: 12,
                                                              color: Color(
                                                                  0xff64748B))),
                                                    );
                                                  },
                                                ) : serachScreenController.currentIndex == 4 ? GridView.builder(
                                                      gridDelegate:
                                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                                              crossAxisCount: 2,
                                                              crossAxisSpacing:
                                                                  10),
                                                      itemCount: img.length,
                                                      shrinkWrap: true,
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Container(
                                                          color: Colors.white,
                                                          child: Image.asset(
                                                              img[index]),
                                                        );
                                                      },
                                                    ) : serachScreenController.currentIndex == 5 ? ListView.builder(
                                                          physics: const NeverScrollableScrollPhysics(),
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          shrinkWrap: true,
                                                          itemCount: 4,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return ListTile(
                                                              leading: Stack(
                                                                children: [
                                                                  SizedBox(
                                                                    height: 56,
                                                                    width: 56,
                                                                    child: CircleAvatar(
                                                                        backgroundImage:
                                                                            AssetImage(proflie[index])),
                                                                  ),
                                                                  Positioned(
                                                                    left: 0,
                                                                    right: 0,
                                                                    top: 0,
                                                                    bottom: 0,
                                                                    child: SizedBox(
                                                                        height:
                                                                            25,
                                                                        width:
                                                                            25,
                                                                        child: Center(
                                                                            child: Image.asset('assets/play1.png',
                                                                                height: 20,
                                                                                width: 20))),
                                                                  ),
                                                                ],
                                                              ),
                                                              title: Text(
                                                                  stext[index],
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          16)),
                                                              subtitle: const Text(
                                                                  'Created By : Talyor Swift',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Color(
                                                                          0xff64748B))),
                                                              trailing: Text(
                                                                  sutext[index],
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Color(
                                                                          0xff64748B))),
                                                            );
                                                          },
                                                        ) : serachScreenController.currentIndex == 6 ? GridView.builder(
                                                              gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisExtent: 240),
                                                              scrollDirection: Axis.vertical,
                                                              shrinkWrap: true,
                                                              physics: const NeverScrollableScrollPhysics(),
                                                              itemCount: 6,
                                                              itemBuilder: (context, index) {
                                                                return InkWell(
                                                                  onTap: () {
                                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const DetailScreenView(),),);
                                                                  },
                                                                  child: Container(
                                                                    margin: const EdgeInsets.all(6),
                                                                    child: Column(
                                                                      children: [
                                                                        Stack(
                                                                          children: [
                                                                            Image.asset(shop[index]),
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
                                                                                  child: Text(disco[index], style: const TextStyle(fontWeight: FontWeight.w600, fontFamily: 'Urbanist-semibold', fontSize: 12, color: Colors.white),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                const SizedBox(height: 10,),
                                                                                Text(shtext[index], style: const TextStyle(fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w500, fontSize: 16), overflow: TextOverflow.ellipsis,),
                                                                                Row(
                                                                                  children: [
                                                                                    Text(subtext[index], style: const TextStyle(color: Color(0xff3BBAA6), fontSize: 14, fontFamily: 'Urbanist-bold', fontWeight: FontWeight.w700)),
                                                                                    Text(subtext1[index], style: const TextStyle(color: Color(0xff64748B), fontSize: 14, fontFamily: 'Urbanist', fontWeight: FontWeight.w400, decoration: TextDecoration.lineThrough)),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            const Expanded(child: SizedBox(width: 40,)),
                                                                            SizedBox(
                                                                              height: 24,
                                                                              width: 24,
                                                                              child: Image.asset('assets/save.png'),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                );
                                                              }) : Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                const SizedBox(height: 30,),
                                                                Image.asset('assets/live.png', height: 120, width: 120,),
                                                                const Text('No Results Found', style: TextStyle(fontSize: 18, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600)),
                                                                const SizedBox(height: 10,),
                                                                const Text('Please make sure it is written correctly.', style: TextStyle(fontSize: 14, color: Color(0xff64748B), fontFamily: 'Urbanist-regular', fontWeight: FontWeight.w400)),
                                                                const SizedBox(height: 20),
                                                                const ListTile(
                                                                  leading: Text('Similiar Live', style: TextStyle(fontSize: 18, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600)),
                                                                  trailing: Text('View All', style: TextStyle(fontSize: 12, color: Color(0xff3BBAA6), fontFamily: 'Urbanist-medium', fontWeight: FontWeight.w500),
                                                                  ),
                                                                ),
                                                                GridView.builder(
                                                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                                                                  scrollDirection: Axis.vertical,
                                                                  physics: const NeverScrollableScrollPhysics(),
                                                                  shrinkWrap: true,
                                                                  itemCount: 2,
                                                                  itemBuilder: (context, index) {
                                                                    return Center(
                                                                      child: Stack(
                                                                        children: [
                                                                          SizedBox(
                                                                            height: 232,
                                                                            width: 157,
                                                                            child: Image.asset(frame[index]),
                                                                          ),
                                                                          Positioned(
                                                                            left: 10,
                                                                            bottom: 10,
                                                                            child: Container(
                                                                              height: 21,
                                                                              width: 51,
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(100),
                                                                                color: Colors.black.withOpacity(0.5),
                                                                              ),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  SizedBox(
                                                                                    height: 10,
                                                                                    child: Image.asset('assets/play.png'),
                                                                                  ),
                                                                                  const SizedBox(width: 5,),
                                                                                  Text(play[index], style: const TextStyle(fontSize: 10, color: Colors.white, fontFamily: 'Urbanist-semibold', fontWeight: FontWeight.w600),),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  },
                                                                )
                                                              ],
                                                            )
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}