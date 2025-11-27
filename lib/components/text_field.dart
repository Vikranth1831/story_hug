import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:story_hug/utils/media_query_helper.dart';

import '../../components/create_now_button.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final String label1;

  const CustomInputField({
    super.key,
    required this.controller,
    required this.label1,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
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
          filled: true,
          fillColor: Color(0xffFFFFFF),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(color: Color(0xFF98A2C5), width: 4),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(color: Color(0xFF98A2C5), width: 4),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(color: Color(0xFF98A2C5), width: 4),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(color: Color(0xFF98A2C5), width: 4),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(color: Color(0xFF98A2C5), width: 4),
          ),
          isCollapsed: true,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
        ),
      ),
    );
  }
}
