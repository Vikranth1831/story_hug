import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:go_router/go_router.dart';
import 'package:story_hug/components/create_now_button.dart';
import 'package:story_hug/pages/recording_voice/recording_voice.dart';
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
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/backgroundimage.png'),
          fit: BoxFit.cover)
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
              SizedBox(height: h * 0.04,),
              QuickInfoRow(),
              SizedBox(height: h * 0.04,),
              InkWell(
                onTap: ()
                  {
                 //   context.push('/recording_voice');
                    Get.to(()=>RecordingVoice());
                  },
                  child: CreateNowButton(text: "Start Recording My Voice"))

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

          InfoItem(
            icon: Icons.timer,
            label: "5 Minutes",
          ),

          InfoItem(
            icon: Icons.format_list_numbered,
            label: "Simple Steps",
          ),

          InfoItem(
            icon: Icons.star,
            label: "Extra Special",
          ),

        ],
      ),
    );
  }


  Widget InfoItem({
    required IconData icon,
    required String label,
    Color bgColor = const Color(0xFF4A90E2), // default blue-ish
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: bgColor.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
          child: Center(child: Icon(icon, size: 30, color: Colors.white)),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontFamily: 'Arial',
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }


}
