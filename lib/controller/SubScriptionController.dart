import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:story_hug/models/CategoryModel.dart';
import 'package:story_hug/models/SubScriptionModel.dart';
import 'package:story_hug/repositories/CategoryRepo.dart';
import 'package:story_hug/repositories/SubScriptionRepo.dart';

import '../models/SubCategoryModel.dart';
import '../models/SubSubOfCategoryModel.dart';
import '../repositories/SubCategoryRepo.dart';
import '../repositories/SubSubCategoryRepo.dart';

class SubScriptionController extends GetxController {
  final SubScriptionRepo scriptionRepo;
  SubScriptionController({required this.scriptionRepo});

  var isLoading = false.obs;
  Rx<SubScriptionModel?> subScription = Rx<SubScriptionModel?>(null);

  final RxnString errorMessage = RxnString();

  Future<void> fetchSubScriptions() async {
    try {
      isLoading.value = true;
      final result = await scriptionRepo.fetchSubscriptionPlans();

      if (result != null) {
        subScription.value = result;
        errorMessage.value = null; // clear previous error
      } else {
        errorMessage.value = "Unable to load subscription details";
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
