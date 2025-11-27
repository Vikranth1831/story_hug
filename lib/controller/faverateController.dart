import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:story_hug/models/CategoryModel.dart';
import 'package:story_hug/repositories/CategoryRepo.dart';
import 'package:story_hug/repositories/faveratesRepo.dart';

import '../models/FaveratesModel.dart';
import '../models/SubCategoryModel.dart';
import '../models/SubSubOfCategoryModel.dart';
import '../repositories/SubCategoryRepo.dart';
import '../repositories/SubSubCategoryRepo.dart';

class FaverateListController extends GetxController {
  final FaveratesListRepo faveratesListRepo;
  FaverateListController({required this.faveratesListRepo});

  var isLoading = false.obs;
  Rx<FaveratesModel?> favrateList = Rx<FaveratesModel?>(null);

  final RxnString errorMessage = RxnString();

  Future<void> fetchFaveratesList(String childId) async {
    try {
      isLoading.value = true;
      final result = await faveratesListRepo.fetchFaverateList(childId);

      if (result != null) {
        favrateList.value = result;
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

class AddToFaverateController extends GetxController {
  final FaveratesListRepo faveratesListRepo;
  AddToFaverateController({required this.faveratesListRepo});

  var isLoading = false.obs;
  Rx<FaveratesModel?> favrateList = Rx<FaveratesModel?>(null);

  final RxnString errorMessage = RxnString();

  Future<void> addToFaveratesList(Map<String, dynamic> data) async {
    try {
      isLoading.value = true;
      final result = await faveratesListRepo.addToFaverateList(data);

      if (result != null) {
        favrateList.value = result;
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
