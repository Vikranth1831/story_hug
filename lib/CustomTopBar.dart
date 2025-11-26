import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:story_hug/pages/Section1/Home.dart';
import 'package:story_hug/utils/media_query_helper.dart';

class CustomTopBar extends StatelessWidget {
  final VoidCallback onMenuTap;
  final bool showMenu; // 👈 added

  const CustomTopBar({
    super.key,
    required this.onMenuTap,
    required this.showMenu, // 👈 added
  });

  @override
  Widget build(BuildContext context) {
    final h = SizeConfig.screenHeight;
    final w = SizeConfig.screenWidth;

    return Container(
      height: h * 0.10,
      padding: const EdgeInsets.only(top: 15, left: 8, right: 8, bottom: 8),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          /// LOGO
          Image.asset(
            "assets/images/appbarlogo.png",
            height: h * 0.16,
            width: w * 0.18,
          ),

          /// RIGHT SIDE
          Row(
            children: [
              /// 3 CREDITS
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: h * 0.008, horizontal: w * 0.03),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFCDB69), Color(0xFFFCBF5D)],
                  ),
                ),
                child: const Text(
                  "3 Credits",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF24305B),
                  ),
                ),
              ),

              SizedBox(width: w * 0.03),

              /// MENU BUTTON (changed icon only)
              GestureDetector(
                onTap: onMenuTap,
                child: Container(
                  padding: EdgeInsets.all(w * 0.025),
                  decoration: const BoxDecoration(
                    color: Color(0xFF6067BC),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    showMenu ? Icons.close : Icons.menu,   // 👈 only change
                    color: Colors.amber,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


