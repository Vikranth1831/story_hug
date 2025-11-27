
import '../data/remote_data_source.dart';
import '../models/StroyNarrateModel.dart';

abstract class StoryNarrateRepository {
  Future<StroyNarrateModel?> storyNarrate(Map<String, dynamic> data);
}

class StoryNarrateImpl implements StoryNarrateRepository {
  RemoteDataSource remoteDataSource;
  StoryNarrateImpl({required this.remoteDataSource});

  @override
  Future<StroyNarrateModel?> storyNarrate(Map<String, dynamic> data) async {
    return await remoteDataSource.storyNarrate(data);
  }
}
