import 'dart:developer' as AppLogger;

import 'package:dio/dio.dart';
import 'package:story_hug/models/create_child_model.dart';
import 'package:story_hug/models/get_all_children_model.dart';
import 'package:story_hug/models/register_model.dart';
import 'package:story_hug/repositories/get_all_children_repository.dart';
import '../core/endpoints.dart';
import '../models/login_model.dart';
import '../services/ApiClient.dart';

abstract class RemoteDataSource {
  Future<LoginModel?> login(Map<String, dynamic> data);
  Future<RegisterModel?> register(Map<String, dynamic> data);
  Future<CreateChildrenModel?> createChildren(Map<String, dynamic> data);

  Future<GetAllChildrenModel?> getAllChildren();

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
      print('login : $e');
      return null;
    }
  }

  @override
  Future<RegisterModel?> register(Map<String, dynamic> data) async {
    try {
      final res = await ApiClient.post(
        "${APIEndpointUrls.register}",
        data: data,
      );
      AppLogger.log('Register : ${res.data}');
      return RegisterModel.fromJson(res.data);
    } catch (e) {
      // AppLogger.error('login : $e');
      return null;
    }
  }
  @override
  Future<CreateChildrenModel?> createChildren(Map<String, dynamic> data) async {
    try {
      final res = await ApiClient.post(
        "${APIEndpointUrls.createChildren}",
        data: data,
      );
      AppLogger.log('Register : ${res.data}');
      return CreateChildrenModel.fromJson(res.data);
    } catch (e) {
      // AppLogger.error('login : $e');
      return null;
    }
  }
  @override
  Future<GetAllChildrenModel?> getAllChildren() async {
    try {
      final res = await ApiClient.get(
        "${APIEndpointUrls.getAllChildren}",

      );
      AppLogger.log('Register : ${res.data}');
      return GetAllChildrenModel.fromJson(res.data);
    } catch (e) {
      // AppLogger.error('login : $e');
      return null;
    }
  }
}
