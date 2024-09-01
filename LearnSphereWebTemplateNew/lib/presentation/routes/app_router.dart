import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../page/content_management_page/page.dart';
import '../page/dashboard_page/page.dart';
import '../page/forgot_screen/views/forgot_screen_view.dart';
import '../page/login_screen/views/login_screen_view.dart';
import '../page/main_page/page.dart';
import '../page/register/views/register_view.dart';
import '../page/settings_page/page.dart';
import '../page/user_loyalty_and_rewards_page/user_loyalty_and_rewards_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => <AutoRoute>[
        CustomRoute(
          path: '/main-page',
          page: MainRoute.page,
          durationInMilliseconds: 0,
          reverseDurationInMilliseconds: 1,
          transitionsBuilder: TransitionsBuilders.noTransition,
          children: [
            // Child routes under the main page
            AutoRoute(
              path: 'dashboard',
              page: DashboardRoute.page,
            ),
            AutoRoute(
              path: 'content-management',
              page: ContentManagementRoute.page,
            ),
            AutoRoute(
              path: 'user-loyalty-and-rewards',
              page: UserLoyaltyAndRewardsRoute.page,
            ),
            AutoRoute(
              page: SettingsRoute.page, 
              path: 'settings',
            ),
            AutoRoute(
            page: ForgotRouteView.page,
             path: 'forgotPassword'
            ),
          ],
        ),
        CustomRoute(
          initial: true,
          path: '/login-view',
          page: LoginRouteView.page,
          durationInMilliseconds: 0,
          reverseDurationInMilliseconds: 1,
          transitionsBuilder: TransitionsBuilders.noTransition,
        ),
        CustomRoute(
          path: '/forgotPassword',
          page: ForgotRouteView.page,
          durationInMilliseconds: 0,
          reverseDurationInMilliseconds: 1,
          transitionsBuilder: TransitionsBuilders.noTransition,
        ),
        CustomRoute(
          path: '/register-view',
          page: RegisterViewRoute.page,
          durationInMilliseconds: 0,
          reverseDurationInMilliseconds: 1,
          transitionsBuilder: TransitionsBuilders.noTransition,
          )
      ];
}
