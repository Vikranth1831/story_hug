import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:story_hug/components/create_now_button.dart';
import 'package:story_hug/controller/select_child_controller.dart';
import 'package:story_hug/pages/creating_profile_for_kids/create_profile_forkids.dart';
import 'package:story_hug/repositories/select_child_repository.dart';
import 'package:story_hug/utils/AppLogger.dart';
import 'package:story_hug/utils/app_snackbar.dart';
import 'package:story_hug/utils/media_query_helper.dart';
import '../../controller/getAllChildrenController.dart';
import '../../data/remote_data_source.dart';
import '../../repositories/get_all_children_repository.dart';
import '../../services/AuthService.dart';

class ChooseProfile extends StatefulWidget {
  const ChooseProfile({super.key});

  @override
  State<ChooseProfile> createState() => _ChooseProfileState();
}

class _ChooseProfileState extends State<ChooseProfile> {
  // 👇 Replaces int? selectedIndex;
  final ValueNotifier<int?> selectedIndexNotifier = ValueNotifier<int?>(null);

  final Getallchildrencontroller controller = Get.put(
    Getallchildrencontroller(
      repository: GetAllChildrenRepositoryImpl(
        remoteDataSource: RemoteDataSourceImpl(),
      ),
    ),
  );

  final SelectChildController selectcontroller = Get.put(
    SelectChildController(
      repository:
      SelectChildRepositoryImpl(remoteDataSource: RemoteDataSourceImpl()),
    ),
  );

  @override
  void initState() {
    super.initState();
    controller.getAllChildren(); // 🔥 API CALL
  }

  @override
  void dispose() {
    selectedIndexNotifier.dispose();
    super.dispose();
  }

  bool isTablet(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width >= 600;
  }

  @override
  Widget build(BuildContext context) {
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

                /// WELCOME TEXT
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
                  ],
                ),

                SizedBox(height: h * 0.06),

                /// TITLE
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

                /// GRID
                Expanded(
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      );
                    }

                    final list = controller.childrenList;

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
                        itemCount: list.isEmpty ? 1 : list.length + 1,
                        itemBuilder: (context, index) {
                          /// ADD NEW PROFILE BOX
                          if (index == list.length) {
                            return GestureDetector(
                              onTap: () {
                                Get.to(() => const CreateProfileForkids());
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
                                          color: Colors.white, width: 1),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.add,
                                        size: h * 0.05,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: h * 0.01),
                                ],
                              ),
                            );
                          }

                          /// EXISTING KID PROFILE BOXES
                          final child = list[index];

                          final avatar = (child.gender?.toLowerCase() == "boy")
                              ? "assets/images/boy_avator.png"
                              : "assets/images/girl_avator.png";

                          // 👇 wrap with ValueListenableBuilder to react to selection
                          return ValueListenableBuilder<int?>(
                            valueListenable: selectedIndexNotifier,
                            builder: (context, selectedIndex, _) {
                              final bool isSelected = selectedIndex == index;

                              return GestureDetector(
                                onTap: () {
                                  selectedIndexNotifier.value = index;
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
                          );
                        },
                      ),
                    );
                  }),
                ),

                SizedBox(height: h * 0.03),

                /// BUTTON AT BOTTOM
                Padding(
                  padding: EdgeInsets.only(bottom: h * 0.02),
                  child: SafeArea(
                    child: InkWell(
                      onTap: () async {
                        final selectedIndex = selectedIndexNotifier.value;
                        if (selectedIndex == null) {
                          AppSnackBar.show(context, "Please Select a Kid");
                          return;
                        }

                        final selectedChild =
                            controller.childrenList[selectedIndex].id;

                        if (selectedChild == null) {
                          AppSnackBar.show(
                              context, "Invalid child. Please try again.");
                          return;
                        }

                        final data = {"child_id": selectedChild};
                        AppLogger.info("child_id:${data}");

                        // 🔥 API call
                        await selectcontroller.selectchild(data);

                        // 💾 Save globally
                        await AuthService.saveUserChildId(selectedChild);

                        // Optionally navigate:
                        // Get.offAllNamed(Routes.Home);
                      },
                      child: const CreateNowButton(text: "Select"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
