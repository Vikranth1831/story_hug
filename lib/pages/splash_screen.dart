import 'dart:developer' as AppLogger;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:go_router/go_router.dart';
import 'package:story_hug/app_routes/app_routes.dart';
import 'package:story_hug/pages/Section1/Home.dart';
import 'package:story_hug/pages/Authentication/login_screen.dart';
import 'package:story_hug/utils/media_query_helper.dart';

import '../services/AuthService.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1500), () async {
      final token = await AuthService.getAccessToken();
      AppLogger.log("Token:$token");
      if (!mounted) return;
      if (token == null || token.isEmpty) {
        Get.offAllNamed(Routes.login);
      } else {
        Get.offAllNamed(Routes.ChooseProfile);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_splash.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(child: Image.asset('assets/images/app_icon.png')),
      ),
    );
  }
}
