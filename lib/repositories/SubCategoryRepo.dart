import '../data/remote_data_source.dart';
import '../models/SubCategoryModel.dart';

abstract class SubCategoryrepo {
  Future<SubCategoryModel?> fetchSubCategory(String catId);
}

class SubCategoryImpl implements SubCategoryrepo {
  RemoteDataSource remoteDataSource;
  SubCategoryImpl({required this.remoteDataSource});

  @override
  Future<SubCategoryModel?> fetchSubCategory(String catId) async {
    return await remoteDataSource.fetchSubCategory(catId);
  }
}
