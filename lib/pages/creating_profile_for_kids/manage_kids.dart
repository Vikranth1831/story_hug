import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:story_hug/controller/getAllChildrenController.dart';
import 'package:story_hug/pages/creating_profile_for_kids/entering_fields.dart';

import 'package:story_hug/repositories/get_all_children_repository.dart';
import 'package:story_hug/utils/media_query_helper.dart';

import '../../app_routes/app_routes.dart';
import '../../components/create_now_button.dart';
import '../../components/text_field.dart';
import 'package:dotted_border/dotted_border.dart';

import '../../data/remote_data_source.dart';
import '../Section1/Home.dart';

class ManageKids extends StatefulWidget {
  const ManageKids({super.key});

  @override
  State<ManageKids> createState() => _ManageKidsState();
}

class _ManageKidsState extends State<ManageKids> {
  final Getallchildrencontroller controller = Get.put(
    Getallchildrencontroller(
      repository:
      GetAllChildrenRepositoryImpl(remoteDataSource: RemoteDataSourceImpl()),
    ),
  );

  @override
  void initState() {
    super.initState();
    controller.getAllChildren();   // 🔥 API CALL
  }

  @override
  Widget build(BuildContext context) {
    //controller.getAllChildren();


    var w = SizeConfig.screenWidth;
    var h = SizeConfig.screenHeight;

    return Scaffold(
      backgroundColor: Color(0xFF192346),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * 0.034),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: h * 0.05),
              Center(child: Image.asset('assets/images/open_book.png')),
              SizedBox(height: h * 0.02),
              Text(
                'Manage Kids',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: h * 0.05),

              // 🔥🔥 SHOW CHILDREN FROM API
              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                }

                if (controller.childrenList.isEmpty) {
                  return const Text(
                    "No kids found",
                    style: TextStyle(color: Colors.white),
                  );
                }

                return Column(
                  children: List.generate(
                    controller.childrenList.length,
                        (index) {
                      final child = controller.childrenList[index];

                      // gender-based avatar
                      final avatar = (child.gender?.toLowerCase() == "boy")
                          ? "assets/images/boy_avator.png"
                          : "assets/images/girl_avator.png";

                      return KidProfileCard(
                        name: child.name ?? "",
                        age: child.age?.toString() ?? "",
                        avatar: avatar,
                        height: h,
                        width: w,
                      );
                    },
                  ),
                );
              }),

              SizedBox(height: h * 0.05),
              AddChildButton(h, w, context),
              SizedBox(height: h * 0.05),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: InkWell(
          onTap: () {
           // context.push('/home');
            Get.offAllNamed(Routes.HomeScreen);
            // context.push('/home');
          //  Get.offAllNamed(Routes.HomeScreen);
          },
          child: CreateNowButton(text: 'Done'),
        ),
      ),
    );
  }

  Widget AddChildButton(var h, var w, BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(()=>EnteringFieldsForKid());

     //   context.push('/entering_fields_for_kids');
      },
      child: DottedBorder(
        color: const Color(0xFF82B5CA),
        strokeWidth: 3,
        dashPattern: const [8, 4],
        borderType: BorderType.RRect,
        radius: Radius.circular(w * 0.04),
        child: Container(
          width: double.infinity,
          height: h * 0.07,
          padding: EdgeInsets.all(w * 0.04),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(w * 0.04),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Add child Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: w * 0.045,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(width: w * 0.015),
              Container(
                width: w * 0.06,
                height: w * 0.06,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.add,
                    size: w * 0.05,
                    color: const Color(0xFF192346),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget KidProfileCard({
    required String name,
    required String age,
    required String avatar,
    required var height,
    required var width,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 28),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 3,
              strokeAlign: BorderSide.strokeAlignOutside,
              color: Color(0xFF82B5CA),
            ),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: ShapeDecoration(
                color: const Color(0xFFDDF5EB),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    width: 3,
                    strokeAlign: BorderSide.strokeAlignOutside,
                    color: Color(0xFF6E91AD),
                  ),
                  borderRadius: BorderRadius.circular(48),
                ),
              ),
              child: Container(
                width: width * 0.13,
                height: width * 0.13,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(avatar),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Child Profile',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  name,
                  style: const TextStyle(
                    color: Color(0xFFC8C8C8),
                    fontSize: 15,
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  "$age year old",
                  style: const TextStyle(
                    color: Color(0xFFC8C8C8),
                    fontSize: 15,
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}