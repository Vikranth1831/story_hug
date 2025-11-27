import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:story_hug/controller/DefaultVoiceController.dart';
import 'package:story_hug/controller/getAllVoicesController.dart';
import 'package:story_hug/repositories/get_all_voices_repository.dart';
import 'package:story_hug/utils/media_query_helper.dart';
import '../data/remote_data_source.dart';
import '../repositories/defaut_voice_repository.dart';

class AllVoices extends StatefulWidget {
  const AllVoices({super.key});

  @override
  State<AllVoices> createState() => _AllVoicesState();
}

class _AllVoicesState extends State<AllVoices> {
  final GetAllVoicesController controller = Get.put(
    GetAllVoicesController(
      repository:
      GetAllVoicesRepositoryImpl(remoteDataSource: RemoteDataSourceImpl()),
    ),
  );
  final DefaultVoiceController setVoicecontroller = Get.put(
    DefaultVoiceController(
      repository:
      DefautVoiceRepositoryImpl(remoteDataSource: RemoteDataSourceImpl()),
    ),
  );

  List<Map<String, dynamic>> voices = [];
  int? selectedVoiceId;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchVoices();
  }

  Future<void> fetchVoices() async {
    await controller.getAllVoice();

    if (controller.getAllVoiceModel != null &&
        controller.getAllVoiceModel!.success == true) {
      setState(() {
        voices = controller.getAllVoiceModel!.voices!.map((v) {
          return {
            "voice_id": v.id,
            "voiceName": v.voiceName,
            "isDefault": v.isDefault,
            "sampleFilePath": v.sampleFilePath,
            "description": v.description
          };
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double h = SizeConfig.screenHeight!;
    double w = SizeConfig.screenWidth!;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/bgimage.png",
              fit: BoxFit.cover,
            ),
          ),

          Column(
            children: [
              SizedBox(height: h * 0.12),

              Center(
                child: Image.asset(
                  "assets/images/geminiimage.png",
                  width: w,
                  height: h * 0.30,
                  fit: BoxFit.contain,
                ),
              ),

              SizedBox(height: h * 0.08),

              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: w * 0.05),
                  itemCount: voices.length,
                  itemBuilder: (context, index) {
                    final voice = voices[index];
                    final bool isSelected =
                        selectedVoiceId == voice["voice_id"];

                    return GestureDetector(
                      onTap: () => selectVoice(voice["voice_id"],setVoicecontroller),
                      child: Container(
                        margin: EdgeInsets.only(bottom: h * 0.02),
                        padding: EdgeInsets.symmetric(
                            horizontal: w * 0.04, vertical: h * 0.015),
                        width: w * 0.8,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(
                            color: isSelected ? Colors.amber : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/icons/Waveform.png',
                                  height: 24,
                                  width: 24,
                                  color: isSelected
                                      ? Colors.amber
                                      : Colors.amberAccent,
                                ),
                                SizedBox(width: w * 0.03),
                                Text(
                                  voice["voiceName"],
                                  style: const TextStyle(
                                    fontFamily: "Arial",
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),

                            if (isSelected && isLoading)
                              SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: Colors.white,
                                ),
                              )
                            else if (voice["isDefault"] == true)
                              Row(
                                children: [
                                  const Text(
                                    "Set as default",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Arial",
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Image.asset(
                                    "assets/images/whiteright.png",
                                    height: 13,
                                    width: 13,
                                  ),
                                ],
                              )
                            else
                              const SizedBox(),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // -------------------------------------
  // Select Voice & Call API
  // -------------------------------------
  void selectVoice(int id,DefaultVoiceController controller) async {
    setState(() {
      selectedVoiceId = id;
      isLoading = true;
    });

    // TODO: replace with your setDefaultVoice API
    controller.setDefault({"user_voice_id": id});
    await Future.delayed(Duration(seconds: 2)); // mock API delay

    for (var v in voices) {
      v["isDefault"] = false;
    }

    voices.firstWhere((v) => v["voice_id"] == id)["isDefault"] = true;

    setState(() {
      isLoading = false;
    });
  }
}
