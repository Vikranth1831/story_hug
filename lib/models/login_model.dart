class LoginModel {
  String? message;
  String? token;
  bool? success;

  LoginModel({this.message, this.token, this.success});

  LoginModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['token'] = this.token;
    data['success'] = this.success;
    return data;
  }
}
