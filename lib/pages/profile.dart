import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:story_hug/pages/creating_profile_for_kids/entering_fields.dart';
import 'package:story_hug/utils/media_query_helper.dart';

import '../controller/getAllChildrenController.dart';
import '../data/remote_data_source.dart';
import '../models/get_all_children_model.dart';
import '../repositories/get_all_children_repository.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Getallchildrencontroller controller = Get.put(
    Getallchildrencontroller(
      repository: GetAllChildrenRepositoryImpl(
        remoteDataSource: RemoteDataSourceImpl(),
      ),
    ),
  );

  @override
  void initState() {
    super.initState();
    controller.getAllChildren();   // 🔥 Fetch children from API
  }

  @override
  Widget build(BuildContext context) {
    var w = SizeConfig.screenWidth;
    var h = SizeConfig.screenHeight;

    return Scaffold(
      backgroundColor: const Color(0xFF192346),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              SizedBox(height: h * 0.08),

              /// DO NOT CHANGE — SAME
              Center(
                child: KidProfileBubble(
                  w: w,
                  h: h,
                  initial: "A",
                  name: "Akhil",
                ),
              ),

              SizedBox(height: h * 0.04),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Manage Kids',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: w * 0.055,
                    fontFamily: 'Arial',
                  ),
                ),
              ),

              /// 🔥 Replace static grid → Add API children
              Obx(() {
                if (controller.isLoading.value) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                }

                if (controller.childrenList.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Text(
                      "No Kids Added Yet",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }

                return KidsGrid(w, h, controller.childrenList);
              }),

              SizedBox(height: h * 0.04),

              InkWell(
                onTap: () {
                  context.push('/verify_email');
                },
                child: ChangePasswordButton(w, h, context),
              ),

              SizedBox(height: h * 0.05),
            ],
          ),
        ),
      ),
    );
  }

  // -----------------------------------------------------
  // YOUR ORIGINAL BUBBLE — UNCHANGED
  // -----------------------------------------------------
  Widget KidProfileBubble({
    required double w,
    required double h,
    required String initial,
    required String name,
  }) {
    double circleSize = w * 0.32;
    double smallCircle = w * 0.08;

    return SizedBox(
      width: circleSize,
      child: Column(
        children: [

          Stack(
            children: [
              Container(
                width: circleSize,
                height: circleSize,
                decoration: const BoxDecoration(
                  color: Color(0xFFD9F3F2),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    initial,
                    style: TextStyle(
                      color: const Color(0xFF00ACA6),
                      fontSize: w * 0.12,
                    ),
                  ),
                ),
              ),

              Positioned(
                right: circleSize * 0.04,
                top: circleSize * 0.04,
                child: Container(
                  width: smallCircle,
                  height: smallCircle,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.edit,
                    size: circleSize * 0.13,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: h * 0.02),

          Text(
            name,
            style: TextStyle(
              color: Colors.white,
              fontSize: w * 0.07,
              fontFamily: 'Arial Rounded MT Bold',
            ),
          ),
        ],
      ),
    );
  }

  // -----------------------------------------------------
  // 🔥 API Children Grid — SAME UI AS BEFORE
  // -----------------------------------------------------
  Widget KidsGrid(double w, double h, List<Children> kidsList) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: kidsList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 24,
        crossAxisSpacing: 60,
        childAspectRatio: 1.3,
      ),
      itemBuilder: (context, index) {
        final child = kidsList[index];

        String avatar = child.gender == "boy"
            ? "assets/images/boy_avator.png"
            : "assets/images/girl_avator.png";

        return KidCard(w, h, child.name ?? "", avatar,child);
      },
    );
  }

  // -----------------------------------------------------
  // YOUR ORIGINAL CARD — EXACT SAME UI
  // -----------------------------------------------------
  Widget KidCard(double w, double h, String name, String avatar, Children child) {
    return InkWell(
      onTap: ()
      {
        Get.to(() => EnteringFieldsForKid(childData: child));

      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: w * 0.1,
              height: w * 0.15,
              child: Image.asset(avatar),
            ),
            SizedBox(height: h * 0.015),
            Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // -----------------------------------------------------
  // ORIGINAL BUTTON — UNCHANGED
  // -----------------------------------------------------
  Widget ChangePasswordButton(double w, double h, BuildContext context) {
    return Container(
      width: double.infinity,
      height: h * 0.07,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(116),
        border: Border.all(
          color: const Color(0xFFFCD667),
          width: 1,
        ),
      ),
      child: Center(
        child: Text(
          "Change Password",
          style: TextStyle(
            color: Colors.white,
            fontSize: w * 0.05,
            fontFamily: 'Arial',
          ),
        ),
      ),
    );
  }
}



