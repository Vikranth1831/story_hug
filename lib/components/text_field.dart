import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:story_hug/utils/media_query_helper.dart';

import '../../components/create_now_button.dart';
class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final String label1;

  const CustomInputField({super.key, required this.controller,required this.label1});

  @override
  Widget build(BuildContext context) {
    final h=SizeConfig.screenHeight;
    return Container(
      width: double.infinity,
      height: h * 0.065,
      padding: const EdgeInsets.symmetric(horizontal: 23),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 4,
            color: Color(0xFF98A2C5),
            strokeAlign: BorderSide.strokeAlignCenter,
          ),
          borderRadius: BorderRadius.circular(32),
        ),
      ),
      child: Theme(
        data: ThemeData(
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Color(0xFF98A2C5),
            selectionColor: Colors.transparent,
            selectionHandleColor: Color(0xFF98A2C5),
          ),
        ),
        child: TextField(
          controller: controller,
          style: const TextStyle(
            color: Color(0xFF666666),
            fontSize: 14,
            fontFamily: 'Arial',
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            hintText: label1,
            hintStyle: const TextStyle(
              color: Color(0xFF666666),
              fontSize: 14,
              fontFamily: 'Arial',
              fontWeight: FontWeight.w400,
            ),
            border: InputBorder.none,
            isCollapsed: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
    );
  }
}
