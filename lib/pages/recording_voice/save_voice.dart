import 'dart:io';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:get/get_core/src/get_main.dart';
import 'package:story_hug/controller/AudioController.dart';
import 'package:story_hug/controller/saveAudioFileController.dart';
import 'package:story_hug/pages/creating_profile_for_kids/create_profile_forkids.dart';
import 'package:story_hug/repositories/save_audio_repository.dart';
import 'package:story_hug/utils/media_query_helper.dart';

import '../../data/remote_data_source.dart';

class SaveVoice extends StatefulWidget {
  const SaveVoice({
    super.key,
  });

  @override
  State<SaveVoice> createState() => _SaveVoiceState();
}

class _SaveVoiceState extends State<SaveVoice> {
  FlutterSoundPlayer player = FlutterSoundPlayer();
  bool isPlaying = false;

  final audioController = Get.find<AudioController>();
  final TextEditingController voiceNameController = TextEditingController();
  final SaveAudioController Controller = Get.put(
    SaveAudioController(
      repository: SaveAudioRepositoryImpl(remoteDataSource: RemoteDataSourceImpl()),
    ),
  );

  late File audioFile;
  @override
  void initState() {
    super.initState();
    player.openPlayer();
    audioFile = Get.arguments['audioFile'];
    print("Audio file path: ${audioFile.path}");

  }

  @override
  void dispose() {
    player.closePlayer();
    super.dispose();
  }

  Future<void> playPreview() async {
    if (!isPlaying) {
      if (!await File(audioFile.path).exists()) {
        print("Audio file does not exist!");
        return;
      }

      await player.startPlayer(
        fromURI: audioFile.path,
        codec: Codec.aacMP4,
        whenFinished: () {
          setState(() => isPlaying = false);
        },
      );
      setState(() => isPlaying = true);
    } else {
      await player.stopPlayer();
      setState(() => isPlaying = false);
    }
  }
  Future<Map<String, dynamic>> getFormData() async {
    return {
      "voiceName": voiceNameController.text.trim(),
      "audioFile": await MultipartFile.fromFile(
        audioFile.path,
        filename: "recorded_audio.m4a",
      ),
    };
  }


  @override
  Widget build(BuildContext context) {
    final w = SizeConfig.screenWidth;
    final h = SizeConfig.screenHeight;

    return Scaffold(
      resizeToAvoidBottomInset: false, // FIXED BUTTON DOES NOT MOVE
      body: Stack(
        children: [
          // BACKGROUND IMAGE
          Container(
            width: w,
            height: h,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/backgroundimage.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // SCROLLABLE CONTENT
          Positioned.fill(
            top: 0,
            bottom: h * 0.12,
            child: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: h * 0.05),

                    Image.asset(
                      'assets/images/open_book.png',
                      width: w * 0.55,
                    ),

                    SizedBox(height: h * 0.05),

                    Text(
                      'Lets Save Your Voice Magic',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: w * 0.055,
                        fontFamily: 'Arial',
                      ),
                    ),

                    SizedBox(height: h * 0.04),

                    Text(
                      'Give your special reading voice a name!\nEg: Dad’s Bedtime Voice',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFF5F5F5),
                        fontSize: w * 0.037,
                        fontFamily: 'Arial',
                      ),
                    ),

                    SizedBox(height: h * 0.08),

                    // TEXT FIELD
                    Container(
                      height: h * 0.075,
                      padding: EdgeInsets.symmetric(horizontal: 23),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 6,
                            color: Color(0xFF98A2C5),
                          ),
                          borderRadius: BorderRadius.circular(32),
                        ),
                      ),
                      child: Center(
                        child: TextField(
                          controller: voiceNameController,
                          style: TextStyle(
                            color: Color(0xFF666666),
                            fontSize: w * 0.035,
                            fontFamily: 'Arial',
                          ),
                          decoration: InputDecoration(
                            hintText: "Dad’s Voice",
                            hintStyle: TextStyle(
                              color: Color(0xFF666666),
                              fontSize: w * 0.035,
                            ),
                            filled: true,
                            fillColor: Colors.white,

                            // NO BORDER
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,

                            // CENTER VERTICAL
                            contentPadding: EdgeInsets.symmetric(vertical: 0),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: h * 0.02),

                    // PREVIEW PLAY BUTTON
                    InkWell(
                      onTap: playPreview,
                      child: Text(
                        isPlaying ? 'Stop preview' : 'Listen to preview',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: w * 0.035,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),

                    SizedBox(height: h * 0.04),

                    Image.asset(
                      'assets/images/save_voice.png',
                      height: h * 0.28,
                    ),

                    SizedBox(height: h * 0.10),
                  ],
                ),
              ),
            ),
          ),

          // FIXED BOTTOM BUTTON
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: h * 0.10,
              padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: h * 0.02),
              child: GestureDetector(
                onTap: () async {
                  if (voiceNameController.text.trim().isEmpty) {
                    // Optionally show an error
                    print("Please enter a voice name");
                    return;
                  }

                  // Prepare FormData
                  // ignore: implementation_imports
                  FormData formData = FormData.fromMap({
                    "voiceName": voiceNameController.text.trim(),
                    "audio": await MultipartFile.fromFile(
                      audioFile.path,
                      filename: audioFile.path.split('/').last,
                    ),
                  });

                  // Call controller with FormData
                  Controller.saveaudio(formData);
                },
                child: Container(
                  height: h * 0.07,
                  decoration: ShapeDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFFCDB69),
                        Color(0xFFFCBF5D),
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 2,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/star_2.png', width: 24),
                      SizedBox(width: 10),
                      Text(
                        'Save and continue',
                        style: TextStyle(
                          color: Color(0xFF24305B),
                          fontSize: w * 0.045,
                          fontFamily: 'Arial',
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(width: 10),
                      Transform.rotate(
                        angle: 3.14,
                        child: Image.asset('assets/images/star_2.png', width: 24),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
