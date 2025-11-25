import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:go_router/go_router.dart';
import 'package:story_hug/repositories/create_child_repository.dart';
import 'package:story_hug/utils/media_query_helper.dart';

import '../../components/create_now_button.dart';
import '../../components/text_field.dart';
import '../../controller/createChildrenController.dart';
import '../../data/remote_data_source.dart';
import '../../models/get_all_children_model.dart';

class EnteringFieldsForKid extends StatefulWidget {
  final Children? childData;   // 🔥 comes only in Update mode

  const EnteringFieldsForKid({super.key, this.childData});

  @override
  State<EnteringFieldsForKid> createState() => _EnteringFieldsForKidState();
}

class _EnteringFieldsForKidState extends State<EnteringFieldsForKid> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  String selectedGender = "";

  bool isUpdate = false;  // 🔥 to detect update mode

  String nameError = "";
  String ageError = "";
  String genderError = "";

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

  final CreatechildrenController controller = Get.put(
    CreatechildrenController(
      repository: CreateChildRepositoryImpl(
        remoteDataSource: RemoteDataSourceImpl(),
      ),
    ),
  );

  @override
  void initState() {
    super.initState();

    // 🔥 Detect update mode
    if (widget.childData != null) {
      isUpdate = true;
      nameController.text = widget.childData!.name ?? "";
      ageController.text = widget.childData!.age.toString();
      selectedGender = widget.childData!.gender ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    var w = SizeConfig.screenWidth;
    var h = SizeConfig.screenHeight;

    return Scaffold(
      backgroundColor: Color(0xFF192346),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * 0.034),
        child: SingleChildScrollView(
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

              if (nameError.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(nameError,
                      style: TextStyle(color: Colors.red, fontSize: 12)),
                ),

              SizedBox(height: h * 0.02),

              TextHeader("Age"),
              SizedBox(height: h * 0.013),

              CustomInputField(
                controller: ageController,
                label1: 'Enter age',
              ),

              if (ageError.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(ageError,
                      style: TextStyle(color: Colors.red, fontSize: 12)),
                ),

              SizedBox(height: h * 0.02),

              // 🔥 HIDE GENDER ROW IN UPDATE MODE
              if (!isUpdate) ...[
                TextHeader("Gender"),
                SizedBox(height: h * 0.013),

                GenderRow(
                  selectedGender: selectedGender,
                  onSelect: (value) {
                    setState(() {
                      selectedGender = value;
                      genderError = "";
                    });
                  },
                  height: h,
                  width: w,
                ),

                if (genderError.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(genderError,
                        style: TextStyle(color: Colors.red, fontSize: 12)),
                  ),
              ],

              // 🔥 Always show avatar box in update mode
              if (selectedGender.isNotEmpty) ...[
                SizedBox(height: h * 0.02),
                AvatarSelectionBox(
                  selectedGender == "boy" ? boyAvatars : girlAvatars,
                  h,
                  w,
                ),
                SizedBox(height: h * 0.03),
              ],
            ],
          ),
        ),
      ),

      bottomNavigationBar: SafeArea(
        child: InkWell(
          onTap: () {
            setState(() {
              nameError = "";
              ageError = "";
              genderError = "";
            });

            bool valid = true;

            if (nameController.text.trim().isEmpty) {
              setState(() => nameError = "Please enter child's name");
              valid = false;
            }

            if (ageController.text.trim().isEmpty) {
              setState(() => ageError = "Please enter age");
              valid = false;
            } else if (int.tryParse(ageController.text.trim()) == null) {
              setState(() => ageError = "Age must be a valid number");
              valid = false;
            }

            if (!isUpdate && selectedGender.isEmpty) {
              setState(() => genderError = "Please select gender");
              valid = false;
            }

            if (valid) {
              final data = {
                "name": nameController.text.trim(),
                "gender": selectedGender,
                "age": ageController.text,
                "image": "",
                if (isUpdate) "id": widget.childData!.id,   // 🔥 send id in update
              };

              controller.createChildren(data);
            }
          },
          child: CreateNowButton(text: 'Create Now'),
        ),
      ),
    );
  }

  // ❗ Rest UI widgets remain EXACTLY same (no change)
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
      style: TextStyle(
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
