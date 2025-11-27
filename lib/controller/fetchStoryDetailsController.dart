import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:story_hug/models/CategoryModel.dart';
import 'package:story_hug/repositories/CategoryRepo.dart';

import '../models/FetchStorysModel.dart';
import '../models/StoryDetailModel.dart';
import '../models/SubCategoryModel.dart';
import '../repositories/FetchStoryDetailsRepo.dart';
import '../repositories/FetchStoryRepo.dart';
import '../repositories/SubCategoryRepo.dart';

class FetchStoryDetailsController extends GetxController {
  final FetchStoryDetailsRepo fetchStoryDetailsRepo;
  FetchStoryDetailsController({required this.fetchStoryDetailsRepo});

  var isLoading = false.obs;
  Rx<StoryDetailModel?> fetchStory = Rx<StoryDetailModel?>(null);

  final RxnString errorMessage = RxnString();

  Future<void> fetchStoryDetails(String storyId) async {
    try {
      isLoading.value = true;
      final result = await fetchStoryDetailsRepo.fetchStoryDetails(storyId);

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
