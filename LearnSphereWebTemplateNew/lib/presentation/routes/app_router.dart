import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../page/Home_page/home_screen.dart';
import '../page/change_password/change_password_view.dart';
import '../page/content_management_page/page.dart';
import '../page/dashboard_page/page.dart';
import '../page/forgot_screen/views/forgot_screen_view.dart';
import '../page/login_screen/views/login_screen_view.dart';
import '../page/main_page/page.dart';
import '../page/register/views/register_view.dart';
import '../page/settings_page/admin_settings.dart';
import '../page/settings_page/edit_profile.dart';
import '../page/view_and_user_management_page/view/view_and_user_management.dart';
import '../page/verification_screen/views/verification_screen_view.dart';

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
              path: 'user-management',
              page: ViewAndManageUsersRoute.page,
            ),
            AutoRoute(
              page: SettingsRoute.page, 
              path: 'settings',
            ),
            CustomRoute(
            path: 'change-password',
            page: ChangePasswordRoute.page,
            durationInMilliseconds: 0,
            reverseDurationInMilliseconds: 1,
            transitionsBuilder: TransitionsBuilders.noTransition
            )
          ],
        ),
        AutoRoute(
            page: ForgotRouteView.page,
             path: '/forgot-Password'
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
          page: RegisterRouteView.page,
          durationInMilliseconds: 0,
          reverseDurationInMilliseconds: 1,
          transitionsBuilder: TransitionsBuilders.noTransition,
        ),

        CustomRoute(
          page: MyHomeRoute.page,
          path: '/home-view',
          durationInMilliseconds: 0,
          reverseDurationInMilliseconds: 1,
          transitionsBuilder: TransitionsBuilders.noTransition,
          ),
          CustomRoute(
            initial: true,
            path: '/login-screen-view',
            page: LoginRouteView.page,
            durationInMilliseconds: 0,
            reverseDurationInMilliseconds: 1,
            transitionsBuilder: TransitionsBuilders.noTransition,
          ),
          CustomRoute(
            path: '/edit-profile',
            page: EditProfileRoute.page,
            durationInMilliseconds: 0,
            reverseDurationInMilliseconds: 1,
            transitionsBuilder: TransitionsBuilders.noTransition
          ),
          CustomRoute(
            path: '/verfication-screen-view',
            page: VerificationRouteView.page,
            durationInMilliseconds: 0,
            reverseDurationInMilliseconds: 1,
            transitionsBuilder: TransitionsBuilders.noTransition
          ),
          
      ];
}
