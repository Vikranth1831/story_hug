import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:story_hug/CustomTopBar.dart';
import 'package:story_hug/controller/CategoryController.dart';
import 'package:story_hug/pages/profile.dart';
import 'package:story_hug/repositories/CategoryRepo.dart';
import 'package:story_hug/utils/media_query_helper.dart';

import '../../components/CommonLoader.dart';
import '../../data/remote_data_source.dart';
import '../../utils/spinkittsLoader.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showMenu = false;
  final CategoryController categoryController = Get.put(
    CategoryController(
      categoryrepo: CategoryImpl(remoteDataSource: RemoteDataSourceImpl()),
    ),
  );

  @override
  void initState() {
    categoryController.fetchCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double h = SizeConfig.screenHeight;
    final double w = SizeConfig.screenWidth;

    bool isTablet = w > 600;
    int gridCount = isTablet ? 4 : 2;

    final double imageHeight = isTablet ? h * 0.20 : h * 0.16;
    final double verticalPadding = w * 0.03;
    final double textHeight = 32; // 2 lines approx

    final double cardHeight =
        imageHeight + (verticalPadding * 2) + 22 + textHeight;

    final double cardWidth = w / gridCount;

    final double aspectRatio = cardWidth / cardHeight;


    return Scaffold(
      backgroundColor: const Color(0xFFACBCF1),

      body: Obx(() {
        if (categoryController.isLoading.value) {
          return Center(child: DottedProgressWithLogo());
        }
        final data = categoryController.category.value?.categories;

        if (data == null || data.isEmpty) {
          return const Center(
            child: Text(
              "No categories found",
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
          );
        }
        return Stack(
          children: [
            Column(
              children: [
                SizedBox(height: h * 0.03),

                CustomTopBar(
                  onMenuTap: () {
                    setState(() => showMenu = true);
                  },
                ),

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

                      SliverPadding(
                        padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                        sliver: SliverGrid(
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            final cat = data[index];

                            return GestureDetector(
                              onTap: () {
                                context.push('/select');
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFF59399),
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
                                      child: CachedNetworkImage(
                                        imageUrl: cat.image ?? "",
                                        width: double.infinity,
                                        height: isTablet ? h * 0.20 : h * 0.16,
                                        fit: BoxFit.cover,

                                        placeholder: (context, url) => SizedBox(
                                          width: double.infinity,
                                          height: isTablet
                                              ? h * 0.20
                                              : h * 0.16,
                                          child: Center(
                                            child: spinkits
                                                .getSpinningLinespinkit(),
                                          ),
                                        ),

                                        errorWidget: (context, url, error) =>
                                            Container(
                                              width: double.infinity,
                                              height: isTablet
                                                  ? h * 0.20
                                                  : h * 0.16,
                                              color: const Color(0xffF8FAFE),
                                              alignment: Alignment.center,
                                              child: Icon(
                                                Icons.broken_image_outlined,
                                                size: 48,
                                                color: Colors.grey.shade500,
                                              ),
                                            ),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      cat.categoryName ?? "",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Color(0xff333333),
                                        fontSize: 14,
                                        fontFamily: "Arial",
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }, childCount: data.length),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: gridCount,
                                childAspectRatio: aspectRatio,
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
        );
      }),
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
          Get.to(ProfileScreen());
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
