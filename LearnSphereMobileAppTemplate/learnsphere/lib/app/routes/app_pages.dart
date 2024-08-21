import 'package:get/get.dart';
import 'package:sociogram/app/modules/activity_screen/activity_screen_binding.dart';
import 'package:sociogram/app/modules/addpost_screen/bindings/addpost_screen_binding.dart';
import 'package:sociogram/app/modules/addpost_screen/views/addpost_screen_view.dart';
import 'package:sociogram/app/modules/editpictre_screen/bindings/editpictre_screen_binding.dart';
import 'package:sociogram/app/modules/editpictre_screen/views/editpictre_screen_view.dart';
import 'package:sociogram/app/modules/live_screen/live_screen_binding.dart';
import 'package:sociogram/app/modules/live_screen/live_screen_view.dart';
import 'package:sociogram/app/modules/postdetail_screen/postdetail_screen_binding.dart';
import 'package:sociogram/app/modules/postdetail_screen/postdetail_screen_view.dart';

import '../modules/Onboarding1/bindings/onboarding1_binding.dart';
import '../modules/Onboarding1/views/onboarding1_view.dart';
import '../modules/birthday_screen/bindings/birthday_screen_binding.dart';
import '../modules/birthday_screen/views/birthday_screen_view.dart';
import '../modules/createpin_screen/bindings/createpin_screen_binding.dart';
import '../modules/createpin_screen/views/createpin_screen_view.dart';
import '../modules/editprofile_screen/bindings/editprofile_screen_binding.dart';
import '../modules/editprofile_screen/views/editprofile_screen_view.dart';
import '../modules/faceid_screen/bindings/faceid_screen_binding.dart';
import '../modules/faceid_screen/views/faceid_screen_view.dart';
import '../modules/filter_screen/bindings/filter_screen_binding.dart';
import '../modules/filter_screen/views/filter_screen_view.dart';
import '../modules/follow_screen/bindings/follow_screen_binding.dart';
import '../modules/follow_screen/views/follow_screen_view.dart';
import '../modules/forgot_screen/bindings/forgot_screen_binding.dart';
import '../modules/forgot_screen/views/forgot_screen_view.dart';
import '../modules/get_started/bindings/get_started_binding.dart';
import '../modules/get_started/views/get_started_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/interest_screen/bindings/interest_screen_binding.dart';
import '../modules/interest_screen/views/interest_screen_view.dart';
import '../modules/login_screen/bindings/login_screen_binding.dart';
import '../modules/login_screen/views/login_screen_view.dart';
import '../modules/pnumber_screen/bindings/pnumber_screen_binding.dart';
import '../modules/pnumber_screen/views/pnumber_screen_view.dart';
import '../modules/proflie_screen/bindings/proflie_screen_binding.dart';
import '../modules/proflie_screen/views/proflie_screen_view.dart';
import '../modules/pronouns_screen/bindings/pronouns_screen_binding.dart';
import '../modules/pronouns_screen/views/pronouns_screen_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/serach_screen/bindings/serach_screen_binding.dart';
import '../modules/serach_screen/views/serach_screen_view.dart';
import '../modules/shop_screen/bindings/shop_screen_binding.dart';
import '../modules/shop_screen/views/shop_screen_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';
import '../modules/verification_screen/bindings/verification_screen_binding.dart';
import '../modules/verification_screen/views/verification_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING1,
      page: () => Onboarding1View(),
      binding: Onboarding1Binding(),
    ),
    GetPage(
      name: _Paths.GET_STARTED,
      page: () => const GetStartedView(),
      binding: GetStartedBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN_SCREEN,
      page: () => LoginScreenView(),
      binding: LoginScreenBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () =>  RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.PNUMBER_SCREEN,
      page: () =>  const PnumberScreenView(),
      binding: PnumberScreenBinding(),
    ),
    GetPage(
      name: _Paths.VERIFICATION_SCREEN,
      page: () => const VerificationScreenView(),
      binding: VerificationScreenBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_SCREEN,
      page: () => const ForgotScreenView(),
      binding: ForgotScreenBinding(),
    ),
    GetPage(
      name: _Paths.FACEID_SCREEN,
      page: () => const FaceidScreenView(),
      binding: FaceidScreenBinding(),
    ),
    GetPage(
      name: _Paths.CREATEPIN_SCREEN,
      page: () => const CreatepinScreenView(),
      binding: CreatepinScreenBinding(),
    ),
    GetPage(
      name: _Paths.INTEREST_SCREEN,
      page: () => InterestScreenView(),
      binding: InterestScreenBinding(),
    ),
    GetPage(
      name: _Paths.BIRTHDAY_SCREEN,
      page: () => const BirthdayScreenView(),
      binding: BirthdayScreenBinding(),
    ),
    GetPage(
      name: _Paths.PRONOUNS_SCREEN,
      page: () => PronounsScreenView(),
      binding: PronounsScreenBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SERACH_SCREEN,
      page: () => SerachScreenView(),
      binding: SerachScreenBinding(),
    ),
    GetPage(
      name: _Paths.SHOP_SCREEN,
      page: () => ShopScreenView(),
      binding: ShopScreenBinding(),
    ),
    GetPage(
      name: _Paths.PROFLIE_SCREEN,
      page: () =>  ProflieScreenView(),
      binding: ProflieScreenBinding(),
    ),
    GetPage(
      name: _Paths.FILTER_SCREEN,
      page: () => const FilterScreenView(),
      binding: FilterScreenBinding(),
    ),
    GetPage(
      name: _Paths.FOLLOW_SCREEN,
      page: () => FollowScreenView(),
      binding: FollowScreenBinding(),
    ),
    GetPage(
      name: _Paths.EDITPROFILE_SCREEN,
      page: () => EditprofileScreenView(),
      binding: EditprofileScreenBinding(),
    ),
    GetPage(
      name: _Paths.EDITPICTRE_SCREEN,
      page: () => EditpictreScreenView(),
      binding: EditpictreScreenBinding(),
    ),
    GetPage(
      name: _Paths.ADDPOST_SCREEN,
      page: () => AddpostScreenView(),
      binding: AddpostScreenBinding(),
    ),
    GetPage(
      name: _Paths.ADDPOST_SCREEN,
      page: () => const PostdetailScreenView(),
      binding: PostdetailScreenBinding(),
    ),
    GetPage(
      name: _Paths.ACTIVITY_SCREEN,
      page: () =>  AddpostScreenView(),
      binding: ActivityScreenBinding(),
    ),
    GetPage(
      name: _Paths.ACTIVITY_SCREEN,
      page: () =>  const LiveScreenView(),
      binding: LiveScreenBinding(),
    ),
  ];
}
