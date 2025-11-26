import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:story_hug/components/create_now_button.dart';
import 'package:story_hug/controller/sent_otp_controller.dart';
import 'package:story_hug/utils/media_query_helper.dart';

import '../../data/remote_data_source.dart';
import '../../repositories/opt_sent_repository.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final SendOtpController controller = Get.put(
    SendOtpController(
      repository: otpsentRepositoryImpl(remoteDataSource: RemoteDataSourceImpl()),
    ),
  );
  final String bgAssetPath = 'assets/images/bgimage.png';
  final String logoAssetPath = 'assets/images/logo.png';

  String otpValue = "";
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    final double w = SizeConfig.screenWidth;
    final double h = SizeConfig.screenHeight;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              bgAssetPath,
              fit: BoxFit.cover,
            ),
          ),

          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.04),
              child: Column(
                children: [
                  SizedBox(height: h * 0.02),

                  /// LOGO
                  Align(
                    alignment: Alignment.topLeft,
                    child: Image.asset(
                      logoAssetPath,
                      height: h * 0.045,
                    ),
                  ),

                  SizedBox(height: h * 0.06),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          /// BACK BUTTON
                          Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: () => context.pop(),
                              child: Container(
                                width: w * 0.14,
                                height: w * 0.14,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.white.withOpacity(0.18),
                                      width: 1.5),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.chevron_left_outlined,
                                    color: const Color(0xFFFFC84F),
                                    size: w * 0.065,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: h * 0.02),

                          /// OTP CARD
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: w * 0.06,
                              vertical: h * 0.035,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF2E3550).withOpacity(0.88),
                              borderRadius: BorderRadius.circular(26),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// TITLE
                                Text(
                                  "Enter OTP",
                                  style: TextStyle(
                                    fontSize: w * 0.065,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                SizedBox(height: h * 0.01),

                                /// SUBTEXT
                                Text(
                                  "OTP sent to the surya@gmail.com",
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.9),
                                    fontSize: w * 0.04,
                                  ),
                                ),

                                SizedBox(height: h * 0.03),

                                /// ⭐ PINCODE FIELDS (Same UI)
                                PinCodeTextField(
                                  length: 6,
                                  appContext: context,
                                  keyboardType: TextInputType.number,
                                  cursorColor: Colors.white,
                                  autoDismissKeyboard: true,
                                  animationType: AnimationType.fade,

                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: w * 0.055,
                                  ),

                                  pinTheme: PinTheme(
                                    shape: PinCodeFieldShape.box,
                                    borderRadius: BorderRadius.circular(14),
                                    fieldHeight: h * 0.065,
                                    fieldWidth: w * 0.115,

                                    activeColor: Colors.white30,
                                    inactiveColor: Colors.white30,
                                    selectedColor: const Color(0xFFFFC84F),

                                    activeFillColor: Colors.white30,
                                    inactiveFillColor: Colors.white30,
                                    selectedFillColor: Colors.white24,

                                    borderWidth: 1,
                                  ),

                                  enableActiveFill: true,

                                  onChanged: (value) {
                                    setState(() {
                                      otpValue = value;
                                      errorMessage = null;
                                    });
                                  },
                                ),

                                SizedBox(height: h * 0.015),

                                /// ERROR MESSAGE
                                if (errorMessage != null)
                                  Text(
                                    errorMessage!,
                                    style: TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: w * 0.036),
                                  ),

                                SizedBox(height: h * 0.015),

                                /// RESEND
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() => errorMessage = null);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                          content: Text("OTP Resent")));
                                    },
                                    child: Text(
                                      "Resend OTP",
                                      style: TextStyle(
                                        color: const Color(0xFFFFC84F),
                                        fontSize: w * 0.042,
                                        decoration: TextDecoration.underline,
                                        decorationColor: Color(0xFFFFC84F),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(height: h * 0.03),

                                /// SUBMIT BUTTON
                                InkWell(
                                  onTap: () {
                                    if (otpValue.length != 6) {
                                      setState(() {
                                        errorMessage = "Please enter all 6 digits";
                                      });
                                      return;
                                    }

                                      controller.sendotp();
                                  },
                                  child: const CreateNowButton(text: "Submit OTP"),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: h * 0.09),
                        ],
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