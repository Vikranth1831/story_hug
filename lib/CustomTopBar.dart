import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:story_hug/utils/media_query_helper.dart';

class CustomTopBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomTopBar({super.key});

  @override
  State<CustomTopBar> createState() => _CustomTopBarState();

  @override
  Size get preferredSize => Size.fromHeight(SizeConfig.screenHeight * 0.10);
}

class _CustomTopBarState extends State<CustomTopBar> {
  bool showMenu = false;

  @override
  Widget build(BuildContext context) {
    final double h = SizeConfig.screenHeight;
    final double w = SizeConfig.screenWidth;

    return Stack(
      children: [

        /// --------------------------------------
        /// 🔵 TOP BAR UI
        /// --------------------------------------
        Padding(
          padding: const EdgeInsets.only(top: 15, left: 8, right: 8, bottom: 8),
          child: Container(
            height: h * 0.10,
            padding: EdgeInsets.symmetric(horizontal: w * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                /// LOGO
                Image.asset(
                  "assets/images/appbarlogo.png",
                  height: h * 0.09,
                  width: w * 0.2,
                ),

                /// RIGHT SIDE
                Row(
                  children: [

                    /// 3 CREDITS PILL
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: h * 0.008,
                        horizontal: w * 0.03,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFFCDB69),
                            Color(0xFFFCBF5D),
                          ],
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x3F303000),
                            blurRadius: 8,
                            offset: Offset(0, 3),
                          ),
                        ],
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

                    /// MENU ICON BUTTON
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showMenu = true;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(w * 0.025),
                        decoration: const BoxDecoration(
                          color: Color(0xFF6067BC),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.menu,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),

        /// --------------------------------------
        /// 🌫 BACKGROUND BLUR + CLOSE
        /// --------------------------------------
        if (showMenu)
          Positioned.fill(
            child: GestureDetector(
              onTap: () => setState(() => showMenu = false),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Container(
                  color: Colors.black.withOpacity(0.2),
                ),
              ),
            ),
          ),

        /// --------------------------------------
        /// 🟣 RIGHT SIDE POPUP MENU
        /// --------------------------------------
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          right: showMenu ? 0 : -w * 0.65,
          top: h * 0.06,
          child: Container(
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
                _menuItem(Icons.person, "Profile", () {}),
                _menuItem(Icons.volume_up, "Voice", () {}),
                _menuItem(Icons.favorite, "My Favorites", () {}),
                _menuItem(Icons.workspace_premium, "Subscriptions", () {}),
                _menuItem(Icons.alarm, "Reminder", () {}),
                _menuItem(Icons.logout, "Logout", () {}),
              ],
            ),
          ),
        ),

      ],
    );
  }

  /// --------------------------------------
  /// MENU CARD WIDGET
  /// --------------------------------------
  Widget _menuItem(IconData icon, String title, VoidCallback onTap) {
    final double h = SizeConfig.screenHeight;
    final double w = SizeConfig.screenWidth;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: h * 0.01),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: h * 0.065,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: const LinearGradient(
              colors: [
                Color(0xFFFCDB69),
                Color(0xFFFCBF5D),
              ],
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x3F303000),
                blurRadius: 6,
                offset: Offset(2, 3),
              ),
            ],
          ),

          child: Row(
            children: [
              SizedBox(width: w * 0.05),
              Icon(icon, color: Color(0xFF24305B)),
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
