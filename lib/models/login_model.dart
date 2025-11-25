class LoginModel {
  String? message;
  String? accessToken;
  String? refreshToken;
  bool? success;

  LoginModel({this.message, this.accessToken, this.refreshToken, this.success});

  LoginModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['accessToken'] = this.accessToken;
    data['refreshToken'] = this.refreshToken;
    data['success'] = this.success;
    return data;
  }
}