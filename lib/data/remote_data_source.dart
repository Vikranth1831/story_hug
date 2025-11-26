import 'package:dio/dio.dart';
import 'package:story_hug/models/SaveAudioModel.dart';
import 'package:story_hug/models/create_child_model.dart';
import 'package:story_hug/models/get_all_children_model.dart';
import 'package:story_hug/models/register_model.dart';
import 'package:story_hug/models/sample_text_model.dart';
import 'package:story_hug/repositories/get_all_children_repository.dart';
import '../core/endpoints.dart';
import '../models/CategoryModel.dart';
import '../models/SubCategoryModel.dart';
import '../models/login_model.dart';
import '../pages/recording_voice/save_voice.dart';
import '../services/ApiClient.dart';
import '../utils/AppLogger.dart';

abstract class RemoteDataSource {
  Future<LoginModel?> login(Map<String, dynamic> data);
  Future<RegisterModel?> register(Map<String, dynamic> data);
  Future<CreateChildrenModel?> createChildren(Map<String, dynamic> data);
  Future<CategoryModel?> fetchCategory();
  Future<SubCategoryModel?> fetchSubCategory(int catId);

  Future<GetAllChildrenModel?> getAllChildren();

  Future<SampleTextModel?> getSampleText();

  Future<SaveAudioModel?> saveaudio(FormData data);



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
  Future<SaveAudioModel?> saveaudio(FormData data) async {
    try {
      final res = await ApiClient.post(
        "${APIEndpointUrls.saveAudio}",
        data: data,
        options: Options(
          contentType: "multipart/form-data",
        ),
      );

      AppLogger.log('saveAudio : ${res.data}');
      return SaveAudioModel.fromJson(res.data);

    } catch (e) {
      print('saveAudio error : $e');
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
  @override
  Future<SampleTextModel?> getSampleText() async {
    try {
      final res = await ApiClient.get(
        "${APIEndpointUrls.getSampleText}",

      );
      AppLogger.log('Register : ${res.data}');
      return SampleTextModel.fromJson(res.data);
    } catch (e) {
      // AppLogger.error('login : $e');
      return null;
    }
  }

  @override
  Future<CategoryModel?> fetchCategory() async {
    try {
      final res = await ApiClient.get("${APIEndpointUrls.fetchCategory}");
      AppLogger.log('fetch Category : ${res.data}');
      return CategoryModel.fromJson(res.data);
    } catch (e) {
      AppLogger.error('fetch Category : $e');
      return null;
    }
  }
  @override
  Future<SubCategoryModel?> fetchSubCategory(int catId) async {
    try {
      final res = await ApiClient.get("${APIEndpointUrls.fetchSubCategory}/${catId}");
      AppLogger.log('fetch Sub Category : ${res.data}');
      return SubCategoryModel.fromJson(res.data);
    } catch (e) {
      AppLogger.error('fetch Sub Category : $e');
      return null;
    }
  }
}
