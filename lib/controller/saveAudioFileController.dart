import 'package:get/get.dart' hide FormData;
import 'package:dio/dio.dart';
import 'package:story_hug/models/SaveAudioModel.dart';
import 'package:story_hug/models/create_child_model.dart';
import 'package:story_hug/models/register_model.dart';
import 'package:story_hug/pages/Section1/Home.dart';
import 'package:story_hug/pages/creating_profile_for_kids/manage_kids.dart';
import 'package:story_hug/pages/lets-begin.dart';
import 'package:story_hug/repositories/save_audio_repository.dart';

import '../app_routes/app_routes.dart';
import '../repositories/auth_repository.dart';
import '../models/login_model.dart';
import '../services/AuthService.dart';

class SaveAudioController extends GetxController {
  final SaveAudioRepository repository;

  SaveAudioController({required this.repository});

  var isLoading = false.obs;
  SaveAudioModel? saveAudioModel;

  Future<void> saveaudio(FormData data) async {
    try {
      isLoading.value = true;
      saveAudioModel = await repository.saveaudio(data);
      if (SaveAudioModel != null && saveAudioModel?.success== true) {


        Get.offAllNamed(Routes.LetsBegin);
      } else {
        // AppSnackbar.error(loginModel?.message ?? "Login failed");
      }
    } catch (e) {
      //  AppSnackbar.exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
