import 'package:story_hug/core/api_config.dart';

class APIEndpointUrls {
  static const String ApiUrl = '${ApiConfig.baseUrl}';
  static const String AuthUrl = '${ApiUrl}parentauth/';
  static const String story = '${ApiUrl}story/';


  /// Auth URls
  static const String login = '${AuthUrl}login';
  static const String register = '${AuthUrl}register';
  static const String createChildren='${ApiUrl}children/createchild';
  static const String fetchCategory='${story}fetchcategories';
  static const String fetchSubCategory='${story}fetchsubcategoriesbycategoryid/';
  static const String children='${ApiUrl}children';
  static const String createChildren='${children}/createchild';
  static const String getAllChildren='${children}/getallchildrensofaparent';

}
