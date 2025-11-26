import 'package:get/get.dart';
import 'package:story_hug/models/create_child_model.dart';
import 'package:story_hug/models/register_model.dart';
import 'package:story_hug/pages/Section1/Home.dart';
import 'package:story_hug/pages/creating_profile_for_kids/manage_kids.dart';
import 'package:story_hug/pages/lets-begin.dart';

import '../app_routes/app_routes.dart';
import '../pages/Authentication/choose_profile.dart';
import '../repositories/auth_repository.dart';
import '../models/login_model.dart';
import '../services/AuthService.dart';
import '../utils/app_snackbar.dart';

class AuthController extends GetxController {
  final AuthRepository repository;

  AuthController({required this.repository});

  var isLoading = false.obs;
  LoginModel? loginModel;
  RegisterModel? registerModel;


  Future<void> login(Map<String, dynamic> data) async {
    try {
      isLoading.value = true;
      loginModel = await repository.login(data);
      if (loginModel != null && loginModel?.success == true) {
        await AuthService.saveTokens(
          loginModel?.accessToken ?? "",
          loginModel?.refreshToken ?? "",
          loginModel?.accessTokenExpiry ?? 0,
        );

        Get.offAllNamed(Routes.ChooseProfile);
      } else {
        AppSnackBar.show(Get.context!, loginModel?.message ?? "Login failed");

      }
    } catch (e) {
      //  AppSnackbar.exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register(Map<String, dynamic> data) async {
    try {
      isLoading.value = true;

      registerModel = await repository.register(data);
      if (registerModel != null && registerModel?.success == true) {
        await AuthService.saveTokens(
          registerModel?.accessToken ?? "",
          registerModel?.refreshToken ?? "",
          registerModel?.accessTokenExpiry ?? 0,
        );
        print("Register sucess");
        Get.offAllNamed(Routes.LetsBegin);
      } else {
//
  //      AppSnackBar.show(Get.context!,,registerModel?.message ?? "Cannot Register Now");

        // AppSnackbar.error(loginModel?.message ?? "Login failed");
      }
    } catch (e) {
      //  AppSnackbar.exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

}
