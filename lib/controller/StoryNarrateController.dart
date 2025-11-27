// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import 'package:get/get.dart';
//
// import '../models/StroyNarrateModel.dart';
// import '../repositories/StoryNarrateRepo.dart';
//
// class StoryNarrateController extends GetxController {
//   final StoryNarrateRepository storyNarrateRepository;
//
//   StoryNarrateController({required this.storyNarrateRepository});
//
//   var isLoading = false.obs;
//
//   Rx<StroyNarrateModel?> storyNarrate = Rx<StroyNarrateModel?>(null);
//
//   Future<void> storyNarrates(Map<String, dynamic> data) async {
//     try {
//       isLoading.value = true;
//
//       final storyNarrate = await storyNarrateRepository.storyNarrate(data);
//       if (storyNarrate != null && storyNarrate.success == true) {
//       } else {
//         // AppSnackbar.error(loginModel?.message ?? "Login failed");
//       }
//     } catch (e) {
//       //  AppSnackbar.exception(e.toString());
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }
import 'package:get/get.dart';
import '../models/StroyNarrateModel.dart';
import '../repositories/StoryNarrateRepo.dart';
// StoryNarrateController.dart
class StoryNarrateController extends GetxController {
  final StoryNarrateRepository storyNarrateRepository;

  StoryNarrateController({required this.storyNarrateRepository});

  var isLoading = false.obs;

  // This is correct: public Rx observable
  final Rx<StroyNarrateModel?> storyNarrate = Rx<StroyNarrateModel?>(null);

  Future<void> storyNarrates(Map<String, dynamic> data) async {
    try {
      isLoading.value = true;

      final response = await storyNarrateRepository.storyNarrate(data);

      if (response != null && response.success == true) {
        storyNarrate.value = response;  // THIS LINE WAS MISSING!
        print("Narration saved: ${response.data?.audioUrl}");
      } else {
        storyNarrate.value = null;
      }
    } catch (e) {
      print("Error: $e");
      storyNarrate.value = null;
    } finally {
      isLoading.value = false;
    }
  }
}