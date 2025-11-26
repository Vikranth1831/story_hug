import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get.dart';
import 'package:story_hug/app_routes/app_routes.dart';
import 'package:story_hug/models/create_child_model.dart';
import 'package:story_hug/models/get_all_children_model.dart';
import 'package:story_hug/models/register_model.dart';
import 'package:story_hug/models/sample_text_model.dart';

import 'package:story_hug/pages/creating_profile_for_kids/manage_kids.dart';
import 'package:story_hug/pages/lets-begin.dart';
import 'package:story_hug/repositories/create_child_repository.dart';
import 'package:story_hug/repositories/get_all_children_repository.dart';
import 'package:story_hug/repositories/sample_text_repository.dart';

import '../repositories/auth_repository.dart';
import '../models/login_model.dart';
import '../services/AuthService.dart';
class Sampletextcontroller extends GetxController {
  final  SampleTextRepository repository;

  Sampletextcontroller({required this.repository});

  var isLoading = false.obs;

  var sampletext = "".obs;

  SampleTextModel? sampleTextModel;


  Future<void> getSampleText() async {
    try {
      isLoading.value = true;

      sampleTextModel= await repository.getSampleText();
      if (sampleTextModel != null && sampleTextModel?.success == true) {
        isLoading.value=false;
        sampletext.value= sampleTextModel?.text??'';
        print("Fetched Sample Text");
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