import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociogram/app/modules/postdetail_screen/postdetail_screen_controller.dart';
import 'package:sociogram/config/app_color.dart';

class PostdetailScreenView extends GetView<PostdetailScreenController>{
  const PostdetailScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List img = [
      'assets/gallery-add.png',
      'assets/tag-user1.png',
      'assets/location-tick.png',
      'assets/mini-music-sqaure.png',
      'assets/setting1.png',
    ];
    List text = [
      'Gallery',
      'Tag People',
      'Add Location',
      'Add Music',
      'Advance Setting',
    ];
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: InkWell(onTap: () => Navigator.pop(context),child: const Icon(Icons.close, color: Colors.black,)),
            title: const Text('Details Post', style: TextStyle(fontSize: 18, color: Colors.black),),
            centerTitle: true,
            actions: [
              SizedBox(
                  height: 24,
                  width: 24,
                  child: Image.asset('assets/arrow-right.png', color: AppColor.purple)),
              const SizedBox(width: 15,),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Container(
                  height: 64,
                  width: 58,
                    decoration: BoxDecoration(
                        image: const DecorationImage(image: AssetImage('assets/05.png'),fit: BoxFit.fill),
                        borderRadius: BorderRadius.circular(100)),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Williamson', style: TextStyle(fontSize: 16),),
                    const SizedBox(height: 10),
                    Container(
                      height: 33,
                      width: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(width: 2, color: const Color(0xffE2E8F0)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: 16,
                            width: 16,
                            child: Image.asset('assets/profile-2user.png'),
                          ),
                          const Text('Friends', style: TextStyle(fontSize: 14),),
                          SizedBox(
                            height: 16,
                            width: 16,
                            child: Image.asset('assets/arrow-down1.png'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const ListTile(
                leading: Text('What do you want to talk?', style: TextStyle(fontSize: 16, color: Color(0xff64748B)),),
              ),
              const SizedBox(height: 10),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Image.asset('assets/detail.png'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(50),
                                color: Colors.black.withOpacity(0.10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 16,width: 16,child: Image.asset('assets/colorfilter.png')),
                              ],
                            )
                        ),
                        const SizedBox(width: 10),
                        Container(
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(50),
                                color: Colors.black.withOpacity(0.10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 16,width: 16,child: Image.asset('assets/close.png')),
                              ],
                            )
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),
              Expanded(
                child: Container(
                  height: 400,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('Menu', style: TextStyle(fontSize: 16),),
                      const Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(
                          height: 30,
                          thickness: 1,
                          color: Color(0xffE2E8F0),
                        ),
                      ),

                      ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: img.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: SizedBox(
                                height: 20,
                                width: 20,
                                child: Image.asset(img[index])),
                            title: Text(text[index], style: const TextStyle(fontSize: 16)),
                          );
                        },)
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }, 
    );
  }
}