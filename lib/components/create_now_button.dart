import 'package:flutter/material.dart';
import 'package:story_hug/utils/media_query_helper.dart';
class CreateNowButton extends StatelessWidget {

  final String text;
  const CreateNowButton({super.key,required this.text});

  @override
  Widget build(BuildContext context) {
    var w=SizeConfig.screenWidth;
    var h=SizeConfig.screenHeight;
    return Padding(
      padding:  EdgeInsets.only(bottom: h * 0.04, left: w * 0.03, right: w * 0.026 ),
      child: Container(
        width: double.infinity,
        height: h * 0.065,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: ShapeDecoration(
          gradient: const LinearGradient(
            begin: Alignment(0.00, 0.50),
            end: Alignment(1.00, 0.50),
            colors: [
              Color(0xFFFCDB69),
              Color(0xFFFCBF5D),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 2,
              offset: Offset(0, 4),
              spreadRadius: 1,
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Color(0xFF24305B),
              fontSize: 18,
              fontFamily: 'Arial',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
