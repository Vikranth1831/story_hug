import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:story_hug/pages/creating_profile_for_kids/create_profile_forkids.dart';
import 'package:story_hug/utils/media_query_helper.dart';
class SaveVoice extends StatelessWidget {
  const SaveVoice({super.key});

  @override
  Widget build(BuildContext context) {
    var w = SizeConfig.screenWidth;
    var h = SizeConfig.screenHeight;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
       decoration: BoxDecoration(
         image: DecorationImage(image: AssetImage('assets/images/backgroundimage.png'),
         fit: BoxFit.cover)
       ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.04),
          child: Column(
            children: [
              SizedBox(height: h * 0.05),
              Center(child: Image.asset('assets/images/open_book.png')),
              SizedBox(height: h * 0.05),

              Text(
                'Lets Save Your Voice Magic',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w400,
                ),
              ),

              SizedBox(height: h * 0.04),
              Text(
                'Give your special reading voice a name!\n  Eg: Dad’s Bedtime Voice',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFFF5F5F5),
                  fontSize: 14,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w400,
                  height: 1.70,
                ),
              ),

              SizedBox(height: h * 0.13),

              Container(
                width: double.infinity,
                height: h * 0.075,
                padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 10),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      width: 6,
                      strokeAlign: BorderSide.strokeAlignOutside,
                      color: Color(0xFF98A2C5),
                    ),
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Dads voice',
                    style: TextStyle(
                        color: Color(0xFF666666),
                        fontSize: 14,
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: h * 0.02),
              Text(
                'Listen to preview',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white
                ),
              ),
              Container(
                height: h * 0.3,
                  width: w * 1,
                  child: Image.asset('assets/images/save_voice.png')),

              InkWell(
                onTap: ()
                {
                 // context.push('/profile_for_kids');
                  Get.to(()=>CreateProfileForkids());
                },
                child: Container(
                  width: w ,
                  height: h * 0.07,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: ShapeDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment(0.00, 0.50),
                      end: Alignment(1.00, 0.50),
                      colors: [
                        Color(0xFFFCDB69),
                        Color(0xFFFCBF5D),
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 2,
                        offset: Offset(0, 4),
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // LEFT STAR (ASSET)
                      Image.asset(
                        'assets/images/star_2.png',   // <-- your star png
                        width: 24,
                        height: 24,
                      ),

                      const SizedBox(width: 10),

                      // TEXT
                      const Text(
                        'Save and continue',
                        style: TextStyle(
                          color: Color(0xFF24305B),
                          fontSize: 18,
                          fontFamily: 'Arial',
                          fontWeight: FontWeight.w800,
                        ),
                      ),

                      const SizedBox(width: 10),

                      // RIGHT STAR ROTATED
                      Transform.rotate(
                        angle: 3.14, // rotate 180 degrees
                        child: Image.asset(
                          'assets/images/star_2.png',  // <-- same asset
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              )



            ],
          ),
        ),
      ),
    );
  }


}
