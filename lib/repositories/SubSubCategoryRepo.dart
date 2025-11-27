import '../data/remote_data_source.dart';
import '../models/SubCategoryModel.dart';
import '../models/SubSubOfCategoryModel.dart';

abstract class SubSubCategoryrepo {
  Future<SubSubOfCategoryModel?> fetchSubSubCategory(String catId);
}

class SubSubCategoryImpl implements SubSubCategoryrepo {
  RemoteDataSource remoteDataSource;
  SubSubCategoryImpl({required this.remoteDataSource});

  @override
  Future<SubSubOfCategoryModel?> fetchSubSubCategory(String catId) async {
    return await remoteDataSource.fetchSubSubCategory(catId);
  }
}
