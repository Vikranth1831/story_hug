import 'package:flutter/material.dart';
import 'package:story_hug/utils/media_query_helper.dart';
import 'package:go_router/go_router.dart';

class VerifyEmail extends StatelessWidget {
  const VerifyEmail({super.key});

  @override
  Widget build(BuildContext context) {


    var w = SizeConfig.screenWidth;
    var h = SizeConfig.screenHeight;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        // ⭐ BACKGROUND IMAGE
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bgimage.png"),
            fit: BoxFit.cover,
          ),
        ),

        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.06),
          child: Column(
            children: [

              SizedBox(height: h * 0.2),

              // 🔵 Back Button
              Align(
                alignment: Alignment.centerLeft,
                child: CircleIconButton(
                  icon: Icons.chevron_left,
                  w: w,
                ),
              ),

              SizedBox(height: h * 0.08),

              // 🔵 Centered Card
              Center(
                child: VerificationCard(w: w, h: h),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget CircleIconButton({required IconData icon, required double w}) {
    return Container(
      width: w * 0.12,
      height: w * 0.12,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color:  Colors.amber,
          width: 1,
        ),
      ),
      child: Center(
        child: Icon(
          icon,
          color: Colors.amber,
          size: w * 0.06,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------

class VerificationCard extends StatelessWidget {
  final double w, h;
  const VerificationCard({super.key, required this.w, required this.h});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: w * 0.90,
      height: h * 0.40,

      // CARD STYLE
      decoration: BoxDecoration(
        color: const Color(0x19F7F9FE),
        borderRadius: BorderRadius.circular(24),
      ),

      child: Stack(
        children: [

          // ⭐ TOP IMAGE
          Positioned(
            left: w * 0.26,
            top: h * 0.02,
            child: Image.asset(
              "assets/images/verify.png",
              width: w * 0.30,
              height: h * 0.16,

              fit: BoxFit.cover,
            ),
          ),

          // ⭐ TEXT + BUTTON
          Positioned(
            left: w * 0.05,
            top: h * 0.18,
            child: SizedBox(
              width: w * 0.80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // FULL BOLD TEXT
                  Text(
                    "Please Verify",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: w * 0.055,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Arial Rounded MT Bold',
                    ),
                  ),

                  Text(
                    "To Change your Password",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: w * 0.045,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Arial Rounded MT Bold',
                    ),
                  ),

                  SizedBox(height: h * 0.03),

                  // BUTTON
                  GestureDetector(
                    onTap:(){
                      context.push('/otp-screen');
                    },
                    child: Container(
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
                            fontWeight: FontWeight.bold,     // ★ bold added
                            fontFamily: 'Arial Rounded MT Bold',
                          ),
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
