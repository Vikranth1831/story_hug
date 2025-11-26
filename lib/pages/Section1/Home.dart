import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:story_hug/CustomTopBar.dart';
import 'package:story_hug/controller/CategoryController.dart';
import 'package:story_hug/repositories/CategoryRepo.dart';
import 'package:story_hug/utils/media_query_helper.dart';

import '../../app_routes/app_routes.dart';
import '../../components/CommonLoader.dart';
import '../../data/remote_data_source.dart';
import '../../utils/spinkittsLoader.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../Widgets/menuPannel.dart';

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
    int gridCount = isTablet
        ? (w > 1000 ? 5 : 4)
        : 2; // Better for large tablets & web


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
                  }, showMenu: showMenu,
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
                        sliver: SliverMasonryGrid.count(
                          crossAxisCount: gridCount,
                          mainAxisSpacing: h * 0.02,
                          crossAxisSpacing: w * 0.03,
                          childCount: data.length,
                          itemBuilder: (context, index) {
                            final cat = data[index];

                            return GestureDetector(
                              onTap: () {
                                Get.toNamed(
                                  Routes.SelectedCardView,
                                  arguments: {
                                    'id': cat.id,
                                    'name': cat.categoryName,
                                  },
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF59399),
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
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: CachedNetworkImage(
                                        imageUrl: cat.image ?? "",
                                        width: double.infinity,
                                        height: isTablet ? 180 : 130, // 🔒 FIXED HEIGHT
                                        fit: BoxFit.cover,
                                        placeholder: (_, __) => SizedBox(
                                          width: double.infinity,
                                          height: isTablet ? 180 : 130,
                                          child: Center(
                                            child: spinkits.getSpinningLinespinkit(),
                                          ),
                                        ),
                                        errorWidget: (_, __, ___) => Container(
                                          width: double.infinity,
                                          height: isTablet ? 180 : 130,
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
                                    const SizedBox(height: 8),
                                    Text(
                                      cat.categoryName ?? "",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
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
                          },
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
                  // child: BackdropFilter(
                  //   filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  //   child: Container(color: Colors.black.withOpacity(0.25)),
                  // ),
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
