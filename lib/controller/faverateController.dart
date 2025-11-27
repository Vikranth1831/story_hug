import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:story_hug/models/CategoryModel.dart';
import 'package:story_hug/repositories/CategoryRepo.dart';
import 'package:story_hug/repositories/faveratesRepo.dart';

import '../models/AddToFaverateModel.dart';
import '../models/FaveratesModel.dart';
import '../models/SubCategoryModel.dart';
import '../models/SubSubOfCategoryModel.dart';
import '../repositories/SubCategoryRepo.dart';
import '../repositories/SubSubCategoryRepo.dart';

// class FaverateListController extends GetxController {
//   final FaveratesListRepo faveratesListRepo;
//   FaverateListController({required this.faveratesListRepo});
//
//   var isLoading = false.obs;
//   Rx<FaveratesModel?> favrateList = Rx<FaveratesModel?>(null);
//
//   final RxnString errorMessage = RxnString();
//
//   Future<void> fetchFaveratesList(String childId) async {
//     try {
//       isLoading.value = true;
//       final result = await faveratesListRepo.fetchFaverateList(childId);
//
//       if (result != null) {
//         favrateList.value = result;
//         errorMessage.value = null; // clear previous error
//       } else {
//         errorMessage.value = "Unable to load job details";
//       }
//     } catch (e) {
//       errorMessage.value = e.toString();
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }
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

  // 👇 NEW: remove one favourite from the list by favourite ID
  void removeFavouriteById(int favId) {
    final model = favrateList.value;
    final list = model?.favourate;
    if (model == null || list == null) return;

    list.removeWhere((e) => e.id == favId); // id: 24 from your log
    favrateList.refresh(); // 🔥 trigger Obx to rebuild
  }
}


class AddToFaverateController extends GetxController {
  final FaveratesListRepo faveratesListRepo;
  AddToFaverateController({required this.faveratesListRepo});

  var isLoading = false.obs;
  Rx<AddToFaverateModel?> favrateList = Rx<AddToFaverateModel?>(null);

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
