import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:story_hug/utils/media_query_helper.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    // Wait for 1.5 seconds then navigate
    Future.delayed(const Duration(milliseconds: 1500), () {
     // context.go('/sign_up');
      context.go('/start_recording_voice');

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
        child: Center(
          child: Image.asset('assets/images/app_icon.png'),
        ),
      ),
    );
  }
}

