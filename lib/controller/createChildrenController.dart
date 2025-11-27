import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get.dart';
import 'package:story_hug/app_routes/app_routes.dart';
import 'package:story_hug/models/create_child_model.dart';
import 'package:story_hug/models/register_model.dart';

import 'package:story_hug/pages/creating_profile_for_kids/manage_kids.dart';
import 'package:story_hug/pages/lets-begin.dart';
import 'package:story_hug/repositories/create_child_repository.dart';

import '../repositories/auth_repository.dart';
import '../models/login_model.dart';
import '../services/AuthService.dart';
class CreatechildrenController extends GetxController {
  final  CreateChildRepository repository;

  CreatechildrenController({required this.repository});

  var isLoading = false.obs;

  CreateChildrenModel? createChildrenModel;


  Future<void> createChildren(Map<String, dynamic> data) async {
    try {
      isLoading.value = true;

      createChildrenModel= await repository.createChildren(data);
      if (createChildrenModel != null && createChildrenModel?.success == true) {
        print("Created Children");
        Get.to(() => ManageKids());
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