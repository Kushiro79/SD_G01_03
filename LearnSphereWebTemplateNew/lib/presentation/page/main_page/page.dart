import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../routes/app_router.dart';
import '../../theme/gen/assets.gen.dart';
import '../../theme/palette.dart';
import '../../config/app_color.dart';
import '../../theme/text_styles.dart';
import '../../utils/color_extension.dart';
import '../view_and_user_management_page/view/view_and_user_management.dart';

part 'components/appbar.dart';
part 'components/navigation_menu.dart';

@RoutePage()
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(
                width: 220,
                height: double.infinity,
                child: ColoredBox(
                  color: AppColor.purple,
                  child: _NavigationMenu(),
                ),
              ),
              Expanded(
                child: ColoredBox(
                  color: Palette.dirtyWhite,
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
          Positioned(
            top: 80,
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

