
import '../data/remote_data_source.dart';
import '../models/CategoryModel.dart';

abstract class Categoryrepo {
  Future<CategoryModel?> category();
}

class CategoryImpl implements Categoryrepo {
  RemoteDataSource remoteDataSource;
  CategoryImpl({required this.remoteDataSource});

  @override
  Future<CategoryModel?> category() async {
    return await remoteDataSource.fetchCategory();
  }
}
