import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:go_router/go_router.dart';
import 'package:story_hug/CustomTopBar.dart';
import 'package:story_hug/pages/Widgets/SubSubCategoryCard.dart';
import 'package:story_hug/utils/media_query_helper.dart';

import 'dart:ui';

import '../Widgets/menuPannel.dart';

class SubSubCategory extends StatefulWidget {
  const SubSubCategory({super.key});

  @override
  State<SubSubCategory> createState() => _SubSubCategoryState();
}

class _SubSubCategoryState extends State<SubSubCategory> {
  bool isTablet = false;
  bool showMenu = false;

  @override
  Widget build(BuildContext context) {
    final double h = SizeConfig.screenHeight;
    final double w = SizeConfig.screenWidth;

    isTablet = w > 600;

    return Scaffold(
      extendBodyBehindAppBar: true,

      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,

            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.0, 0.17, 0.40, 0.66, 0.94],
                colors: [
                  Color(0xFF303174),
                  Color(0xFF5067AB),
                  Color(0xFF7A7BA4),
                  Color(0xFFF7DCAD),
                  Color(0xFFE3C6D3),
                ],
              ),
            ),

            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: w * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //-------------------------------------------------
                      // CUSTOM TOP BAR WITH MENU BUTTON
                      //-------------------------------------------------
                      CustomTopBar(
                        showMenu: showMenu,        // 👈 added
                        onMenuTap: () {
                          setState(() => showMenu = !showMenu);  // 👈 toggle menu
                        },
                      ),

                      //-------------------------------------------------
                      // BACK BUTTON
                      //-------------------------------------------------
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: isTablet ? 14 : 10,
                                horizontal: isTablet ? 22 : 18,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
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
                                "Back",
                                style: TextStyle(
                                  fontFamily: "Arial",
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF24305B),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      const Center(
                        child: Text(
                          "Indian Mythology",
                          style: TextStyle(
                            fontFamily: "Arial",
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Center(
                        child: Text(
                          "Ramayana",
                          style: TextStyle(
                            fontFamily: "Arial",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffFBD767),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),
                      CustomScrollView(
                        slivers: [
                          SliverPadding(
                            padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                            sliver: SliverMasonryGrid.count(
                              crossAxisCount: isTablet ? 2 : 1,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 20,
                              childCount: 6,
                              itemBuilder: (context, index) {
                                return SubSubCategoryCard(
                                  index: index,
                                  isTablet: isTablet,
                                  onPlayTap: () {
                                    Get.toNamed(
                                      '/play_card',

                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ),

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
