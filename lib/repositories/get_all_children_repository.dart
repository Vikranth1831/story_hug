

import 'package:story_hug/models/create_child_model.dart';
import 'package:story_hug/models/get_all_children_model.dart';
import 'package:story_hug/models/register_model.dart';

import '../data/remote_data_source.dart';
import '../models/login_model.dart';

abstract class GetAllChildrenRepository {

  Future<GetAllChildrenModel?> getAllChildren();
}

class GetAllChildrenRepositoryImpl implements GetAllChildrenRepository{
  RemoteDataSource remoteDataSource;
  GetAllChildrenRepositoryImpl({required this.remoteDataSource});


  @override
  Future<GetAllChildrenModel?> getAllChildren() async {
    return await remoteDataSource.getAllChildren();
  }
}
