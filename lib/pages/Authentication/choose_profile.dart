import 'package:flutter/material.dart';
import 'package:story_hug/utils/media_query_helper.dart'; // Your SizeConfig

class ChooseProfile extends StatefulWidget {
  const ChooseProfile({super.key});

  @override
  State<ChooseProfile> createState() => _ChooseProfileState();
}

class _ChooseProfileState extends State<ChooseProfile> {
  int? selectedIndex;

  /// Dummy profiles (you will replace with API response)
  final List<Map<String, dynamic>> profiles = [
    {"name": "Raja Reddy", "image": "assets/images/boy_avator.png"},
    {"name": "Vani Reddy", "image": "assets/images/girl_avator.png"},
    {"name": "Manoj", "image": "assets/images/boy_avator.png"},
    {"name": "Anitha", "image": "assets/images/girl_avator.png"},
  ];

  /// Check device type
  bool isTablet(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width >= 600; // tablet breakpoint
  }

  @override
  Widget build(BuildContext context) {
    final double h = SizeConfig.screenHeight;
    final double w = SizeConfig.screenWidth;

    final bool tablet = isTablet(context);

    return Scaffold(
      body: Stack(
        children: [
          /// BACKGROUND IMAGE
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

                /// WELCOME
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

                /// GRIDVIEW
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.05),
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: tablet ? 4 : 2,
                        crossAxisSpacing: w * 0.06,
                        mainAxisSpacing: h * 0.02,
                        childAspectRatio: 0.78,
                      ),
                      itemCount: tablet ? profiles.length : 4,
                      itemBuilder: (context, index) {
                        bool isSelected = selectedIndex == index;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          child: Column(
                            children: [
                              /// PROFILE CARD
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
                                    profiles[index]["image"],
                                    height: h * 0.085,
                                  ),
                                ),
                              ),

                              SizedBox(height: h * 0.01),

                              /// NAME
                              Text(
                                profiles[index]["name"],
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
                  ),
                ),

                SizedBox(height: h * 0.03),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
