import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../utils/media_query_helper.dart';

class MenuPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final h = SizeConfig.screenHeight;
    final w = SizeConfig.screenWidth;

    return Container(
      width: w * 0.65,
      padding: EdgeInsets.symmetric(vertical: h * 0.02),
      decoration: const BoxDecoration(
        color: Color(0xFF3A3F92),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          bottomLeft: Radius.circular(40),
        ),
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _menuItem(Icons.person, "Profile", context),
          _menuItem(Icons.volume_up, "Voice", context),
          _menuItem(Icons.favorite, "My Favorites", context),
          _menuItem(Icons.workspace_premium, "Subscriptions", context),
          _menuItem(Icons.alarm, "Reminder", context),
          _menuItem(Icons.logout, "Logout", context),
        ],
      ),
    );
  }

  Widget _menuItem(IconData icon, String title, BuildContext context) {
    final h = SizeConfig.screenHeight;
    final w = SizeConfig.screenWidth;

    return InkWell(
      onTap: () {
        if (title == 'Profile') {
          context.push('/profile_screen');
        } else if (title == 'Voice') {
          context.push('/recording_voice');
        } else if (title == 'My Favorites') {
          context.push('/favorites');
        } else if (title == 'Subscriptions') {
          context.push('/subscribe');
        } else if (title == 'Reminder') {
          context.push('/reminders');
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
              Icon(icon, color: const Color(0xFF24305B)),
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