import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:story_hug/utils/media_query_helper.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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

              /// TOP PROFILE BUBBLE
              Center(
                child: KidProfileBubble(
                  w: w,
                  h: h,
                  initial: "A",
                  name: "Akhil",
                ),
              ),

              SizedBox(height: h * 0.04),

              /// TITLE
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

              /// GRID OF KIDS
              KidsGrid(w, h),

              SizedBox(height: h * 0.04),

              /// CHANGE PASSWORD BUTTON
              InkWell(
                onTap: ()
                  {
                    context.push('/verify-email');
                  },
                  child: ChangePasswordButton(w, h,context)),

              SizedBox(height: h * 0.05),
            ],
          ),
        ),
      ),
    );
  }

  // -----------------------------------------------------
  // KID PROFILE BUBBLE (already correct)
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
  // GRID OF KIDS
  // -----------------------------------------------------
  Widget KidsGrid(double w, double h) {
    List<Map<String, String>> kids = [
      {"name": "Shiva"},
      {"name": "Rani"},
      {"name": "Raju"},
      {"name": "Kumari"},
      {"name": "Karthik"},
      {"name": "Nisa"},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: kids.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 24,
        crossAxisSpacing: 60,
        childAspectRatio: 1.3,
      ),
      itemBuilder: (context, index) {
        return KidCard(w, h, kids[index]["name"]!);
      },
    );
  }

  // -----------------------------------------------------
  // KID CARD (same design as your Figma)
  // -----------------------------------------------------
  Widget KidCard(double w, double h, String name) {
    return Container(
      //padding: EdgeInsets.all(w * 0.03),
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
            child: Image.asset('assets/images/girl_avator.png'),
          ),
          SizedBox(height: h * 0.015),
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: '',
            ),
          ),
        ],
      ),
    );
  }

  // -----------------------------------------------------
  // CHANGE PASSWORD BUTTON
  // -----------------------------------------------------
  Widget ChangePasswordButton(double w, double h,BuildContext context) {
    return InkWell(
      onTap: ()
      {
        context.push('/verify_email');
      },
      child: Container(
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
      ),
    );
  }
}

