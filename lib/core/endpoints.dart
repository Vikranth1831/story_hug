import 'package:story_hug/core/api_config.dart';

class APIEndpointUrls {
  static const String ApiUrl = '${ApiConfig.baseUrl}';
  static const String AuthUrl = '${ApiUrl}/parentauth/';

  /// Auth URls
  static const String login = '${AuthUrl}login';
  static const String register = '${AuthUrl}/register';

}
