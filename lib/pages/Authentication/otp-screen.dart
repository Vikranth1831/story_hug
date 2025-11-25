import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:story_hug/components/create_now_button.dart';
import 'package:story_hug/utils/media_query_helper.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final String bgAssetPath = 'assets/images/bgimage.png';
  final String logoAssetPath = 'assets/images/logo.png';

  final List<TextEditingController> _otpControllers =
  List.generate(6, (index) => TextEditingController());

  String? errorMessage; // <-- ADDED

  @override
  void dispose() {
    for (var c in _otpControllers) {
      c.dispose();
    }
    super.dispose();
  }

  /// OTP BOX UI
  Widget otpBox(int index, double w, double h) {
    return Container(
      width: w * 0.115,
      height: h * 0.065,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white30,
      ),
      child: TextField(
        controller: _otpControllers[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: TextStyle(
          color: Colors.white,
          fontSize: w * 0.055,
        ),

        decoration: const InputDecoration(
          counterText: "",
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          filled: true,
          fillColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
        ),

        onChanged: (value) {
          // Remove errors while typing
          setState(() => errorMessage = null);

          // Validate only digits
          if (value.isNotEmpty && !RegExp(r'^[0-9]$').hasMatch(value)) {
            setState(() {
              errorMessage = "Invalid OTP (only digits allowed)";
            });
            _otpControllers[index].clear();
            return;
          }

          // Auto move to next field
          if (value.isNotEmpty && index < 5) {
            FocusScope.of(context).nextFocus();
          }

          // Last digit → Auto close keyboard
          if (index == 5 && value.isNotEmpty) {
            FocusScope.of(context).unfocus();
          }

          // Backspace → go to previous field
          if (value.isEmpty && index > 0) {
            FocusScope.of(context).previousFocus();
          }
        },
      ),
    );
  }

  /// OTP VALIDATION
  bool validateOtp() {
    for (var c in _otpControllers) {
      if (c.text.isEmpty) return false;
    }
    return true;
  }

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
                                      fontWeight: FontWeight.bold),
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

                                /// OTP BOXES
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children:
                                  List.generate(6, (i) => otpBox(i, w, h)),
                                ),

                                SizedBox(height: h * 0.015),

                                /// ERROR MESSAGE BELOW OTP BOXES  <--- ADDED
                                if (errorMessage != null)
                                  Padding(
                                    padding: EdgeInsets.only(top: h * 0.005),
                                    child: Text(
                                      errorMessage!,
                                      style: TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: w * 0.036,
                                      ),
                                    ),
                                  ),

                                SizedBox(height: h * 0.015),

                                /// RESEND
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        errorMessage = null;
                                      });
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

                                /// CONTINUE BUTTON WITH VALIDATION
                                InkWell(
                                  onTap: () {
                                    if (!validateOtp()) {
                                      setState(() {
                                        errorMessage =
                                        "Please enter all 6 digits";
                                      });
                                      return;
                                    }

                                    context.push('/success',extra: {
                                      'title': "Verified",
                                      'button': "Continue",
                                    },);
                                  },
                                  child: const CreateNowButton(
                                    text: "Submit OTP",
                                  ),
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
