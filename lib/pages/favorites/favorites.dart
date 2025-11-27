import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:story_hug/controller/faverateController.dart';
import 'package:story_hug/repositories/faveratesRepo.dart';
import 'package:story_hug/utils/media_query_helper.dart';

import '../../app_routes/app_routes.dart';
import '../../components/CommonLoader.dart';
import '../../data/remote_data_source.dart';
import '../Widgets/SubSubCategoryCard.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  final FaverateListController faverateListController = Get.put(
    FaverateListController(
      faveratesListRepo: FaveratesListImpl(
        remoteDataSource: RemoteDataSourceImpl(),
      ),
    ),
  );

  final AddToFaverateController addToFaverateController = Get.put(
    AddToFaverateController(
      faveratesListRepo: FaveratesListImpl(
        remoteDataSource: RemoteDataSourceImpl(),
      ),
    ),
  );

  @override
  void initState() {
    super.initState();
    faverateListController.fetchFaveratesList("1");
  }

  @override
  Widget build(BuildContext context) {
    final double h = SizeConfig.screenHeight;
    final double w = SizeConfig.screenWidth;

    bool isTablet = w > 600;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bgimage.png"),
            fit: BoxFit.cover,
          ),
        ),

        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: h * 0.06),

                Image.asset(
                  "assets/images/favoritesimage.png",
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: h * 0.03),

                Text(
                  "Your Favorites",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isTablet ? 32 : 26,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Arial",
                  ),
                ),

                SizedBox(height: h * 0.01),

                // Grid Items
                Obx(() {
                  if (faverateListController.isLoading.value) {
                    return const Center(child: DottedProgressWithLogo());
                  }
                  if (faverateListController.errorMessage.value != null) {
                    return Center(
                      child: Text(
                        faverateListController.errorMessage.value!,
                        style: const TextStyle(color: Colors.red, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                  final fav =
                      faverateListController.favrateList.value?.favourate;
                  if (fav == null || fav.isEmpty) {
                    return const Center(
                      child: Text(
                        "No fav list found in this category",
                        style: TextStyle(fontSize: 18, color: Colors.black54),
                      ),
                    );
                  } else {
                    return SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: w * 0.05),
                      sliver: SliverMasonryGrid.count(
                        crossAxisCount: isTablet ? 2 : 1,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        childCount: fav.length,
                        itemBuilder: (context, index) {
                          final item = fav[index];
                          return SubSubCategoryCard(
                            index: index,
                            isTablet: isTablet,
                            title:item.story?.title??"",
                            imageUrl: item.story?.image??"",
                            duration: 10,
                            onPlayTap: () {
                              Get.toNamed(
                                Routes.PlayStory,
                                arguments: {'id': item.id},
                              );
                            },
                          );
                        },
                      ),
                    );
                  }
                }),

                SizedBox(height: h * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
