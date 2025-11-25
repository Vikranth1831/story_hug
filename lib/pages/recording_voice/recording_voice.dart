import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:story_hug/pages/recording_voice/start_recording_voice.dart';
import 'package:story_hug/utils/media_query_helper.dart';

import '../../components/create_now_button.dart';
class RecordingVoice extends StatefulWidget {
  const RecordingVoice({super.key});

  @override
  State<RecordingVoice> createState() => _RecordingVoiceState();
}

class _RecordingVoiceState extends State<RecordingVoice> {
  bool isRecording = false;

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
                'Lets Record Your Voice Magic',
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
                'Please read the following passage clearly \n  this helps us capture the unique magic of your voice!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFF5F5F5),
                  fontSize: 14,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w400,
                  height: 1.70,
                ),
              ),

              SizedBox(height: h * 0.1),

              Container(
                width: double.infinity,
                height: h * 0.15,
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
                child: const Center(
                  child: Text(
                    'The little bear loved to read \nstories under the big\n friendly moon, dreaming adventures',
                    style: TextStyle(
                      color: Color(0xFF666666),
                      fontSize: 14,
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),

              SizedBox(height: h * 0.02),

              Text(
                'Recording 0:15 / 1:00',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.w400,
                ),
              ),

              SizedBox(height: h * 0.14),
              
              InkWell(
                onTap: () {
                  if (!isRecording) {
                    setState(() => isRecording = true);
                  } else {
                 context.push('/save_voice');

                  }
                },
                child: Container(
                  width: w,
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
                      Container(
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                          color :  Color(0xFFFF3636),
                          shape:  BoxShape.circle,
                        ),
                        child: Center(
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: isRecording ? BoxShape.rectangle :  BoxShape.circle,
                              border: Border.all(
                                width: 2,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),

                      Text(
                        isRecording ? 'Stop Recording' : 'Start Recording',
                        style: const TextStyle(
                          color: Color(0xFF24305B),
                          fontSize: 15,
                          fontFamily: 'Arial',
                          fontWeight: FontWeight.w800,
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

