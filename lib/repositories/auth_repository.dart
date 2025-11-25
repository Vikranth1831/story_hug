

import 'package:story_hug/models/register_model.dart';

import '../data/remote_data_source.dart';
import '../models/login_model.dart';

abstract class AuthRepository {
  Future<LoginModel?> login(Map<String, dynamic> data);
  Future<RegisterModel?> register(Map<String, dynamic> data);
}

class AuthRepositoryImpl implements AuthRepository{
  RemoteDataSource remoteDataSource;
  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<LoginModel?> login(Map<String, dynamic> data) async {
    return await remoteDataSource.login(data);
  }
  @override
  Future<RegisterModel?> register(Map<String, dynamic> data) async {
    return await remoteDataSource.register(data);
  }
}
