import '../data/remote_data_source.dart';
import '../models/SubCategoryModel.dart';

abstract class SubCategoryrepo {
  Future<SubCategoryModel?> fetchSubCategory(int catId);
}

class subCtegoryImpl implements SubCategoryrepo {
  RemoteDataSource remoteDataSource;
  subCtegoryImpl({required this.remoteDataSource});

  @override
  Future<SubCategoryModel?> fetchSubCategory(int catId) async {
    return await remoteDataSource.fetchSubCategory(catId);
  }
}
