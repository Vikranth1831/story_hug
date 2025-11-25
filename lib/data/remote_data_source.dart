import 'dart:developer' as AppLogger;

import 'package:dio/dio.dart';
import '../core/endpoints.dart';
import '../models/login_model.dart';
import '../services/ApiClient.dart';


abstract class RemoteDataSource {
  Future<LoginModel?> login(Map<String, dynamic> data);

}

class RemoteDataSourceImpl implements RemoteDataSource {
  final Dio dio = Dio();


  @override
  Future<LoginModel?> login(Map<String, dynamic> data) async {
    try {
      final res = await ApiClient.post("${APIEndpointUrls.login}", data: data);
      AppLogger.log('login : ${res.data}');
      return LoginModel.fromJson(res.data);
    } catch (e) {
     // AppLogger.error('login : $e');
      return null;
    }
  }
}
