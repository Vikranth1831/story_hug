import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:story_hug/utils/media_query_helper.dart';

import '../../components/create_now_button.dart';
import 'package:dotted_border/dotted_border.dart';

class ManageKids extends StatelessWidget {
  const ManageKids({super.key});

  @override
  Widget build(BuildContext context) {
    var w = SizeConfig.screenWidth;
    var h = SizeConfig.screenHeight;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        /// Background image
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bgimage.png"),
            fit: BoxFit.cover,
          ),
        ),

        child: Stack(
          children: [
            /// ---------- MAIN CONTENT WITH SCROLL ----------
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: w * 0.034),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: h * 0.05),

                  Center(child: Image.asset('assets/images/open_book.png')),
                  SizedBox(height: h * 0.02),

                  Text(
                    'Manage Kids',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  SizedBox(height: h * 0.05),

                  KidProfileCard(
                    name: "Maya",
                    age: "6",
                    avatar: "assets/images/girl_avator.png",
                    height: h,
                    width: w,
                  ),

                  KidProfileCard(
                    name: "Arjun",
                    age: "5",
                    avatar: "assets/images/boy_avator.png",
                    height: h,
                    width: w,
                  ),

                  SizedBox(height: h * 0.05),

                  AddChildButton(h, w, context),

                  SizedBox(height: h * 0.15), // space for bottom button
                ],
              ),
            ),

            /// -------- FIXED BUTTON AT THE BOTTOM INSIDE BODY --------
            Positioned(
              left: 0,
              right: 0,
              bottom: 20,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.034),
                child: InkWell(
                  onTap: () {
                    context.push('/home');
                  },
                  child: const CreateNowButton(text: 'Done'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget AddChildButton(var h, var w, BuildContext context) {
    return InkWell(
      onTap: () {
        context.push('/entering_fields_for_kids');
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Add child Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: w * 0.045,
                  fontFamily: 'Arial',
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
                child: Icon(
                  Icons.add,
                  size: w * 0.05,
                  color: Color(0xFF192346),
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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 28),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 3,
            color: Color(0xFF82B5CA),
          ),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: ShapeDecoration(
              color: const Color(0xFFDDF5EB),
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  width: 3,
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
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
              Text(
                name,
                style: const TextStyle(
                  color: Color(0xFFC8C8C8),
                  fontSize: 15,
                ),
              ),
              Text(
                "$age year old",
                style: const TextStyle(
                  color: Color(0xFFC8C8C8),
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
