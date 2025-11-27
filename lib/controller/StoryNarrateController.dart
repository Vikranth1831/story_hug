import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get.dart';
import 'package:story_hug/app_routes/app_routes.dart';
import 'package:story_hug/models/create_child_model.dart';
import 'package:story_hug/models/register_model.dart';

import 'package:story_hug/pages/creating_profile_for_kids/manage_kids.dart';
import 'package:story_hug/pages/lets-begin.dart';
import 'package:story_hug/repositories/create_child_repository.dart';

import '../models/StroyNarrateModel.dart';
import '../repositories/StoryNarrateRepo.dart';
import '../repositories/auth_repository.dart';
import '../models/login_model.dart';
import '../services/AuthService.dart';

class StoryNarrateController extends GetxController {
  final StoryNarrateRepository storyNarrateRepository;

  StoryNarrateController({required this.storyNarrateRepository});

  var isLoading = false.obs;

  Rx<StroyNarrateModel?> storyNarrate = Rx<StroyNarrateModel?>(null);

  Future<void> storyNarrates(Map<String, dynamic> data) async {
    try {
      isLoading.value = true;

      final storyNarrate = await storyNarrateRepository.storyNarrate(data);
      if (storyNarrate != null && storyNarrate.success == true) {
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
