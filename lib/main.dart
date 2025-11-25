import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:story_hug/services/ApiClient.dart';
import 'package:story_hug/services/NotificationService.dart';

import 'package:story_hug/utils/AppThemeData.dart';

import 'package:story_hug/utils/media_query_helper.dart';

import 'app_routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ApiClient.setupInterceptors();
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
      theme: AppTheme.lightTheme(),
    );
  }
}
