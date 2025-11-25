import 'package:story_hug/core/api_config.dart';

class APIEndpointUrls {
  static const String ApiUrl = '${ApiConfig.baseUrl}';
  static const String AuthUrl = '${ApiUrl}parentauth/';


  /// Auth URls
  static const String login = '${AuthUrl}login';
  static const String register = '${AuthUrl}register';
  static const String children='${ApiUrl}children';
  static const String createChildren='${children}/createchild';
  static const String getAllChildren='${children}/getallchildrensofaparent';

}
