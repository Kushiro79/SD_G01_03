// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [ChangePasswordPage]
class ChangePasswordRoute extends PageRouteInfo<ChangePasswordRouteArgs> {
  ChangePasswordRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          ChangePasswordRoute.name,
          args: ChangePasswordRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'ChangePasswordRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ChangePasswordRouteArgs>(
          orElse: () => const ChangePasswordRouteArgs());
      return ChangePasswordPage(key: args.key);
    },
  );
}

class ChangePasswordRouteArgs {
  const ChangePasswordRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'ChangePasswordRouteArgs{key: $key}';
  }
}

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
/// [EditProfilePage]
class EditProfileRoute extends PageRouteInfo<void> {
  const EditProfileRoute({List<PageRouteInfo>? children})
      : super(
          EditProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'EditProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return EditProfilePage();
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
/// [MyHomePage]
class MyHomeRoute extends PageRouteInfo<MyHomeRouteArgs> {
  MyHomeRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          MyHomeRoute.name,
          args: MyHomeRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'MyHomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<MyHomeRouteArgs>(orElse: () => const MyHomeRouteArgs());
      return MyHomePage(key: args.key);
    },
  );
}

class MyHomeRouteArgs {
  const MyHomeRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'MyHomeRouteArgs{key: $key}';
  }
}

/// generated route for
/// [ProfileScreenPage]
class ProfileRouteRoute extends PageRouteInfo<ProfileRouteRouteArgs> {
  ProfileRouteRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          ProfileRouteRoute.name,
          args: ProfileRouteRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'ProfileRouteRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProfileRouteRouteArgs>(
          orElse: () => const ProfileRouteRouteArgs());
      return ProfileScreenPage(key: args.key);
    },
  );
}

class ProfileRouteRouteArgs {
  const ProfileRouteRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'ProfileRouteRouteArgs{key: $key}';
  }
}

/// generated route for
/// [RegisterScreenView]
class RegisterRouteView extends PageRouteInfo<RegisterRouteViewArgs> {
  RegisterRouteView({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          RegisterRouteView.name,
          args: RegisterRouteViewArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'RegisterRouteView';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RegisterRouteViewArgs>(
          orElse: () => const RegisterRouteViewArgs());
      return RegisterScreenView(key: args.key);
    },
  );
}

class RegisterRouteViewArgs {
  const RegisterRouteViewArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'RegisterRouteViewArgs{key: $key}';
  }
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
/// [VerificationScreenView]
class VerificationRouteView extends PageRouteInfo<void> {
  const VerificationRouteView({List<PageRouteInfo>? children})
      : super(
          VerificationRouteView.name,
          initialChildren: children,
        );

  static const String name = 'VerificationRouteView';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const VerificationScreenView();
    },
  );
}

/// generated route for
/// [ViewAndManageUsersPage]
class ViewAndManageUsersRoute extends PageRouteInfo<void> {
  const ViewAndManageUsersRoute({List<PageRouteInfo>? children})
      : super(
          ViewAndManageUsersRoute.name,
          initialChildren: children,
        );

  static const String name = 'ViewAndManageUsersRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ViewAndManageUsersPage();
    },
  );
}
