import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:story_hug/firebase_options.dart';
import 'package:story_hug/pages/splash_screen.dart';
import 'package:story_hug/services/ApiClient.dart';
import 'package:story_hug/services/NotificationService.dart';

import 'package:story_hug/utils/AppThemeData.dart';

import 'package:story_hug/utils/media_query_helper.dart';

import 'app_routes/app_pages.dart';
import 'app_routes/app_routes.dart';
import 'controller/AudioController.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  ApiClient.setupInterceptors();
  // await NotificationService().init();
  Get.put(AudioController());
  await NotificationService().init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return GetMaterialApp(
      title: 'StoryHug',
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splash,
      defaultTransition: Transition.rightToLeft,
      getPages: AppRoutes.pages,
      initialBinding: BindingsBuilder(() {}),
      theme: AppTheme.lightTheme(),
    );
  }
}
