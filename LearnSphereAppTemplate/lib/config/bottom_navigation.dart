import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sociogram/app/modules/home/views/home_view.dart';
import 'package:sociogram/app/modules/live_screen/live_screen_view.dart';
import 'package:sociogram/app/modules/proflie_screen/views/proflie_screen_view.dart';
import 'package:sociogram/app/modules/serach_screen/views/serach_screen_view.dart';
import 'package:sociogram/app/modules/shop_screen/views/shop_screen_view.dart';
import 'package:sociogram/config/app_contents.dart';

class Bottom extends StatefulWidget {
  const Bottom({Key? key}) : super(key: key);

  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  List bottom = [
    HomeView(),
    SerachScreenView(),
    ShopScreenView(),
    ProflieScreenView(),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        elevation: 0,
        backgroundColor: const Color(0xff6B4EFF),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const LiveScreenView()));
        },
        child: SizedBox(
          height: 28,
          width: 28,
          child: Image.asset(Appcontent.videoplay),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      extendBody: true,
      bottomNavigationBar: BottomAppBar(
        notchMargin:  5,
        clipBehavior: Clip.antiAlias,
        shape: const CircularNotchedRectangle(),
          child: SizedBox(
            width: double.infinity,
            height: 68,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap:() {
                    setState(() {
                      _selectedIndex = 0;
                    });
                  },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/home.png', height: 24, width: 24, color:  _selectedIndex == 0 ? Colors.black : const Color(0xff94A3B8),),
                        const SizedBox(height: 5,),
                        Text('Home', style: TextStyle(fontSize: 12, color: _selectedIndex==0 ? Colors.black : const Color(0xff94A3B8), fontFamily: 'Urbanist-regular'),)
                      ],
                    )),
                GestureDetector(
                    onTap:() {
                      setState(() {
                        _selectedIndex = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/search.png', height: 24, width: 24, color:  _selectedIndex == 1 ? Colors.black : const Color(0xff94A3B8),),
                        const SizedBox(height: 5,),
                        Text('Search', style: TextStyle(fontSize: 12,color: _selectedIndex==1 ?  Colors.black : const Color(0xff94A3B8), fontFamily: 'Urbanist-regular'),)
                      ],
                    )),
                const SizedBox(width: 10,),
                GestureDetector(
                    onTap:() {
                      setState(() {
                        _selectedIndex = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/shopping-bag.png', height: 24, width: 24, color:  _selectedIndex == 2 ? Colors.black : const Color(0xff94A3B8),),
                        const SizedBox(height: 5,),
                        Text('Shop', style: TextStyle(fontSize: 12, color: _selectedIndex==2 ?  Colors.black : const Color(0xff94A3B8), fontFamily: 'Urbanist-regular'),)
                      ],
                    )),
                GestureDetector(
                    onTap:() {
                      setState(() {
                        _selectedIndex = 3;
                      });

                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/profile.png', height: 24, width: 24, color:  _selectedIndex == 3 ? Colors.black : const Color(0xff94A3B8),),
                        const SizedBox(height: 5,),
                        Text('Profile', style: TextStyle(fontSize: 12, color: _selectedIndex==3 ? Colors.black : const Color(0xff94A3B8), fontFamily: 'Urbanist-regular'),)
                      ],
                    )),
              ],
            ),
          ),
      ),
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: bottom[_selectedIndex],
      ),
    );
  }
}
