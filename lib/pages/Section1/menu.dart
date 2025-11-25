import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:story_hug/CustomTopBar.dart';
import 'package:story_hug/pages/profile.dart';
import 'package:story_hug/utils/media_query_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showMenu = false;

  @override
  Widget build(BuildContext context) {
    final double h = SizeConfig.screenHeight;
    final double w = SizeConfig.screenWidth;

    bool isTablet = w > 600;
    int gridCount = isTablet ? 4 : 2;

    final List<Map<String, dynamic>> items = [
      {
        "title": "Indian Mythology & Divine Stories",
        "image": "assets/images/mytholgy.png",
        "color": const Color(0xFFF59399),
      },
      {
        "title": "Indian Kings & Warriors Stories",
        "image": "assets/images/mytholgy.png",
        "color": const Color(0xFFFDD33B),
      },
      {
        "title": "Motivational & Success Stories",
        "image": "assets/images/mytholgy.png",
        "color": const Color(0xFFFAF4EA),
      },
      {
        "title": "Great Inventions & Inventors",
        "image": "assets/images/mytholgy.png",
        "color": const Color(0xFFD6D7FF),
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFACBCF1),

      body: Stack(
        children: [

          /// --------------------------------------------------------------
          /// 1️⃣ MAIN PAGE CONTENT (AppBar + Body)
          /// --------------------------------------------------------------
          Column(
            children: [
              SizedBox(height: h * 0.03,),

              /// CUSTOM APP BAR
              CustomTopBar(
                onMenuTap: () {
                  setState(() => showMenu = true);
                },
              ),

              /// BODY
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: h * 0.02),

                            const Text(
                              "Hello",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Arial",
                              ),
                            ),

                            SizedBox(height: h * 0.005),

                            const Text(
                              "Vikranth",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 38,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Arial",
                              ),
                            ),

                            SizedBox(height: h * 0.03),
                          ],
                        ),
                      ),
                    ),

                    /// GRID
                    SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                      sliver: SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                              (context, index) {
                            final item = items[index];

                            return GestureDetector(
                              onTap: ()
                              {
                                context.push('/select');
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: item["color"],
                                  borderRadius: BorderRadius.circular(22),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x3F000000),
                                      blurRadius: 4,
                                    ),
                                    BoxShadow(
                                      color: Color(0x99000000),
                                      blurRadius: 8,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.all(w * 0.03),

                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.asset(
                                        item["image"],
                                        height: isTablet
                                            ? h * 0.20
                                            : h * 0.16,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),

                                    SizedBox(height: h * 0.015),

                                    Text(
                                      item["title"],
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontFamily:
                                        "Arial",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          childCount: items.length,
                        ),
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: gridCount,
                          childAspectRatio: 0.75,
                          crossAxisSpacing: w * 0.03,
                          mainAxisSpacing: h * 0.02,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          /// --------------------------------------------------------------
          /// 2️⃣ BLUR BACKGROUND WHEN MENU IS OPEN
          /// --------------------------------------------------------------
          if (showMenu)
            Positioned.fill(
              child: GestureDetector(
                onTap: () => setState(() => showMenu = false),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: Container(color: Colors.black.withOpacity(0.25)),
                ),
              ),
            ),

          /// --------------------------------------------------------------
          /// 3️⃣ RIGHT-SIDE SLIDING MENU (OVER EVERYTHING)
          /// --------------------------------------------------------------
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            right: showMenu ? 0 : -w * 0.65,
            top: h * 0.10,
            child: MenuPanel(),
          ),
        ],
      ),
    );
  }
}

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
          _menuItem(Icons.person, "Profile",context),
          _menuItem(Icons.volume_up, "Voice",context),
          _menuItem(Icons.favorite, "My Favorites",context),
          _menuItem(Icons.workspace_premium, "Subscriptions",context),
          _menuItem(Icons.alarm, "Reminder",context),
          _menuItem(Icons.logout, "Logout",context),
        ],
      ),
    );
  }

  Widget _menuItem(IconData icon, String title,BuildContext context) {
    final h = SizeConfig.screenHeight;
    final w = SizeConfig.screenWidth;

    return InkWell(
      onTap: ()
      {
        if(title=='Profile')
          {
            //context.push('/profile_screen');
            Get.to(()=>ProfileScreen());
          }
        else if(title=='Voice')
          {
            context.push('/recording_voice');
          }
        else if(title=='My Favorites')
          {
            context.push('/favorites');
          }
        else if(title=='Subscriptions')
        {
          context.push('/subscribe');
        }
        else if(title=='Reminder')
        {
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

