import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:story_hug/utils/media_query_helper.dart';
class StartRecordingVoice extends StatelessWidget {
  const StartRecordingVoice({super.key});

  @override
  Widget build(BuildContext context) {
    var w=SizeConfig.screenWidth;
    var h=SizeConfig.screenHeight;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2A2D64), // top
              Color(0xFF687EC7), // bottom
            ],
          ),
        ),
        child:  Padding(
          padding:  EdgeInsets.symmetric(horizontal: w * 0.026),
          child: Column(

            children: [
              SizedBox(height: h * 0.05,),
              Center(child: Image.asset('assets/images/Group 146.png')),
              Text(
                'Your Voice Make Magic',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w400,
                ),
              ),
              Image.asset('assets/images/voice_magic.png'),
              Text(
                'Bring Stories to life in Your voice! we ‘ll \n guide you through a quipk,recorple\n recording.it takes about 5 minutes and \n bedtime extra special',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w400,
                ),
              ),
              QuickInfoRow()

            ],

          ),
        ),
      ),

    );
  }
  Widget QuickInfoRow() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          // 5 Minutes
          Column(
            children: const [
              Icon(Icons.timer, size: 40, color: Colors.white),
              SizedBox(height: 6),
              Text(
                '5 Minutes',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: 'Arial Rounded MT Bold',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),

          // Simple Steps
          Column(
            children: const [
              Icon(Icons.format_list_numbered, size: 40, color: Colors.white),
              SizedBox(height: 6),
              Text(
                'Simple Steps',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: 'Arial Rounded MT Bold',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),

          // Extra Special
          Column(
            children: const [
              Icon(Icons.star, size: 40, color: Colors.white),
              SizedBox(height: 6),
              Text(
                'Extra Special',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: 'Arial Rounded MT Bold',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }

}
