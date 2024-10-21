import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.15,
                height: double.infinity,
                child: const ColoredBox(
                  color: AppColor.Secondary,
                  child: _NavigationMenu(),
                ),
              ),
              const Expanded(
                child: ColoredBox(
                  color:AppColor.Secondary,
                  child: Column(
                    children: [
                      _AppBar(),
                      Expanded(child: AutoRouter()),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Divider(
              color: Palette.lightBlueGrey38,
              thickness: 1,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}