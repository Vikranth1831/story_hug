import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:story_hug/utils/AppLogger.dart';
import 'package:story_hug/utils/constants.dart';
import '../../app_routes/app_routes.dart';
import '../../components/CommonLoader.dart';
import '../../controller/SubSubCategoryContoller.dart';
import '../../data/remote_data_source.dart';
import '../../repositories/SubSubCategoryRepo.dart';
import '../Widgets/SubSubCategoryCard.dart';
import '../Widgets/menuPannel.dart';
import 'package:story_hug/CustomTopBar.dart';
import 'package:story_hug/utils/media_query_helper.dart';

class SubSubCategory extends StatefulWidget {
  const SubSubCategory({super.key});

  @override
  State<SubSubCategory> createState() => _SubSubCategoryState();
}

class _SubSubCategoryState extends State<SubSubCategory> {
  bool showMenu = false;
  bool isTablet = false;

  final SubSubCategoryController controller = Get.put(
    SubSubCategoryController(
      subSubCategoryrepo: SubSubCategoryImpl(
        remoteDataSource: RemoteDataSourceImpl(),
      ),
    ),
  );

  late String catName;
  late String categoryName;

  @override
  void initState() {
    super.initState();

    final args = Get.arguments as Map<String, dynamic>?;

    final String catId = args?['id']?.toString() ?? '';
    catName = args?['name'] ?? "Stories";
    categoryName = args?['catName'] ?? "Stories";

    if (catId.isNotEmpty) {
      controller.fetchSubSubCategory(catId);
    } else {
      Get.snackbar("Error", "Category ID not found");
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    final w = SizeConfig.screenWidth;
    final h = SizeConfig.screenHeight;
    isTablet = w > 600;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFFFFFFF), Color(0xFFFFFFFF)],
              ),
            ),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF303174), // 0%
                    Color(0xFF5067AB), // 17.1%
                    Color(0xFF7A7BA4), // 40.4%
                    Color(0xFFF7DCAD), // 65.95%
                    Color(0xFFE3C6D3), // 94.18%
                  ],
                  stops: [0.0, 0.171, 0.404, 0.6595, 0.9418],
                ),
              ),
            ),
          ),

          Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: DottedProgressWithLogo());
            }

            if (controller.errorMessage.value != null) {
              return Center(
                child: Text(
                  controller.errorMessage.value!,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
              );
            }

            final list = controller.subSubCategory.value?.subofSubCategories;

            if (list == null || list.isEmpty) {
              return const Center(
                child: Text(
                  "No stories found in this category",
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
              );
            }

            return SafeArea(
              child: CustomScrollView(
                slivers: [
                  // ======================================================
                  // TOP HEADER + BACK BUTTON
                  // ======================================================
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.05),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        CustomTopBar(
                          showMenu: showMenu,
                          onMenuTap: () {
                            setState(() => showMenu = !showMenu);
                          },
                        ),

                        SizedBox(height: h * 0.02),

                        // Back Button
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: h * 0.012,
                              horizontal: w * 0.05,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: const LinearGradient(
                                colors: [Color(0xFFFCDB69), Color(0xFFFCBF5D)],
                              ),
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

                        SizedBox(height: h * 0.03),
                        Center(
                          child: Text(
                            capitalize(categoryName),
                            style: const TextStyle(
                              fontFamily: "Arial",
                              fontSize: 28,
                              fontWeight: FontWeight.w400,
                              color: Color(0xffF5F5F5),
                            ),
                          ),
                        ),
                        SizedBox(height: h * 0.01),
                        Center(
                          child: Text(
                            capitalize(catName),
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                              color: Color(0xffFBD767),
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),
                      ]),
                    ),
                  ),

                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.05),
                    sliver: SliverMasonryGrid.count(
                      crossAxisCount: isTablet ? 2 : 1,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childCount: list.length,
                      itemBuilder: (context, index) {
                        final item = list[index];
                        return SubSubCategoryCard(showFav: false,
                          index: index,
                          isTablet: isTablet,
                          title: item.subofSubcategoryName ?? "Untitled",
                          imageUrl: item.image ?? "",
                          duration: 10,
                          onTap: () {
                            Get.toNamed(
                              Routes.StoryList,
                              arguments: {'id': item.id, 'name': item.subofSubcategoryName,},
                            );
                          },
                        );
                      },
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 30)),
                ],
              ),
            );
          }),
          if (showMenu)
            Positioned.fill(
              child: GestureDetector(
                onTap: () => setState(() => showMenu = false),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: Container(color: Colors.black26),
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
