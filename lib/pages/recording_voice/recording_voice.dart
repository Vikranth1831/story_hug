import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:story_hug/controller/SampleTextController.dart';
import 'package:story_hug/pages/recording_voice/save_voice.dart';
import 'package:story_hug/repositories/sample_text_repository.dart';
import 'package:story_hug/utils/media_query_helper.dart';

import '../../app_routes/app_routes.dart';
import '../../controller/AudioController.dart';
import '../../data/remote_data_source.dart';

class RecordingVoice extends StatefulWidget {
  const RecordingVoice({super.key});

  @override
  State<RecordingVoice> createState() => _RecordingVoiceState();
}

class _RecordingVoiceState extends State<RecordingVoice> {
  final Sampletextcontroller controller = Get.put(
    Sampletextcontroller(
      repository:
      SampleTextRepositoryImpl(remoteDataSource: RemoteDataSourceImpl()),
    ),
  );

  bool isRecording = false;
  FlutterSoundRecorder recorder = FlutterSoundRecorder();
  Timer? timer;
  int seconds = 0;

  File? recordedFile; // <-- FILE (not path)

  @override
  void initState() {
    super.initState();
    controller.getSampleText();
    initRecorder();
  }

  Future<void> initRecorder() async {
    await Permission.microphone.request();
    await recorder.openRecorder();
  }

  Future<void> startRecording() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path =
        "${dir.path}/user_voice_${DateTime.now().millisecondsSinceEpoch}.aac";

    await recorder.startRecorder(
      toFile: path,
      codec: Codec.aacMP4,
    );

    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() => seconds++);
    });

    setState(() => isRecording = true);
  }

  Future<void> stopRecording() async {
    String? finalPath = await recorder.stopRecorder();
    timer?.cancel();

    if (finalPath != null) {
      recordedFile = File(finalPath); // <-- STORE FILE
      print("Audio file path: ${recordedFile}");

    }

    setState(() => isRecording = false);

    Get.toNamed(
      Routes.SaveVoice,
      arguments: {
        "audioFile": recordedFile,  // <- pass File here
      },
    );
  }

  String formatTime(int sec) {
    final m = (sec ~/ 60).toString().padLeft(2, "0");
    final s = (sec % 60).toString().padLeft(2, "0");
    return "$m:$s";
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    timer?.cancel();
    super.dispose();
  }

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
            image: AssetImage('assets/images/backgroundimage.png'),
            fit: BoxFit.cover,
          ),
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
                  fontSize: w * 0.05,
                  fontFamily: 'Arial',
                ),
              ),

              SizedBox(height: h * 0.04),

              Text(
                'Please read the following passage clearly\nthis helps us capture your voice!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFFF5F5F5),
                  fontSize: w * 0.035,
                  fontFamily: 'Arial',
                  height: 1.7,
                ),
              ),

              SizedBox(height: h * 0.1),

              // BOX WITH SAMPLE TEXT
              Container(
                width: double.infinity,
                padding:
                const EdgeInsets.symmetric(horizontal: 23, vertical: 10),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      width: 6,
                      color: Color(0xFF98A2C5),
                    ),
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
                child: Center(
                  child: Obx(
                        () => Text(
                      '${controller.sampletext.value}',
                      style: TextStyle(
                        color: const Color(0xFF666666),
                        fontSize: w * 0.035,
                        fontFamily: 'Arial',
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: h * 0.02),

              Text(
                isRecording
                    ? "Recording ${formatTime(seconds)}"
                    : "Recording 00:00",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: w * 0.032,
                  fontFamily: 'Arial',
                ),
              ),

              SizedBox(height: h * 0.14),

              // RECORDING BUTTON
              InkWell(
                onTap: () async {
                  if (!isRecording) {
                    seconds = 0;
                    await startRecording();
                  } else {
                    await stopRecording();
                  }
                },
                child: Container(
                  width: w,
                  height: h * 0.07,
                  decoration: ShapeDecoration(
                    gradient: const LinearGradient(
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
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // RED DOT
                      Container(
                        width: 26,
                        height: 26,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFF3636),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: isRecording
                                  ? BoxShape.rectangle
                                  : BoxShape.circle,
                              border: Border.all(
                                width: 2,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: w * 0.03),
                      Text(
                        isRecording ? 'Stop Recording' : 'Start Recording',
                        style: TextStyle(
                          color: const Color(0xFF24305B),
                          fontSize: w * 0.04,
                          fontFamily: 'Arial',
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
