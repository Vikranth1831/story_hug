import '../data/remote_data_source.dart';
import '../models/AddToFaverateModel.dart';
import '../models/FaveratesModel.dart';
import '../models/SubCategoryModel.dart';
import '../models/SubScriptionModel.dart';
import '../models/SubSubOfCategoryModel.dart';

abstract class FaveratesListRepo {
  Future<FaveratesModel?> fetchFaverateList(String childId);
  Future<AddToFaverateModel?> addToFaverateList(Map<String, dynamic> data);
}

class FaveratesListImpl implements FaveratesListRepo {
  RemoteDataSource remoteDataSource;
  FaveratesListImpl({required this.remoteDataSource});

  @override
  Future<FaveratesModel?> fetchFaverateList(String childId) async {
    return await remoteDataSource.fetchFaverateList(childId);
  }

  @override
  Future<AddToFaverateModel?> addToFaverateList(Map<String, dynamic> data) async {
    return await remoteDataSource.addFaveraToteList(data);
  }
}
