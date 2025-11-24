import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:story_hug/CustomTopBar.dart';
import 'package:story_hug/utils/media_query_helper.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLogin = true;

  bool passwordVisible1 = false;
  bool passwordVisible2 = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController pass1Controller = TextEditingController();
  final TextEditingController pass2Controller = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var h = SizeConfig.screenHeight;
    var w = SizeConfig.screenWidth;

    return Scaffold(
      resizeToAvoidBottomInset: true, // FIXED KEYBOARD OVERFLOW

      body: Stack(
        children: [
          /// 🔵 FULL SCREEN BACKGROUND IMAGE
          Positioned.fill(
            child: Image.asset(
              "assets/images/background_for_login.png",
              fit: BoxFit.cover,
            ),
          ),

          /// USE A SCROLL VIEW SO SCREEN NEVER OVERFLOWS
          Positioned.fill(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: h * 0.065),

                  Image.asset('assets/images/open_book_login.png'),
                  SizedBox(height: h * 0.03),
                  Image.asset('assets/images/login_book.png'),
                 SizedBox(height: h * 0.05),

                  /// -----------------------------------------------------------------
                  /// MAIN LOGIN/SIGNUP BOX
                  /// -----------------------------------------------------------------
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: w * 0.04),
                    child: Container(
                      width: double.infinity,
                      height: h * 0.45,
                      

                      decoration:  BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/background_for_box.png"),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(17),
                      ),

                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Form(
                          key: formKey,

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              /// ----------------------------------------------------
                              /// 🔵 LOGIN / SIGNUP TOGGLE BUTTONS
                              /// ----------------------------------------------------
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // LOGIN BUTTON
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isLogin = true;
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: isLogin
                                            ? const Color(0xFFFFD54F) // SELECTED = YELLOW
                                            : Colors.white24, // UNSELECTED
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        "Login",
                                        style: TextStyle(
                                          color: isLogin ? Colors.black : Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 20),

                                  // SIGNUP BUTTON
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isLogin = false;
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: !isLogin
                                            ? const Color(0xFFFFD54F)
                                            : Colors.white24,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        "Sign Up",
                                        style: TextStyle(
                                          color: !isLogin ? Colors.black : Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 20),

                              /// ----------------------------------------------------
                              /// 🔵 LOGIN FIELDS
                              /// ----------------------------------------------------
                              if (isLogin) ...[
                                _textField(
                                  controller: emailController,
                                  hint: "Email",
                                  isPassword: false,
                                  onEyeTap: null,
                                ),

                                const SizedBox(height: 15),

                                _textField(
                                  controller: pass1Controller,
                                  hint: "Password",
                                  isPassword: true,
                                  onEyeTap: () {
                                    setState(() {
                                      passwordVisible1 = !passwordVisible1;
                                    });
                                  },
                                  isVisible: passwordVisible1,
                                ),

                                const SizedBox(height: 20),

                                /// LOGIN BUTTON (YELLOW)
                                ElevatedButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      // login logic
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFFFD54F),
                                  ),
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],

                              /// ----------------------------------------------------
                              /// 🔵 SIGNUP FIELDS
                              /// ----------------------------------------------------
                              if (!isLogin) ...[
                                _textField(
                                  controller: emailController,
                                  hint: "Email",
                                  isPassword: false,
                                  onEyeTap: null,
                                ),

                                const SizedBox(height: 15),

                                _textField(
                                  controller: pass1Controller,
                                  hint: "Password",
                                  isPassword: true,
                                  onEyeTap: () {
                                    setState(() {
                                      passwordVisible1 = !passwordVisible1;
                                    });
                                  },
                                  isVisible: passwordVisible1,
                                ),

                                const SizedBox(height: 15),

                                _textField(
                                  controller: pass2Controller,
                                  hint: "Re-enter Password",
                                  isPassword: true,
                                  onEyeTap: () {
                                    setState(() {
                                      passwordVisible2 = !passwordVisible2;
                                    });
                                  },
                                  isVisible: passwordVisible2,
                                ),

                                const SizedBox(height: 20),

                                /// SIGNUP BUTTON (YELLOW)
                                ElevatedButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      if (pass1Controller.text != pass2Controller.text) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text("Passwords do not match"),
                                          ),
                                        );
                                        return;
                                      }
                                     // context.go('/home');
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFFFD54F),
                                  ),
                                  child: const Text(
                                    "Sign Up Now",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.1),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }

  /// ------------------------------------------------------------
  /// CUSTOM TEXT FIELD FUNCTION WITH VALIDATION
  /// ------------------------------------------------------------
  Widget _textField({
    required TextEditingController controller,
    required String hint,
    required bool isPassword,
    required VoidCallback? onEyeTap,
    bool isVisible = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword ? !isVisible : false,

      validator: (value) {
        if (value == null || value.isEmpty) {
          return "$hint cannot be empty";
        }
        if (hint == "Email" && !value.contains("@")) {
          return "Enter a valid email";
        }
        return null;
      },

      style: const TextStyle(color: Colors.black),

      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white, // WHITE BACKGROUND ✔

        hintText: hint,
        hintStyle: const TextStyle(color: Colors.black54),

        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black26),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(12),
        ),

        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(
            isVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.black,
          ),
          onPressed: onEyeTap,
        )
            : null,
      ),
    );
  }
}


