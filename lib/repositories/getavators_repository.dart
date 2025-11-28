

import 'package:story_hug/models/create_child_model.dart';
import 'package:story_hug/models/get_all_children_model.dart';
import 'package:story_hug/models/get_avators.dart';
import 'package:story_hug/models/register_model.dart';

import '../data/remote_data_source.dart';
import '../models/login_model.dart';

abstract class GetavatorsRepository {

  Future<AvatorsModel?> getAvators();
}

class GetAvatorsRepositoryImpl implements GetavatorsRepository{
  RemoteDataSource remoteDataSource;
  GetAvatorsRepositoryImpl({required this.remoteDataSource});



  @override
  Future<AvatorsModel?> getAvators() async {
    return await remoteDataSource.getAvators();
  }
}
