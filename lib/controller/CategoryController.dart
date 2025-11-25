import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:story_hug/models/CategoryModel.dart';
import 'package:story_hug/repositories/CategoryRepo.dart';


class CategoryController extends GetxController {
  final Categoryrepo categoryrepo;
  CategoryController({required this.categoryrepo});

  var isLoading = false.obs;
  Rx<CategoryModel?> category = Rx<CategoryModel?>(null);


  final RxnString errorMessage = RxnString();

  Future<void> fetchCategory() async {
    try {
      isLoading.value = true;
      final result = await categoryrepo.category();

      if (result != null) {
        category.value = result;
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

