import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:story_hug/models/CategoryModel.dart';
import 'package:story_hug/repositories/CategoryRepo.dart';

import '../models/FetchStorysModel.dart';
import '../models/SubCategoryModel.dart';
import '../repositories/FetchStoryRepo.dart';
import '../repositories/SubCategoryRepo.dart';

class FetchStoryController extends GetxController {
  final FetchStoryRepo fetchStoryRepo;
  FetchStoryController({required this.fetchStoryRepo});

  var isLoading = false.obs;
  Rx<FetchStorysModel?> fetchStory = Rx<FetchStorysModel?>(null);

  final RxnString errorMessage = RxnString();

  Future<void> fetchStorys(String storyId) async {
    try {
      isLoading.value = true;
      final result = await fetchStoryRepo.fetchStory(storyId);

      if (result != null) {
        fetchStory.value = result;
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
