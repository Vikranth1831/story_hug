import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:story_hug/models/CategoryModel.dart';
import 'package:story_hug/models/SubScriptionModel.dart';
import 'package:story_hug/models/VerifyPaymentModel.dart';
import 'package:story_hug/repositories/CategoryRepo.dart';
import 'package:story_hug/repositories/SubScriptionRepo.dart';

import '../models/CreatePaymentModel.dart';
import '../models/SubCategoryModel.dart';
import '../models/SubSubOfCategoryModel.dart';
import '../repositories/SubCategoryRepo.dart';
import '../repositories/SubSubCategoryRepo.dart';
import '../repositories/payment_repository.dart';

class PaymentController extends GetxController {
  final PaymentRepository paymentRepository;
  PaymentController({required this.paymentRepository});

  var isLoading = false.obs;
  Rx<CreatePaymentModel?> createPayment = Rx<CreatePaymentModel?>(null);

  final RxnString errorMessage = RxnString();

  Future<void> createPayments(Map<String, dynamic> data) async {
    try {
      isLoading.value = true;
      final result = await paymentRepository.createPayment(data);

      if (result != null) {
        createPayment.value = result;
        errorMessage.value = null;
      } else {
        errorMessage.value = "Unable to load job details";
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

}

class VerifyPaymentController extends GetxController {
  final PaymentRepository paymentRepository;
  VerifyPaymentController({required this.paymentRepository});

  var isLoading = false.obs;
  Rx<VerifyPaymentModel?> verifyPayment = Rx<VerifyPaymentModel?>(null);

  final RxnString errorMessage = RxnString();

  Future<VerifyPaymentModel?> createPayments(Map<String, dynamic> data) async {
    try {
      isLoading.value = true;
      final result = await paymentRepository.verifyPayment(data);

      if (result != null && result.success == true) {
        verifyPayment.value = result;
        errorMessage.value = null;
        return result;
      } else {
        errorMessage.value = "Unable to load job details";
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
