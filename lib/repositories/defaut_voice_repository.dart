

import 'package:story_hug/models/create_child_model.dart';
import 'package:story_hug/models/default_voice_model.dart';
import 'package:story_hug/models/register_model.dart';

import '../data/remote_data_source.dart';
import '../models/login_model.dart';

abstract class DefaultVoiceRepository {

  Future<DefaultVoiceModel?> setDefault(Map<String, dynamic> data);
}

class DefautVoiceRepositoryImpl implements DefaultVoiceRepository{
  RemoteDataSource remoteDataSource;
  DefautVoiceRepositoryImpl ({required this.remoteDataSource});


  @override
  Future<DefaultVoiceModel?> setDefault(Map<String, dynamic> data) async {
    return await remoteDataSource.setDefault(data);
  }
}
