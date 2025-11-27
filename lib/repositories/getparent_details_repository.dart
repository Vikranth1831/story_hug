

import 'package:story_hug/models/ParentNameModel.dart';
import 'package:story_hug/models/create_child_model.dart';
import 'package:story_hug/models/gel_all_voices_model.dart';
import 'package:story_hug/models/get_all_children_model.dart';
import 'package:story_hug/models/register_model.dart';

import '../data/remote_data_source.dart';
import '../models/login_model.dart';

abstract class GetParentDetailsRepository{

  Future<GetParentDetailsModel?> getParentDetails();
}

class GetParentDetailsRepositoryImpl implements GetParentDetailsRepository{
  RemoteDataSource remoteDataSource;
  GetParentDetailsRepositoryImpl({required this.remoteDataSource});


  @override
  Future <GetParentDetailsModel?> getParentDetails() async {
    return await remoteDataSource.getParentDetails();
  }
}
