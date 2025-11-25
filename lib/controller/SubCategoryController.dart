import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:story_hug/models/CategoryModel.dart';
import 'package:story_hug/repositories/CategoryRepo.dart';

import '../models/SubCategoryModel.dart';
import '../repositories/SubCategoryRepo.dart';

class SubCategoryController extends GetxController {
  final SubCategoryrepo subCategoryrepo;
  SubCategoryController({required this.subCategoryrepo});

  var isLoading = false.obs;
  Rx<SubCategoryModel?> subCategory = Rx<SubCategoryModel?>(null);

  final RxnString errorMessage = RxnString();

  Future<void> fetchSubCategory(int catId) async {
    try {
      isLoading.value = true;
      final result = await subCategoryrepo.fetchSubCategory(catId);

      if (result != null) {
        subCategory.value = result;
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
