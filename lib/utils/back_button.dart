import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBackButton extends StatelessWidget {
  final double size;

  const CustomBackButton({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: () => Get.back(),
        child: Container(
          width: size * 0.12,
          height: size * 0.12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFFFFC84F),
              width: 1.5,
            ),
          ),
          child: Center(
            child: Icon(
              Icons.chevron_left_outlined,
              color: const Color(0xFFFFC84F),
              size: size * 0.065,
            ),
          ),
        ),
      ),
    );
  }
}
