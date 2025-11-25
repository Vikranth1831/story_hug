import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:story_hug/CustomTopBar.dart';
import 'package:story_hug/controller/SubCategoryController.dart';
import 'package:story_hug/utils/media_query_helper.dart';
import 'package:story_hug/utils/spinkittsLoader.dart';

import '../../components/CommonLoader.dart';
import '../../data/remote_data_source.dart';
import '../../repositories/SubCategoryRepo.dart';
import 'Home.dart';

class SubCategory extends StatefulWidget {
  const SubCategory({super.key});

  @override
  State<SubCategory> createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
  bool showMenu = false;

  final SubCategoryController subCategoryController = Get.put(
    SubCategoryController(
      subCategoryrepo: SubCategoryImpl(
        remoteDataSource: RemoteDataSourceImpl(),
      ),
    ),
  );
  late final String catName;

  @override
  void initState() {
    super.initState();

    final args = Get.arguments as Map<String, dynamic>?;

    final String catId = args?['id']?.toString() ?? '';
    catName = args?['name'] ?? 'Stories';

    if (catId.isNotEmpty) {
      subCategoryController.fetchSubCategory(catId);
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


    double getResponsiveAspectRatio() {
      if (w < 600) {
        // Mobile: slightly taller than square
        return 0.80; // width / height → makes card taller (good for image + text)
      } else if (w < 1000) {
        // Tablet
        return 0.85;
      } else {
        // Large tablet / desktop
        return 0.90;
      }
    }

    final double childAspectRatio = getResponsiveAspectRatio();
    return Scaffold(
      backgroundColor: const Color(0xFFACBCF1),
      body: Obx(() {
        // Loading State
        if (subCategoryController.isLoading.value) {
          return const Center(child: DottedProgressWithLogo());
        }

        // Error State
        if (subCategoryController.errorMessage.value != null) {
          return Center(
            child: Text(
              subCategoryController.errorMessage.value!,
              style: const TextStyle(color: Colors.red, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          );
        }

        // Empty State
        final subCats = subCategoryController.subCategory.value?.subCategories;
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
                          onMenuTap: () => setState(() => showMenu = true),
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

                // Dynamic Grid of Subcategories
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: gridCount,
                      childAspectRatio: childAspectRatio,
                      crossAxisSpacing: w * 0.04,
                      mainAxisSpacing: h * 0.025,
                    ),
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final subCat = subCats[index];

                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(
                            '/view_cards',
                            arguments: {
                              'subCatId': subCat.id,
                              'title': subCat.subcategoryName,
                              'image': subCat.image,
                            },
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xffFFF3C5),
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Image
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(24),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: subCat.image ?? "",
                                  height: isTablet ? h * 0.28 : h * 0.3,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  placeholder: (_, __) => Center(
                                    child: spinkits.getSpinningLinespinkit(),
                                  ),
                                  errorWidget: (_, __, ___) => Container(
                                    color: Colors.grey[300],
                                    child: const Icon(
                                      Icons.broken_image,
                                      size: 50,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.all(w * 0.04),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      subCat.subcategoryName ?? "Untitled",
                                      style: const TextStyle(
                                        fontFamily: "Arial Rounded MT Bold",
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "Tap to read stories",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black54,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }, childCount: subCats.length),
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
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(color: Colors.black.withOpacity(0.3)),
                  ),
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
