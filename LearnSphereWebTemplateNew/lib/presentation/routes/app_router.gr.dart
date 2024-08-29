// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [ContentManagementPage]
class ContentManagementRoute extends PageRouteInfo<void> {
  const ContentManagementRoute({List<PageRouteInfo>? children})
      : super(
          ContentManagementRoute.name,
          initialChildren: children,
        );

  static const String name = 'ContentManagementRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ContentManagementPage();
    },
  );
}

/// generated route for
/// [DashboardPage]
class DashboardRoute extends PageRouteInfo<void> {
  const DashboardRoute({List<PageRouteInfo>? children})
      : super(
          DashboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashboardRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const DashboardPage();
    },
  );
}

/// generated route for
/// [ForgotScreenView]
class ForgotRouteView extends PageRouteInfo<ForgotRouteViewArgs> {
  ForgotRouteView({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          ForgotRouteView.name,
          args: ForgotRouteViewArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'ForgotRouteView';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ForgotRouteViewArgs>(
          orElse: () => const ForgotRouteViewArgs());
      return ForgotScreenView(key: args.key);
    },
  );
}

class ForgotRouteViewArgs {
  const ForgotRouteViewArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'ForgotRouteViewArgs{key: $key}';
  }
}

/// generated route for
/// [LoginScreenView]
class LoginRouteView extends PageRouteInfo<LoginRouteViewArgs> {
  LoginRouteView({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          LoginRouteView.name,
          args: LoginRouteViewArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'LoginRouteView';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LoginRouteViewArgs>(
          orElse: () => const LoginRouteViewArgs());
      return LoginScreenView(key: args.key);
    },
  );
}

class LoginRouteViewArgs {
  const LoginRouteViewArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'LoginRouteViewArgs{key: $key}';
  }
}

/// generated route for
/// [MainPage]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MainPage();
    },
  );
}

/// generated route for
/// [SettingsPage]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SettingsPage();
    },
  );
}

/// generated route for
/// [UserLoyaltyAndRewardsPage]
class UserLoyaltyAndRewardsRoute extends PageRouteInfo<void> {
  const UserLoyaltyAndRewardsRoute({List<PageRouteInfo>? children})
      : super(
          UserLoyaltyAndRewardsRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserLoyaltyAndRewardsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const UserLoyaltyAndRewardsPage();
    },
  );
}
