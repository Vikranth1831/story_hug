import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:story_hug/utils/media_query_helper.dart';
class VerifyEmail extends StatelessWidget {
  const VerifyEmail({super.key});

  @override
  Widget build(BuildContext context) {
    var w = SizeConfig.screenWidth;
    var h = SizeConfig.screenHeight;

    return Scaffold(
      backgroundColor: const Color(0xFF192346),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * 0.06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: h * 0.06),

            // 🔵 1 — Circular Icon Button
            CircleIconButton(
              icon: Icons.chevron_left,   // OR Icons.chevron_right
              w: w,
            ),

            SizedBox(height: h * 0.04),

            // 🔵 2 — Verification Card
            VerificationCard(w: w, h: h),

          ],
        ),
      ),
    );
  }
  Widget CircleIconButton({required IconData icon, required double w}) {
    return Container(
      width: w * 0.12,     // 48
      height: w * 0.12,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: const Color(0xFF848484),
          width: 1,
        ),
      ),
      child: Center(
        child: Icon(
          icon,
          color: Colors.white,
          size: w * 0.06,   // same as 24px
        ),
      ),
    );
  }

}
class VerificationCard extends StatelessWidget {
  final double w, h;
  const VerificationCard({super.key, required this.w, required this.h});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: w,
      height: h * 0.40,
      decoration: BoxDecoration(
        color: const Color(0x19F7F9FE),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        children: [

          // TOP IMAGE (from assets)
          Positioned(
            left: w * 0.26,
            top: h * 0.025,
            child: Image.asset(
              "assets/images/verify.png",   // <-- your asset image
              width: w * 0.30,
              height: h * 0.18,
              fit: BoxFit.cover,
            ),
          ),

          // TEXT + BUTTON
          Positioned(
            left: w * 0.05,
            top: h * 0.20,
            child: SizedBox(
              width: w * 0.82,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // TEXTS
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Please Verify\n',
                          style: TextStyle(
                            color: const Color(0xFFF5F5F5),
                            fontSize: w * 0.052,
                            fontFamily: 'Arial Rounded MT Bold',
                            height: 1.5,
                          ),
                        ),
                        TextSpan(
                          text: 'To Change your Password',
                          style: TextStyle(
                            color: const Color(0xFFF5F5F5),
                            fontSize: w * 0.042,
                            fontFamily: 'Arial Rounded MT Bold',
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: h * 0.03),

                  // GRADIENT BUTTON
                  Container(
                    width: double.infinity,
                    height: h * 0.06,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFFCDB69),
                          Color(0xFFFCBF5D),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Center(
                      child: Text(
                        "Send OTP to Gmail",
                        style: TextStyle(
                          color: const Color(0xFF333333),
                          fontSize: w * 0.042,
                          fontFamily: 'Arial',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


