import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:story_hug/components/text_field.dart';

class Passwordchange extends StatefulWidget {
  const Passwordchange({super.key});

  @override
  State<Passwordchange> createState() => _PasswordchangeState();
}

class _PasswordchangeState extends State<Passwordchange> {
  final TextEditingController newPass = TextEditingController();
  final TextEditingController confirmPass = TextEditingController();

  String? newPassError;
  String? confirmPassError;

  void validateFields() {
    setState(() {
      newPassError = null;
      confirmPassError = null;

      if (newPass.text.isEmpty) {
        newPassError = "Please enter new password";
      }

      if (confirmPass.text.isEmpty) {
        confirmPassError = "Please confirm your password";
      }

      if (newPass.text.isNotEmpty &&
          confirmPass.text.isNotEmpty &&
          newPass.text != confirmPass.text) {
        confirmPassError = "Passwords do not match";
      }
    });

    if (newPassError == null && confirmPassError == null) {
      context.pushReplacement(
        '/success',
        extra: {
          'title': "Password Changed Successfully!",
          'button': "Login Now",
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          reverse: true,
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bgimage.png"),
                fit: BoxFit.cover,
              ),
            ),

            child: Column(
              children: [
                SizedBox(height: h * 0.05),

                // ⭐ LOGO
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Image.asset(
                      "assets/images/logo.png",
                      height: 32,
                    ),
                  ),
                ),

                SizedBox(height: h * 0.20),

                // ⭐ BACK BUTTON
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 42,
                      width: 42,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.08),
                        border: Border.all(
                          color: Color(0xFFFFC84F),
                          width: 1.4,
                        ),
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        color: Color(0xFFFFC84F),
                        size: 22,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: h * 0.06),

                // ⭐ MAIN CARD
                Container(
                  width: w * 0.88,
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 26),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.25),
                      width: 1.2,
                    ),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "New Password",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 6),

                      CustomInputField(
                        controller: newPass,
                        label1: 'Password',
                      ),

                      if (newPassError != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 5, left: 4),
                          child: Text(
                            newPassError!,
                            style: const TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        ),

                      SizedBox(height: 18),

                      const Text(
                        "Confirm Password",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 6),

                      CustomInputField(
                        controller: confirmPass,
                        label1: 'New Password',
                      ),

                      if (confirmPassError != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 5, left: 4),
                          child: Text(
                            confirmPassError!,
                            style: const TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        ),

                      SizedBox(height: 26),

                      Center(
                        child: GestureDetector(
                          onTap: validateFields,
                          child: Container(
                            width: w * 0.60,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFFFFD66E),
                                  Color(0xFFFFC84F),
                                ],
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                "Confirm",
                                style: TextStyle(
                                  color: Color(0xFF24305B),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
