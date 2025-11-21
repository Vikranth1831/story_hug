import 'package:flutter/widgets.dart';

class AppResponsive {
  static bool isPhone(BuildContext context) =>
      MediaQuery
          .sizeOf(context)
          .width < 600;

  static bool isTablet(BuildContext context) {
    double w = MediaQuery
        .sizeOf(context)
        .width;
    return w >= 600 && w < 1024;
  }

  static bool isDesktop(BuildContext context) {
    double w = MediaQuery
        .sizeOf(context)
        .width;
    return w >= 1200;
  }

}