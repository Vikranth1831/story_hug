import 'package:story_hug/core/api_config.dart';

class APIEndpointUrls {
  static const String ApiUrl = '${ApiConfig.baseUrl}';
  static const String AuthUrl = '${ApiUrl}parentauth/';
  static const String story = '${ApiUrl}story/';
  static const String children='${ApiUrl}children';

  /// Auth URls
  static const String login = '${AuthUrl}login';
  static const String register = '${AuthUrl}register';

  static const String fetchCategory='${story}fetchcategories';
  static const String fetchSubCategory='${story}fetchsubcategoriesbycategoryid/';
  static const String fetchSubSubCategory='${story}fetchsubofsubcategoriesbysubcategoryid/';
  static const String getAllChildren='${children}/getallchildrensofaparent';
  static const String createChildren='${children}/createchild';
  static const String sendotp='${AuthUrl}changepassword';
  static const String verifyotp='${AuthUrl}verifyotp';
  static const String subscriptionPlans='${ApiUrl}subscriptions/fetchallsubscriptionplans';
  static const String faverates='${ApiUrl}favourate/fetchfavourateofchild';
  static const String addfaverates='${ApiUrl}favourate/addtofavourate';
  static const String deletefaverates='${ApiUrl}favourate/deletefavourate';
  static const String createPayment='${ApiUrl}payment/createpayment';
  static const String verifyPayment='${ApiUrl}payment/verifypayment';
  static const String updatepassword='${AuthUrl}updatepassword';
  static const String selectchild='${children}/selectchild';


}
