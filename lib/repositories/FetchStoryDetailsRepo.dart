import '../data/remote_data_source.dart';
import '../models/FetchStorysModel.dart';
import '../models/StoryDetailModel.dart';
import '../models/SubCategoryModel.dart';
import '../models/SubScriptionModel.dart';
import '../models/SubSubOfCategoryModel.dart';

abstract class FetchStoryDetailsRepo {
  Future<StoryDetailModel?> fetchStoryDetails(String storyId);
}

class FetchStoryDetailsImpl implements FetchStoryDetailsRepo {
  RemoteDataSource remoteDataSource;
  FetchStoryDetailsImpl({required this.remoteDataSource});

  @override
  Future<StoryDetailModel?> fetchStoryDetails(String storyId) async {
    return await remoteDataSource.fetchStoryDetails(storyId);
  }
}
