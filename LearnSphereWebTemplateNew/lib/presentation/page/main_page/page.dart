import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

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
                child: ColoredBox(
                  color: AppColor.purple,
                  child: const _NavigationMenu(),
                ),
              ),
              const Expanded(
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
          const Positioned(
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

