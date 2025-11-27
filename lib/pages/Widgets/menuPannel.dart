import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:go_router/go_router.dart';

import '../../app_routes/app_routes.dart';
import '../../utils/color_constants.dart';
import '../../utils/media_query_helper.dart';
import '../profile.dart';
import 'LogOut.dart';

class MenuPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final h = SizeConfig.screenHeight;
    final w = SizeConfig.screenWidth;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: w * 0.65,
        padding: EdgeInsets.symmetric(vertical: h * 0.02),
        decoration: const BoxDecoration(
          color: Color(0xFF3A3F92),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _menuItem("Vector (1).png", "Profile", context),
            _menuItem("SpeakerHigh.png", "Voice", context),
            _menuItem("Heart.png", "My Favorites", context),
            _menuItem("CrownSimple.png", "Subscriptions", context),
            _menuItem("Alarm.png", "Reminder", context),
            _menuItem("SignOut.png", "Logout", context),
          ],
        ),
      ),
    );
  }

  Widget _menuItem(String path, String title, BuildContext context) {
    final h = SizeConfig.screenHeight;
    final w = SizeConfig.screenWidth;

    return InkWell(
      onTap: () {
        if (title == 'Profile') {
          Get.to(() => ProfileScreen());
        } else if (title == 'Voice') {
          context.push('/recording_voice');
        } else if (title == 'My Favorites') {
          Get.toNamed(Routes.Favorites);
        } else if (title == 'Subscriptions') {
          Get.toNamed(Routes.Subscribepage);
        } else if (title == 'Reminder') {
          context.push('/reminders');
        } else if (title == 'Logout') {
          showDialog(
            context: Navigator.of(context, rootNavigator: true).context,
            builder: (_) => LogoutDialog(primaryColor: primarycolor),
          );
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: h * 0.01),
        child: Container(
          height: h * 0.065,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: const LinearGradient(
              colors: [Color(0xFFFCDB69), Color(0xFFFCBF5D)],
            ),
          ),

          child: Row(
            children: [
              SizedBox(width: w * 0.05),
              Image.asset(
                'assets/images/${path}',
                height: (title == 'Profile') ? h * 0.03 : h * 0.04,
              ),
              SizedBox(width: w * 0.05),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF24305B),
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
