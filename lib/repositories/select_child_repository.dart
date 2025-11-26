import 'package:story_hug/models/create_child_model.dart';
import 'package:story_hug/models/otp_verified_model.dart';
import 'package:story_hug/models/password_update_model.dart';
import 'package:story_hug/models/register_model.dart';
import 'package:story_hug/models/select_child_model.dart';

import '../data/remote_data_source.dart';
import '../models/login_model.dart';

abstract class SelectChildRepository {
  Future<SelectChildModel?> selectchild(Map<String, dynamic> data);

}

class SelectChildRepositoryImpl implements SelectChildRepository{
  RemoteDataSource remoteDataSource;
  SelectChildRepositoryImpl({required this.remoteDataSource});

  @override
  Future<SelectChildModel?> selectchild(Map<String, dynamic> data) async {
    return await remoteDataSource.selectchild(data);
  }

}
