import 'package:flutter/material.dart';
import 'package:story_hug/utils/color_constants.dart';

import 'package:flutter/material.dart';

class AppSnackBar {
  static void show(BuildContext context, String message,
      {Color bgColor = primarycolor,
        Color textColor = Colors.white,
        int durationSeconds = 2}) {

    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: textColor),
      ),
      backgroundColor: bgColor,
      duration: Duration(seconds: durationSeconds),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(
        top: 20,
        left: 12,
        right: 12,
        bottom: 40,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}

