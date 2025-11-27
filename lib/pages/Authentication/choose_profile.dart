import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:story_hug/components/create_now_button.dart';
import 'package:story_hug/controller/select_child_controller.dart';
import 'package:story_hug/repositories/select_child_repository.dart';
import 'package:story_hug/utils/media_query_helper.dart';

import '../../app_routes/app_routes.dart';
import '../../controller/getAllChildrenController.dart';
import '../../data/remote_data_source.dart';
import '../../repositories/get_all_children_repository.dart'; // Your SizeConfig
class ChooseProfile extends StatefulWidget {
  const ChooseProfile({super.key});

  @override
  State<ChooseProfile> createState() => _ChooseProfileState();
}

class _ChooseProfileState extends State<ChooseProfile> {
  int? selectedIndex;

  final Getallchildrencontroller controller = Get.put(
    Getallchildrencontroller(
      repository: GetAllChildrenRepositoryImpl(
        remoteDataSource: RemoteDataSourceImpl(),
      ),
    ),
  );

  final SelectChildController selectcontroller = Get.put(
    SelectChildController(
      repository: SelectChildRepositoryImpl(remoteDataSource: RemoteDataSourceImpl()),
    ),
  );

  @override
  void initState() {
    super.initState();
    controller.getAllChildren();   // 🔥 API CALL
  }

  bool isTablet(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width >= 600;
  }

  @override
  Widget build(BuildContext context) {
    controller.getAllChildren();
    final double h = SizeConfig.screenHeight;
    final double w = SizeConfig.screenWidth;

    final bool tablet = isTablet(context);

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/background_for_login.png",
              fit: BoxFit.cover,
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                SizedBox(height: h * 0.04),

                Column(
                  children: [
                    Text(
                      "Welcome",
                      style: TextStyle(
                        fontFamily: "Arial",
                        fontSize: w * 0.085,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Akhil",
                      style: TextStyle(
                        fontFamily: "Arial",
                        fontSize: w * 0.06,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: h * 0.06),

                Text(
                  "Choose Profile",
                  style: TextStyle(
                    fontFamily: "Arial",
                    fontSize: w * 0.06,
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withOpacity(0.95),
                  ),
                ),

                SizedBox(height: h * 0.03),

                SizedBox(
                  height: h * 0.5,
                  child: Expanded(
                    child: Obx(() {
                      if (controller.isLoading.value) {
                        return const Center(child: CircularProgressIndicator(color: Colors.white));
                      }

                      if (controller.childrenList.isEmpty) {
                        return const Center(
                          child: Text(
                            "No kids found",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        );
                      }

                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: w * 0.05),
                        child: GridView.builder(
                          padding: EdgeInsets.zero,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: tablet ? 4 : 2,
                            crossAxisSpacing: w * 0.06,
                            mainAxisSpacing: h * 0.02,
                            childAspectRatio: 0.98,
                          ),
                          itemCount: controller.childrenList.length,
                          itemBuilder: (context, index) {
                            final child = controller.childrenList[index];

                            bool isSelected = selectedIndex == index;

                            final avatar = (child.gender?.toLowerCase() == "boy")
                                ? "assets/images/boy_avator.png"
                                : "assets/images/girl_avator.png";

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                });
                              },
                              child: Column(
                                children: [
                                  Container(
                                    height: h * 0.14,
                                    width: h * 0.14,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white.withOpacity(0.2),
                                      border: Border.all(
                                        color: isSelected
                                            ? Colors.orangeAccent
                                            : Colors.transparent,
                                        width: 3,
                                      ),
                                    ),
                                    child: Center(
                                      child: Image.asset(
                                        avatar,
                                        height: h * 0.085,
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: h * 0.01),

                                  Text(
                                    child.name ?? "",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: "Arial",
                                      fontSize: w * 0.038,
                                      color: Colors.black,
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    }),
                  ),
                ),

                SizedBox(height: h * 0.03),
                Spacer(),
                SafeArea(
                    child:
                InkWell(
                    onTap: () {
                      if (selectedIndex == null) {
                        // ❌ No child selected
                        Get.snackbar(
                          "Select Profile",
                          "Please choose a profile before continuing",
                          colorText: Colors.white,
                          backgroundColor: Colors.redAccent,
                          margin: const EdgeInsets.all(16),
                        );
                        return;
                      }

                      // ✅ Child selected → Navigate
                      final selectedChild = controller.childrenList[selectedIndex!].id;

                      final data = {
                        "child_id": selectedChild,
                      };

                      selectcontroller.selectchild(data);

                    },

                    child: CreateNowButton(text: "Select")))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
