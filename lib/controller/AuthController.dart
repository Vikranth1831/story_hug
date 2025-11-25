import 'package:get/get.dart';
import 'package:story_hug/models/register_model.dart';
import 'package:story_hug/pages/Section1/menu.dart';
import 'package:story_hug/pages/lets-begin.dart';

import '../repositories/auth_repository.dart';
import '../models/login_model.dart';
import '../services/AuthService.dart';

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
        // await AuthService.saveTokens(
        //   loginModel?.data?.accessToken ?? "",
        //   loginModel?.data?.refreshToken ?? "",
        //   loginModel?.data?.accessTokenExpiry ?? 0,
        //   loginModel?.data?.user?.email ?? '',
        // );
        // AppSnackbar.success("Login Successful");
        print("Login Sucessful");
        Get.offAll(() => LetsBegin());
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
    registerModel  = await repository.login(data);
      if (registerModel != null && registerModel?.success == true) {
        // await AuthService.saveTokens(
        //   loginModel?.data?.accessToken ?? "",
        //   loginModel?.data?.refreshToken ?? "",
        //   loginModel?.data?.accessTokenExpiry ?? 0,
        //   loginModel?.data?.user?.email ?? '',
        // );
        // AppSnackbar.success("Login Successful");
        print("Login Sucessful");
        Get.offAll(() => LetsBegin());
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
