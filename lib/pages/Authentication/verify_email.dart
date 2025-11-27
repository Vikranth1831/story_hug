import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:story_hug/pages/Authentication/otp-screen.dart';
import 'package:story_hug/utils/media_query_helper.dart';
import 'package:go_router/go_router.dart';

import '../../components/CustomAppButton.dart';
import '../../controller/sent_otp_controller.dart';
import '../../data/remote_data_source.dart';
import '../../repositories/opt_sent_repository.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  final SendOtpController controller = Get.put(
    SendOtpController(
      repository: otpsentRepositoryImpl(
        remoteDataSource: RemoteDataSourceImpl(),
      ),
    ),
  );
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
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: CircleIconButton(icon: Icons.chevron_left, w: w),
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
        border: Border.all(color: Colors.amber, width: 1),
      ),
      child: Center(
        child: Icon(icon, color: Colors.amber, size: w * 0.06),
      ),
    );
  }
}

// ---------------------------------------------------------

class VerificationCard extends StatefulWidget {
  final double w, h;
  const VerificationCard({super.key, required this.w, required this.h});

  @override
  State<VerificationCard> createState() => _VerificationCardState();
}

class _VerificationCardState extends State<VerificationCard> {
  final SendOtpController controller = Get.put(
    SendOtpController(
      repository: otpsentRepositoryImpl(
        remoteDataSource: RemoteDataSourceImpl(),
      ),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.w * 0.90,
      height: widget.h * 0.40,

      // CARD STYLE
      decoration: BoxDecoration(
        color: const Color(0x19F7F9FE),
        borderRadius: BorderRadius.circular(24),
      ),

      child: Stack(
        children: [
          // ⭐ TOP IMAGE
          Positioned(
            left: widget.w * 0.26,
            top: widget.h * 0.02,
            child: Image.asset(
              "assets/images/verify.png",
              width: widget.w * 0.30,
              height: widget.h * 0.16,

              fit: BoxFit.cover,
            ),
          ),

          // ⭐ TEXT + BUTTON
          Positioned(
            left: widget.w * 0.05,
            top: widget.h * 0.18,
            child: SizedBox(
              width: widget.w * 0.80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // FULL BOLD TEXT
                  Text(
                    "Please Verify",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: widget.w * 0.055,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Arial Rounded MT Bold',
                    ),
                  ),

                  Text(
                    "To Change your Password",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: widget.w * 0.045,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Arial Rounded MT Bold',
                    ),
                  ),
                  SizedBox(height: widget.h * 0.03),
                  Obx(() {
                    return CustomAppButton1(
                      onPlusTap: () {
                        controller.sendotp(true);
                      },
                      text: "Send OTP to Gmail",
                      isLoading: controller.isLoading.value,   // FIXED
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
