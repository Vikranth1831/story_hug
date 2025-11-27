import '../data/remote_data_source.dart';
import '../models/FetchStorysModel.dart';
import '../models/SubCategoryModel.dart';
import '../models/SubScriptionModel.dart';
import '../models/SubSubOfCategoryModel.dart';

abstract class FetchStoryRepo {
  Future<FetchStorysModel?> fetchStory(String storyId);
}

class FetchStoryImpl implements FetchStoryRepo {
  RemoteDataSource remoteDataSource;
  FetchStoryImpl({required this.remoteDataSource});

  @override
  Future<FetchStorysModel?> fetchStory(String storyId) async {
    return await remoteDataSource.fetchStory(storyId);
  }
}
