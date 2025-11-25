import 'package:get/get.dart';
import 'package:story_hug/controller/SubCategoryController.dart';
import 'package:story_hug/data/remote_data_source.dart';
import 'package:story_hug/repositories/SubCategoryRepo.dart';

class SubCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubCategoryController>(
          () => SubCategoryController(
        subCategoryrepo: SubCategoryImpl(
          remoteDataSource: RemoteDataSourceImpl(),
        ),
      ),
    );
  }
}