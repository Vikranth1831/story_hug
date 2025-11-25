import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get.dart';
import 'package:story_hug/app_routes/app_routes.dart';
import 'package:story_hug/models/create_child_model.dart';
import 'package:story_hug/models/get_all_children_model.dart';
import 'package:story_hug/models/register_model.dart';
import 'package:story_hug/pages/Section1/menu.dart';
import 'package:story_hug/pages/creating_profile_for_kids/manage_kids.dart';
import 'package:story_hug/pages/lets-begin.dart';
import 'package:story_hug/repositories/create_child_repository.dart';
import 'package:story_hug/repositories/get_all_children_repository.dart';

import '../repositories/auth_repository.dart';
import '../models/login_model.dart';
import '../services/AuthService.dart';
class Getallchildrencontroller extends GetxController {
  final  GetAllChildrenRepository repository;

  Getallchildrencontroller({required this.repository});

  var isLoading = false.obs;

  var childrenList = <Children>[].obs;

  GetAllChildrenModel? getAllChildrenModel;


  Future<void> getAllChildren() async {
    try {
      isLoading.value = true;

      getAllChildrenModel= await repository.getAllChildren();
      if (getAllChildrenModel != null && getAllChildrenModel?.success == true) {
        isLoading.value=false;
        childrenList.assignAll(getAllChildrenModel!.children ?? []);
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