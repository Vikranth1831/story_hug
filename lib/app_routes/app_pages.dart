import 'package:get/get.dart';
import 'package:story_hug/pages/profile.dart';
import 'package:story_hug/pages/sign_up_screen.dart';

import '../pages/login_screen.dart';
import '../pages/splash_screen.dart';
import '../pages/verify_email.dart';
import 'app_routes.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: Routes.splash, page: () => SplashScreen()),
    GetPage(name: Routes.login, page: () => LoginScreen()),
    GetPage(name: Routes.profile, page: () => ProfileScreen()),
    GetPage(name: Routes.SignUpScreen, page: () => SignUpScreen()),
    GetPage(name: Routes.verifyEmail, page: () => VerifyEmail()),
  ];
}
