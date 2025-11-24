import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:story_hug/components/create_now_button.dart';
import 'package:story_hug/utils/media_query_helper.dart';


class LetsBegin extends StatefulWidget {
  const LetsBegin({super.key});

  @override
  State<LetsBegin> createState() => _LetsBeginState();
}

class _LetsBeginState extends State<LetsBegin> {
  @override
  Widget build(BuildContext context) {



    double h = SizeConfig.screenHeight;
    double w = SizeConfig.screenWidth;

    bool isTab = w > 600; // simple responsive check

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        // ⭐ Background Gradient
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 0.17, 0.40, 0.66, 0.94],
            colors: [
              Color(0xFF303174),
              Color(0xFF5067AB),
              Color(0xFF7A7BA4),
              Color(0xFFF7DCAD),
              Color(0xFFE3C6D3),
            ],
          ),
        ),

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// ⭐ First Image
              Image.asset(
                "assets/images/geminiimage.png",
                height: isTab ? h * 0.32 : h * 0.25,
                width: isTab ? w * 0.55 : w * 0.75,
              ),

              SizedBox(height: isTab ? h * 0.05 : h * 0.04),

              /// ⭐ Second Image
              Image.asset(
                "assets/images/iconsimage.png",
                height: isTab ? h * 0.32 : h * 0.25,
                width: isTab ? w * 0.55 : w * 0.75,
              ),

              SizedBox(height: isTab ? h * 0.05 : h * 0.04),

              /// ⭐ Create Now Button
              InkWell(
                onTap: () {
                  context.push('/start_recording_voice');
                },
                child: const CreateNowButton(
                  text: "Create Now",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
