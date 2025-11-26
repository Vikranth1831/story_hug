import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get.dart';
import 'package:story_hug/app_routes/app_routes.dart';
import 'package:story_hug/models/create_child_model.dart';
import 'package:story_hug/models/otp_sent_model.dart';
import 'package:story_hug/models/register_model.dart';
import 'package:story_hug/pages/Authentication/otp-screen.dart';
import 'package:story_hug/pages/Passwordchange/passwordchange.dart';

import 'package:story_hug/pages/creating_profile_for_kids/manage_kids.dart';
import 'package:story_hug/pages/lets-begin.dart';
import 'package:story_hug/repositories/create_child_repository.dart';
import 'package:story_hug/repositories/opt_sent_repository.dart';

import '../repositories/auth_repository.dart';
import '../models/login_model.dart';
import '../services/AuthService.dart';
class SendOtpController extends GetxController {
  final  OtpSentRepository repository;

  SendOtpController({required this.repository});

  var isLoading = false.obs;

  OTPSentModel? otpSentModel;


  Future<void> sendotp() async {
    try {
      isLoading.value = true;

      otpSentModel= await repository.sendotp();
      if (otpSentModel != null && otpSentModel?.success==true ) {
        print("Otp Sent");
        Get.offAll(() => OtpScreen());
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