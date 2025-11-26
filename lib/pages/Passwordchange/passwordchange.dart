import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:go_router/go_router.dart';
import 'package:story_hug/components/text_field.dart';
import 'package:story_hug/controller/password_update_controller.dart';
import 'package:story_hug/repositories/update_password_repository.dart';

import '../../data/remote_data_source.dart';

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
  final UpdatePasswordController controller = Get.put(
    UpdatePasswordController(
      repository: UpdatePasswordRepositoryImpl(remoteDataSource: RemoteDataSourceImpl()),
    ),
  );
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xFF192346),

      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          reverse: true,              // prevents overflow on keyboard
          child: Container(
            width: double.infinity,
            //height: MediaQuery.of(context).size.height,

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
                InkWell(
                  onTap: ()
                  {
                    context.pop();
                  },
                  child: Padding(
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

                      CustomInputField(controller: newPass, label1: 'password'),
                      if (newPassError != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            newPassError!,
                            style: TextStyle(color: Colors.redAccent, fontSize: 12),
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

                      CustomInputField(controller: confirmPass, label1: 'password'),
                      if (confirmPassError != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            confirmPassError!,
                            style: TextStyle(color: Colors.redAccent, fontSize: 12),
                          ),
                        ),

                      SizedBox(height: 26),

                      Center(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              newPassError = null;
                              confirmPassError = null;

                              String p1 = newPass.text.trim();
                              String p2 = confirmPass.text.trim();

                              bool hasError = false;

                              if (p1.length < 5) {
                                newPassError = "Password must be at least 5 characters.";
                                hasError = true;
                              }

                              if (p2.length < 5) {
                                confirmPassError = "Password must be at least 5 characters.";
                                hasError = true;
                              }

                              if (!hasError && p1 != p2) {
                                confirmPassError = "Passwords do not match.";
                                hasError = true;
                              }

                              if (!hasError) {

                                controller.updatepassword({
                                  "password": p1,
                                  "confirm_password":p2
                                });
                              }
                            });
                          },

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
