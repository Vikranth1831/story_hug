import 'dart:ui';
import 'package:flutter/material.dart';

class Passwordchange extends StatefulWidget {
  const Passwordchange({super.key});

  @override
  State<Passwordchange> createState() => _PasswordchangeState();
}

class _PasswordchangeState extends State<Passwordchange> {
  final TextEditingController newPass = TextEditingController();
  final TextEditingController confirmPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,

      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          reverse: true,              // prevents overflow on keyboard
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

                      _textField(newPass),

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

                      _textField(confirmPass),

                      SizedBox(height: 26),

                      Center(
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

  // ⭐ PERFECT WHITE TEXTFIELD
  Widget _textField(TextEditingController controller) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white, // FULL WHITE BG
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.20),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: true,
        style: const TextStyle(
          color: Colors.black,     // TEXT COLOR BLACK (correct)
          fontSize: 14,
        ),

        decoration: InputDecoration(
          filled: true,                 // VERY IMPORTANT
          fillColor: Colors.white,      // PURE WHITE FILL
          hintText: "Password",
          hintStyle: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(26),
            borderSide: BorderSide.none,
          ),
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        ),
      ),
    );
  }
}
