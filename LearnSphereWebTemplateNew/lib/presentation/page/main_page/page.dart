import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

import '../profile_page/controllers/edit_profile_controller.dart';
import '../../routes/app_router.dart';
import '../../theme/gen/assets.gen.dart';
import '../../theme/palette.dart';
import '../../config/app_color.dart';
import '../../theme/text_styles.dart';
import '../../utils/color_extension.dart';

part 'components/appbar.dart';
part 'components/navigation_menu.dart';

@RoutePage()
class MainPage extends StatefulWidget  {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _isMenuVisible = false;

  void _toggleMenuVisibility() {
    setState(() {
      _isMenuVisible = !_isMenuVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Row(
            children: <Widget>[
              if (_isMenuVisible)
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.15,
                  height: double.infinity,
                  child: const ColoredBox(
                    color: Color(0xFF1A1F3B),
                    child: _NavigationMenu(),
                  ),
                ),
              Expanded(
                child: ColoredBox(
                  color: Color(0xFF1A1F3B),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              _isMenuVisible ? Icons.arrow_back_ios : Icons.menu,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: _toggleMenuVisibility,
                          ),
                          const SizedBox(width: 10,),
                          const Expanded(child: _AppBar()),
                        ],
                      ),
                      const Expanded(child: AutoRouter()),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}