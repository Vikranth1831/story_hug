import 'package:flutter/material.dart';
import 'package:story_hug/utils/media_query_helper.dart'; // Your SizeConfig
import 'package:go_router/go_router.dart';

import 'package:flutter/material.dart';
import 'package:story_hug/utils/media_query_helper.dart';
import 'package:go_router/go_router.dart';

class PlayStory extends StatefulWidget {
  const PlayStory({super.key});

  @override
  State<PlayStory> createState() => _PlayStoryState();
}

class _PlayStoryState extends State<PlayStory> {
  bool isTablet = false;
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    final double h = SizeConfig.screenHeight;
    final double w = SizeConfig.screenWidth;

    isTablet = w > 600;

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,

        // BACKGROUND
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bgimage.png"),
            fit: BoxFit.cover,
          ),
        ),

        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: h * 0.01),

                // BACK BUTTON
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: isTablet ? 14 : 10,
                          horizontal: isTablet ? 22 : 18,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFFFCDB69),
                              Color(0xFFFCBF5D),
                            ],
                          ),
                        ),
                        child: const Text(
                          "Back",
                          style: TextStyle(
                            fontFamily: "Arial",
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF24305B),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: h * 0.015),

                // LOGO CENTER
                Center(
                  child: Image.asset(
                    "assets/images/logo.png",
                    height: isTablet ? h * 0.08 : h * 0.05,
                  ),
                ),

                SizedBox(height: h * 0.02),

                // TITLE
                const Text(
                  "Bala Kanda",
                  style: TextStyle(
                    fontFamily: "Arial",
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: h * 0.02),

                // 🌟 STORY IMAGE + HEART INSIDE IMAGE
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        "assets/images/card1.jpg",
                        height: isTablet ? h * 0.45 : h * 0.4,
                        width: w * 0.7,
                        fit: BoxFit.cover,
                      ),
                    ),

                    /// ❤ ICON INSIDE IMAGE (TOP RIGHT CORNER)
                    Positioned(
                      top: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: () {
                          setState(() => isLiked = !isLiked);
                        },
                        child: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          size: isTablet ? 40 : 32,
                          color: isLiked ? Color(0xffF9E2A1) :Color(0xffF9E2A1),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: h * 0.03),

                // AUDIO PLAYER BOX
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: isTablet ? 20 : 16,
                      horizontal: isTablet ? 25 : 10,
                    ),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xff464E8A),
                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: Column(
                      children: [
                        // PLAY CONTROLS
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset(
                              'assets/icons/backword.png',
                              height: isTablet ? 40 : 35,
                              color: const Color(0xffF9E2A1),
                            ),
                            Icon(
                              Icons.play_circle_fill_rounded,
                              size: isTablet ? 55 : 45,
                              color: const Color(0xffF9E2A1),
                            ),
                            Image.asset(
                              'assets/icons/forword.png',
                              height: isTablet ? 40 : 35,
                              color: const Color(0xffF9E2A1),
                            ),
                          ],
                        ),

                        SizedBox(height: h * 0.015),

                        Slider(
                          value: 42,
                          min: 0,
                          max: 162,
                          thumbColor: const Color(0xffF9E2A1),
                          activeColor: const Color(0xffF9E2A1),
                          onChanged: (v) {},
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "0:42",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "2:42",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}