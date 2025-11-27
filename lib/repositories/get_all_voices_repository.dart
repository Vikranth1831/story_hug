

import 'package:story_hug/models/create_child_model.dart';
import 'package:story_hug/models/gel_all_voices_model.dart';
import 'package:story_hug/models/get_all_children_model.dart';
import 'package:story_hug/models/register_model.dart';

import '../data/remote_data_source.dart';
import '../models/login_model.dart';

abstract class GetAllVoicesRepository {

  Future<GetAllVoiceModel?> getAllVoice();
}

class GetAllVoicesRepositoryImpl implements GetAllVoicesRepository{
  RemoteDataSource remoteDataSource;
  GetAllVoicesRepositoryImpl({required this.remoteDataSource});


  @override
  Future <GetAllVoiceModel?> getAllVoice() async {
    return await remoteDataSource.getAllVoice();
  }
}
