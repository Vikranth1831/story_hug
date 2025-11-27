import 'package:dio/dio.dart';
import 'package:story_hug/models/SaveAudioModel.dart';
import 'package:story_hug/models/SubScriptionModel.dart';
import 'package:story_hug/models/create_child_model.dart';
import 'package:story_hug/models/get_all_children_model.dart';
import 'package:story_hug/models/otp_sent_model.dart';
import 'package:story_hug/models/otp_verified_model.dart';
import 'package:story_hug/models/register_model.dart';
import 'package:story_hug/models/sample_text_model.dart';
import 'package:story_hug/repositories/get_all_children_repository.dart';
import '../core/endpoints.dart';
import '../models/CategoryModel.dart';
import '../models/CreatePaymentModel.dart';
import '../models/FaveratesModel.dart';
import '../models/SubCategoryModel.dart';
import '../models/SubSubOfCategoryModel.dart';
import '../models/VerifyPaymentModel.dart';
import '../models/login_model.dart';
import '../models/password_update_model.dart';
import '../models/select_child_model.dart';
import '../pages/recording_voice/save_voice.dart';
import '../services/ApiClient.dart';
import '../utils/AppLogger.dart';

abstract class RemoteDataSource {
  Future<LoginModel?> login(Map<String, dynamic> data);
  Future<RegisterModel?> register(Map<String, dynamic> data);
  Future<CreateChildrenModel?> createChildren(Map<String, dynamic> data);
  Future<CategoryModel?> fetchCategory();
  Future<SubCategoryModel?> fetchSubCategory(String catId);
  Future<GetAllChildrenModel?> getAllChildren();
  Future<OTPSentModel?> sendotp();
  Future<SubSubOfCategoryModel?> fetchSubSubCategory(String catId);
  Future<SubScriptionModel?> fetchSubscriptionPlans();
  Future<FaveratesModel?> fetchFaverateList(String childId);
  Future<CreatePaymentModel?> createPayment(Map<String, dynamic> data);
  Future<VerifyPaymentModel?> verifyPayment(Map<String, dynamic> data);
  Future<OTPVerifiedModel?> verifyOtp(Map<String, dynamic> data);
  Future<SelectChildModel?> selectchild(Map<String, dynamic> data);
  Future<PasswordUpdateModel?> updatepassword(Map<String, dynamic> data);






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
  Future<OTPVerifiedModel?> verifyOtp(Map<String, dynamic> data) async {
    try {
      final res = await ApiClient.post("${APIEndpointUrls.verifyotp}", data: data);
      AppLogger.log('verifyOtp : ${res.data}');
      return OTPVerifiedModel.fromJson(res.data);
    } catch (e) {
      print('verifyOtp : $e');
      return null;
    }
  }

  @override
  Future<PasswordUpdateModel?> updatepassword(Map<String, dynamic> data) async {
    try {
      final res = await ApiClient.put("${APIEndpointUrls.updatepassword}", data: data);
      AppLogger.log('Update Password : ${res.data}');
      return PasswordUpdateModel.fromJson(res.data);
    } catch (e) {
      print('Update Password : $e');
      return null;
    }
  }

  @override
  Future<SelectChildModel?> selectchild(Map<String, dynamic> data) async {
    try {
      final res = await ApiClient.post("${APIEndpointUrls.selectchild}", data: data);
      AppLogger.log('Select Child : ${res.data}');
      return SelectChildModel.fromJson(res.data);
    } catch (e) {
      print('Select Child : $e');
      return null;
    }
  }



  @override
  Future<OTPSentModel?> sendotp() async {
    try {
      final res = await ApiClient.put("${APIEndpointUrls.sendotp}");
      AppLogger.log('Send otp  : ${res.data}');
      return OTPSentModel.fromJson(res.data);
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
  Future<CreatePaymentModel?> createPayment(Map<String, dynamic> data) async {
    try {
      Response response = await ApiClient.post(
        "${APIEndpointUrls.createPayment}",
        data: data,
      );
      AppLogger.log('create Payment :${response.data}');
      return CreatePaymentModel.fromJson(response.data);
    } catch (e) {
      AppLogger.log('create Payment :: $e');
      return null;
    }
  }
  @override
  Future<VerifyPaymentModel?> verifyPayment(Map<String, dynamic> data) async {
    try {
      Response res = await ApiClient.post(
        "${APIEndpointUrls.verifyPayment}",
        data: data,
      );
      AppLogger.log('verify Payment ::${res.data}');
      return VerifyPaymentModel.fromJson(res.data);
    } catch (e) {
      AppLogger.error('verify Payment  ::${e}');

      return null;
    }
  }

  @override
  Future<GetAllChildrenModel?> getAllChildren() async {
    try {
      final res = await ApiClient.get("${APIEndpointUrls.getAllChildren}");
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
  Future<SubCategoryModel?> fetchSubCategory(String catId) async {
    try {
      final res = await ApiClient.get(
        "${APIEndpointUrls.fetchSubCategory}${catId}",
      );
      AppLogger.log('fetch Sub Category : ${res.data}');
      return SubCategoryModel.fromJson(res.data);
    } catch (e) {
      AppLogger.error('fetch Sub Category : $e');
      return null;
    }
  }

  @override
  Future<SubSubOfCategoryModel?> fetchSubSubCategory(String catId) async {
    try {
      final res = await ApiClient.get(
        "${APIEndpointUrls.fetchSubSubCategory}${catId}",
      );
      AppLogger.log('fetch Sub Sub Category : ${res.data}');
      return SubSubOfCategoryModel.fromJson(res.data);
    } catch (e) {
      AppLogger.error('fetch Sub Sub Category : $e');
      return null;
    }
  }

  @override
  Future<SubScriptionModel?> fetchSubscriptionPlans() async {
    try {
      final res = await ApiClient.get("${APIEndpointUrls.subscriptionPlans}");
      AppLogger.log('fetch Sub Sub Category : ${res.data}');
      return SubScriptionModel.fromJson(res.data);
    } catch (e) {
      AppLogger.error('fetch Sub Sub Category : $e');
      return null;
    }
  }

  @override
  Future<FaveratesModel?> fetchFaverateList(String childId) async {
    try {
      final res = await ApiClient.get(
        "${APIEndpointUrls.faverates}?child_id=${childId}",
      );
      AppLogger.log('fetch Faverates List : ${res.data}');
      return FaveratesModel.fromJson(res.data);
    } catch (e) {
      AppLogger.error('fetch Faverates List: $e');
      return null;
    }
  }
}
