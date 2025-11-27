import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:story_hug/controller/fetchStoryController.dart';
import 'package:story_hug/repositories/FetchStoryRepo.dart';

import '../../CustomTopBar.dart';
import '../../app_routes/app_routes.dart';
import '../../components/CommonLoader.dart';
import '../../data/remote_data_source.dart';
import '../../utils/constants.dart';
import '../../utils/media_query_helper.dart';
import '../Widgets/SubCategoryCard.dart';
import '../Widgets/menuPannel.dart';

class StoryList extends StatefulWidget {
  const StoryList({super.key});

  @override
  State<StoryList> createState() => _StoryListState();
}

class _StoryListState extends State<StoryList> {
  bool showMenu = false;

  final FetchStoryController fetchStoryController = Get.put(
    FetchStoryController(
      fetchStoryRepo: FetchStoryImpl(remoteDataSource: RemoteDataSourceImpl()),
    ),
  );
  late final String catName;

  @override
  void initState() {
    super.initState();

    final args = Get.arguments as Map<String, dynamic>?;

    final String storyId = args?['storyId']?.toString() ?? '';
    catName = args?['name'] ?? 'Stories';

    if (storyId.isNotEmpty) {
      fetchStoryController.fetchStorys(storyId);
    } else {
      Get.snackbar("Error", "Category ID not found");
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double h = SizeConfig.screenHeight;
    final double w = SizeConfig.screenWidth;

    final bool isTablet = w > 600;
    final int gridCount = isTablet ? 2 : 1;

    return Scaffold(
      backgroundColor: const Color(0xFFACBCF1),
      body: Obx(() {
        // Loading State
        if (fetchStoryController.isLoading.value) {
          return const Center(child: DottedProgressWithLogo());
        }

        // Error State
        if (fetchStoryController.errorMessage.value != null) {
          return Center(
            child: Text(
              fetchStoryController.errorMessage.value!,
              style: const TextStyle(color: Colors.red, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          );
        }

        // Empty State
        final subCats = fetchStoryController.fetchStory.value?.stroy;
        if (subCats == null || subCats.isEmpty) {
          return const Center(
            child: Text(
              "No stories found in this category",
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
          );
        }

        // Success State - Show Grid
        return Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: h * 0.05),

                        // Top Bar
                        CustomTopBar(
                          showMenu: showMenu, // 👈 added
                          onMenuTap: () {
                            setState(
                              () => showMenu = !showMenu,
                            ); // 👈 toggle menu
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
                              gradient: LinearGradient(
                                colors: [Color(0xFFFCDB69), Color(0xFFFCBF5D)],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x3F303000),
                                  blurRadius: 8,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Text(
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

                        // Category Title
                        Center(
                          child: Text(
                            catName,
                            style: const TextStyle(
                              fontFamily: "Arial",
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
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
                    mainAxisSpacing: h * 0.025,
                    crossAxisSpacing: w * 0.04,
                    childCount: subCats.length,
                    itemBuilder: (context, index) {
                      final subCat = subCats[index];
                      return SubCategoryCommonCard(
                        content: subCat.content ?? "Untitled",
                        imageUrl: subCat.image,
                        title: capitalize(subCat.title ?? "Untitled"),
                        isTablet: isTablet,
                        onTap: () {
                          Get.toNamed(
                            Routes.StoryList,
                            arguments: {
                              'storyId': subCat.categoryId,
                              'catName': catName,
                              'name': subCat.content,
                            },
                          );
                        },
                      );
                    },
                  ),
                ),

                SliverToBoxAdapter(child: SizedBox(height: h * 0.1)),
              ],
            ),

            // Blur Overlay
            if (showMenu)
              Positioned.fill(
                child: GestureDetector(
                  onTap: () => setState(() => showMenu = false),
                  // child: BackdropFilter(
                  //   filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  //   child: Container(color: Colors.black.withOpacity(0.3)),
                  // ),
                ),
              ),

            // Sliding Menu
            AnimatedPositioned(
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeOutCubic,
              right: showMenu ? 0 : -w * 0.7,
              top: h * 0.1,
              child: MenuPanel(),
            ),
          ],
        );
      }),
    );
  }
}
