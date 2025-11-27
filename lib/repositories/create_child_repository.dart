

import 'package:story_hug/models/create_child_model.dart';
import 'package:story_hug/models/register_model.dart';

import '../data/remote_data_source.dart';
import '../models/login_model.dart';

abstract class CreateChildRepository {

  Future<CreateChildrenModel?> createChildren(Map<String, dynamic> data);
}

class CreateChildRepositoryImpl implements CreateChildRepository{
  RemoteDataSource remoteDataSource;
  CreateChildRepositoryImpl({required this.remoteDataSource});


  @override
  Future<CreateChildrenModel?> createChildren(Map<String, dynamic> data) async {
    return await remoteDataSource.createChildren(data);
  }
}
