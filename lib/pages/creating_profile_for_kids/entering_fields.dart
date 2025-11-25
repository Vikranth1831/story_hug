import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:story_hug/utils/media_query_helper.dart';

import '../../components/create_now_button.dart';
import '../../components/text_field.dart';

class EnteringFieldsForKid extends StatefulWidget {
  const EnteringFieldsForKid({super.key});

  @override
  State<EnteringFieldsForKid> createState() => _EnteringFieldsForKidState();
}

class _EnteringFieldsForKidState extends State<EnteringFieldsForKid> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  String selectedGender = "";

  final boyAvatars = [
    "assets/images/boy_avator.png",
    "assets/images/boy_avator.png",
    "assets/images/boy_avator.png",
  ];

  final girlAvatars = [
    "assets/images/girl_avator.png",
    "assets/images/girl_avator.png",
    "assets/images/girl_avator.png",
  ];

  @override
  Widget build(BuildContext context) {
    var w = SizeConfig.screenWidth;
    var h = SizeConfig.screenHeight;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bgimage.png'),
            fit: BoxFit.cover,
          ),
        ),

        /// 🔥 FIX — Correct structure to allow scroll + fixed bottom button
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: w * 0.034),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: h * 0.05),
                      Center(child: Image.asset('assets/images/Group 146.png')),

                      TextHeader("Name"),
                      SizedBox(height: h * 0.013),
                      CustomInputField(
                        controller: nameController,
                        label1: 'Enter name',
                      ),

                      SizedBox(height: h * 0.02),
                      TextHeader("Age"),
                      SizedBox(height: h * 0.013),
                      CustomInputField(
                        controller: ageController,
                        label1: 'Enter age',
                      ),

                      SizedBox(height: h * 0.02),
                      TextHeader("Gender"),
                      SizedBox(height: h * 0.013),

                      GenderRow(
                        selectedGender: selectedGender,
                        onSelect: (value) {
                          setState(() {
                            selectedGender = value;
                          });
                        },
                        height: h,
                        width: w,
                      ),

                      if (selectedGender.isNotEmpty) ...[
                        SizedBox(height: h * 0.02),
                        AvatarSelectionBox(
                          selectedGender == "boy"
                              ? boyAvatars
                              : girlAvatars,
                          h,
                          w,
                        ),
                        SizedBox(height: h * 0.03),
                      ],
                    ],
                  ),
                ),
              ),
            ),

            /// 🔥 FIX — Button inside body but not breaking UI
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: InkWell(
                onTap: () {
                  context.push('/manage_kids');
                },
                child: CreateNowButton(text: 'Create Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget AvatarSelectionBox(List<String> avatarList, var height, var width) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(height * 0.02),
      decoration: ShapeDecoration(
        color: Colors.white.withValues(alpha: 0.10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Avatar',
            style: TextStyle(
              color: Color(0xFFF5F5F5),
              fontSize: 16,
              fontFamily: 'Arial',
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(
                avatarList.length,
                    (index) => Padding(
                  padding: const EdgeInsets.only(right: 32),
                  child: Container(
                    width: width * 0.22,
                    height: height * 0.1,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(avatarList[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget TextHeader(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontFamily: 'Arial',
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget GenderRow({
    required String selectedGender,
    required Function(String) onSelect,
    required var height,
    required var width,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GenderBox(
            label: "Boy",
            imageUrl: "assets/images/boy_avator.png",
            isSelected: selectedGender == "boy",
            onTap: () => onSelect("boy"),
            width: width,
            height: height,
          ),

          GenderBox(
            label: "Girl",
            imageUrl: "assets/images/girl_avator.png",
            isSelected: selectedGender == "girl",
            onTap: () => onSelect("girl"),
            width: width,
            height: height,
          ),
        ],
      ),
    );
  }

  Widget GenderBox({
    required String label,
    required String imageUrl,
    required bool isSelected,
    required VoidCallback onTap,
    required var height,
    required var width,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: ShapeDecoration(
          color: isSelected
              ? const Color(0xFFFBD867)
              : Colors.white.withValues(alpha: 0.10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: width * 0.18,
              height: height * 0.09,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? const Color(0xFF24305B) : Colors.white,
                fontSize: 16,
                fontFamily: 'Arial',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
