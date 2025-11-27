

import 'package:story_hug/models/create_child_model.dart';
import 'package:story_hug/models/otp_verified_model.dart';
import 'package:story_hug/models/password_update_model.dart';
import 'package:story_hug/models/register_model.dart';

import '../data/remote_data_source.dart';
import '../models/login_model.dart';

abstract class UpdatePasswordRepository {
  Future<PasswordUpdateModel?> updatepassword(Map<String, dynamic> data);

}

class UpdatePasswordRepositoryImpl implements UpdatePasswordRepository{
  RemoteDataSource remoteDataSource;
  UpdatePasswordRepositoryImpl({required this.remoteDataSource});

  @override
  Future<PasswordUpdateModel?> updatepassword(Map<String, dynamic> data) async {
    return await remoteDataSource.updatepassword(data);
  }

}
