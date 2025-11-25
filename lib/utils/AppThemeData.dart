import 'package:flutter/material.dart';

import 'color_constants.dart';

class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,

      textSelectionTheme: TextSelectionThemeData(
        cursorColor: primarycolor,
        selectionColor: primarycolor.withOpacity(0.3),
        selectionHandleColor: primarycolor,
      ),

      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,

      scaffoldBackgroundColor: Colors.white,
      dialogBackgroundColor: Colors.white,
      cardColor: Colors.white,

      searchBarTheme:  SearchBarThemeData(),
      tabBarTheme:  TabBarThemeData(),

      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          color: hintColor,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontFamily: "Inter",
        ),
        labelStyle: TextStyle(
          color: labeltextColor,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          fontFamily: "Inter",
        ),
        filled: true,
        fillColor: Colors.black,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide(color: Color(0xff7C7C7C), width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide(color: Color(0xff7C7C7C), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide(color: Color(0xff7C7C7C), width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide(color: Color(0xff7C7C7C), width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide(color: Color(0xff7C7C7C), width: 1),
        ),
        errorStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
      ),

      dialogTheme:  DialogThemeData(
        shadowColor: Colors.white,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
      ),

      buttonTheme: const ButtonThemeData(),
      popupMenuTheme: const PopupMenuThemeData(
        color: Colors.white,
        shadowColor: Colors.white,
      ),

      appBarTheme: const AppBarTheme(surfaceTintColor: Colors.white),

      cardTheme:  CardThemeData(
        shadowColor: Colors.white,
        surfaceTintColor: Colors.white,
        color: Colors.white,
      ),

      textButtonTheme: TextButtonThemeData(style: ButtonStyle()),
      elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle()),
      outlinedButtonTheme: OutlinedButtonThemeData(style: ButtonStyle()),

      bottomSheetTheme: const BottomSheetThemeData(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
      ),

      colorScheme: const ColorScheme.light(
        background: Colors.white,
      ).copyWith(background: Colors.white),

      fontFamily: 'segeo',
    );
  }
}
