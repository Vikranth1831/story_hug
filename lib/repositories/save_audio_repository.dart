

import 'package:dio/dio.dart';
import 'package:story_hug/models/SaveAudioModel.dart';
import 'package:story_hug/models/create_child_model.dart';
import 'package:story_hug/models/register_model.dart';

import '../data/remote_data_source.dart';
import '../models/login_model.dart';

abstract class SaveAudioRepository {
  Future<SaveAudioModel?> saveaudio(FormData data);

}

class SaveAudioRepositoryImpl implements SaveAudioRepository{
  RemoteDataSource remoteDataSource;

  SaveAudioRepositoryImpl({required this.remoteDataSource});

  @override
  Future<SaveAudioModel?> saveaudio(FormData data) async {
    try {
      return await remoteDataSource.saveaudio(data);
    } catch (e) {
      print('SaveAudioRepositoryImpl.saveaudio error: $e');
      return null;
    }
  }

}
