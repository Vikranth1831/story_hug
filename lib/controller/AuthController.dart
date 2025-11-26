import 'package:get/get.dart';
import 'package:story_hug/models/create_child_model.dart';
import 'package:story_hug/models/register_model.dart';
import 'package:story_hug/pages/Section1/Home.dart';
import 'package:story_hug/pages/creating_profile_for_kids/manage_kids.dart';
import 'package:story_hug/pages/lets-begin.dart';

import '../app_routes/app_routes.dart';
import '../repositories/auth_repository.dart';
import '../models/login_model.dart';
import '../services/AuthService.dart';

class AuthController extends GetxController {
  final AuthRepository repository;

  AuthController({required this.repository});

  var isLoading = false.obs;
  LoginModel? loginModel;
  RegisterModel? registerModel;
  CreateChildrenModel? createChildrenModel;

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

        Get.offAllNamed(Routes.HomeScreen);
      } else {
        // AppSnackbar.error(loginModel?.message ?? "Login failed");
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
        print("Register sucess");
        Get.offAllNamed(Routes.HomeScreen);
      } else {
        // AppSnackbar.error(loginModel?.message ?? "Login failed");
      }
    } catch (e) {
      //  AppSnackbar.exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createChildren(Map<String, dynamic> data) async {
    try {
      isLoading.value = true;

      createChildrenModel = await repository.createChildren(data);
      if (createChildrenModel != null && createChildrenModel?.success == true) {
        print("Created Children");
        Get.offAll(() => ManageKids());
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
