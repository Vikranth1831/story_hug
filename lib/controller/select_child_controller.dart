import 'package:get/get.dart';
import 'package:story_hug/models/create_child_model.dart';
import 'package:story_hug/models/otp_verified_model.dart';
import 'package:story_hug/models/password_update_model.dart';
import 'package:story_hug/models/register_model.dart';
import 'package:story_hug/models/select_child_model.dart';
import 'package:story_hug/pages/Passwordchange/passwordchange.dart';
import 'package:story_hug/pages/Section1/Home.dart';
import 'package:story_hug/pages/SuccesspageClass/successpage.dart';
import 'package:story_hug/pages/creating_profile_for_kids/manage_kids.dart';
import 'package:story_hug/pages/lets-begin.dart';
import 'package:story_hug/repositories/select_child_repository.dart';
import 'package:story_hug/repositories/update_password_repository.dart';
import 'package:story_hug/repositories/verify_otp_repository.dart';

import '../app_routes/app_routes.dart';
import '../repositories/auth_repository.dart';
import '../models/login_model.dart';
import '../services/AuthService.dart';

class SelectChildController extends GetxController {
  final SelectChildRepository repository;

  SelectChildController({required this.repository});

  var isLoading = false.obs;

  SelectChildModel ? selectChildModel;


  Future<void> selectchild(Map<String, dynamic> data) async {
    try {
      isLoading.value = true;
      selectChildModel = await repository.selectchild(data);
      if (selectChildModel != null && selectChildModel?.success == true) {

       Get.to(()=>HomeScreen());
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
