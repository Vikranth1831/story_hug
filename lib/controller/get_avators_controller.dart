import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get.dart';
import 'package:story_hug/app_routes/app_routes.dart';
import 'package:story_hug/models/create_child_model.dart';
import 'package:story_hug/models/get_all_children_model.dart';
import 'package:story_hug/models/get_avators.dart';
import 'package:story_hug/models/register_model.dart';

import 'package:story_hug/pages/creating_profile_for_kids/manage_kids.dart';
import 'package:story_hug/pages/lets-begin.dart';
import 'package:story_hug/repositories/create_child_repository.dart';
import 'package:story_hug/repositories/get_all_children_repository.dart';
import 'package:story_hug/repositories/getavators_repository.dart';

import '../repositories/auth_repository.dart';
import '../models/login_model.dart';
import '../services/AuthService.dart';
class GetAvatorsController extends GetxController {
  final  GetavatorsRepository repository;

  GetAvatorsController({required this.repository});

  var isLoading = false.obs;

  var avatorsList = <Data>[].obs;

  AvatorsModel? avatorsModel;


  Future<void> getAvators() async {
    try {
      isLoading.value = true;

      avatorsModel= await repository.getAvators();
      if (avatorsModel != null && avatorsModel?.success == true) {
        isLoading.value=false;
        avatorsList.assignAll(avatorsModel!.data ?? []);
        print("Fetched  Children");
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