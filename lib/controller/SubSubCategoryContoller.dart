import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:story_hug/models/CategoryModel.dart';
import 'package:story_hug/repositories/CategoryRepo.dart';

import '../models/SubCategoryModel.dart';
import '../models/SubSubOfCategoryModel.dart';
import '../repositories/SubCategoryRepo.dart';
import '../repositories/SubSubCategoryRepo.dart';

class SubSubCategoryController extends GetxController {
  final SubSubCategoryrepo subSubCategoryrepo;
  SubSubCategoryController({required this.subSubCategoryrepo});

  var isLoading = false.obs;
  Rx<SubSubOfCategoryModel?> subSubCategory = Rx<SubSubOfCategoryModel?>(null);

  final RxnString errorMessage = RxnString();

  Future<void> fetchSubSubCategory(String catId) async {
    try {
      isLoading.value = true;
      final result = await subSubCategoryrepo.fetchSubSubCategory(catId);

      if (result != null) {
        subSubCategory.value = result;
        errorMessage.value = null; // clear previous error
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
