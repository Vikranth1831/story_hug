import 'dart:io';
import 'package:get/get.dart';

class AudioController extends GetxController {
  /// keep path as before (optional)
  String audioPath = "";

  /// store actual File (nullable)
  File? audioFile;

  /// Save audio path after recording stops (keeps backward compatibility)
  void setAudioPath(String path) {
    audioPath = path;
    update();  // notify UI if needed
  }

  /// Save the File object (preferred) after recording stops
  void setAudioFile(File file) {
    audioFile = file;
    audioPath = file.path;
    update();
  }

  /// Clear audio path and file (if user re-records)
  void clearAudio() {
    audioPath = "";
    audioFile = null;
    update();
  }
}
