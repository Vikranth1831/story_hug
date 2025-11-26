class LoginModel {
  String? message;
  String? accessToken;
  String? refreshToken;
  int? accessTokenExpiry;
  int? refreshTokenExpiry;
  bool? success;

  LoginModel(
      {this.message,
        this.accessToken,
        this.refreshToken,
        this.accessTokenExpiry,
        this.refreshTokenExpiry,
        this.success});

  LoginModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    accessTokenExpiry = json['access_token_expiry'];
    refreshTokenExpiry = json['refresh_token_expiry'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['accessToken'] = this.accessToken;
    data['refreshToken'] = this.refreshToken;
    data['access_token_expiry'] = this.accessTokenExpiry;
    data['refresh_token_expiry'] = this.refreshTokenExpiry;
    data['success'] = this.success;
    return data;
  }
}
