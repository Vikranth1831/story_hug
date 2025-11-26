import 'package:get/get.dart';
import 'package:story_hug/pages/profile.dart';
import '../binding/subcategory_binding.dart';
import '../pages/Authentication/otp-screen.dart';
import '../pages/Authentication/sign_up_screen.dart';
import '../pages/Passwordchange/passwordchange.dart';
import '../pages/Reminder/reminders.dart';
import '../pages/Section1/SubSubCategory.dart';
import '../pages/Section1/SubCategory.dart';
import '../pages/Section1/Home.dart';
import '../pages/Section1/playicard.dart';
import '../pages/Subscriptions page/subscriptions.dart';
import '../pages/creating_profile_for_kids/create_profile_forkids.dart';
import '../pages/creating_profile_for_kids/manage_kids.dart';
import '../pages/favorites/favorites.dart';
import '../pages/lets-begin.dart';
import '../pages/Authentication/login_screen.dart';
import '../pages/recording_voice/recording_voice.dart';
import '../pages/recording_voice/save_voice.dart';
import '../pages/recording_voice/start_recording_voice.dart';
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
    GetPage(name: Routes.StartRecordingVoice, page: () => StartRecordingVoice()),
    GetPage(name: Routes.HomeScreen, page: () => HomeScreen()),
    GetPage(name: Routes.SelectedCardView, page: () => SubCategory()),
    GetPage(
      name: Routes.SelectedCardView,
      page: () => const SubCategory(),
      binding: SubCategoryBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(name: Routes.CreateProfileForkids, page: () => CreateProfileForkids()),
    GetPage(name: Routes.ManageKids, page: () => ManageKids()),
    GetPage(name: Routes.RecordingVoice, page: () => RecordingVoice()),
    GetPage(name: Routes.SaveVoice, page: () => SaveVoice()),
    GetPage(name: Routes.ViewCardParts, page: () => SubSubCategory()),
    GetPage(name: Routes.PlayStory, page: () => PlayStory()),
    GetPage(name: Routes.Favorites, page: () => Favorites()),
    GetPage(name: Routes.Subscribepage, page: () => Subscribepage()),
    GetPage(name: Routes.RemindersPage, page: () => RemindersPage()),
    GetPage(name: Routes.OtpScreen, page: () => OtpScreen()),
    GetPage(name: Routes.Passwordchange, page: () => Passwordchange()),
    GetPage(name: Routes.LetsBegin, page: () => LetsBegin()),
  ];
}
