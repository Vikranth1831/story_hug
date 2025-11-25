import 'package:get/get.dart';

import '../repositories/auth_repository.dart';
import '../models/login_model.dart';
import '../services/AuthService.dart';


class AuthController extends GetxController {
  final AuthRepository repository;

  AuthController({required this.repository});

  var isLoading = false.obs;
  LoginModel? loginModel;

  Future<void> login(Map<String, dynamic> data) async {
    try {
      isLoading.value = true;
      loginModel = await repository.login(data);
      if (loginModel != null && loginModel!.status == true) {
        await AuthService.saveTokens(
          loginModel?.data?.accessToken ?? "",
          loginModel?.data?.refreshToken ?? "",
          loginModel?.data?.accessTokenExpiry??0,
          loginModel?.data?.user?.name ?? "",
          loginModel?.data?.user?.email ?? "",
          loginModel?.data?.user?.email??'',
          (loginModel?.data?.user?.phone??'') as int


        );
       // AppSnackbar.success("Login Successful");
        print("Login Sucessful");
       // Get.offAllNamed(Routes.dashboard);
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
