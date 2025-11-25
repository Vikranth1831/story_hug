class RegisterModel {
  String? message;
  User? user;
  bool? success;

  RegisterModel({this.message, this.user, this.success});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['success'] = this.success;
    return data;
  }
}

class User {
  bool? isOtpVerified;
  String? userType;
  int? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? password;
  Null? image;
  String? updatedAt;
  String? createdAt;

  User(
      {this.isOtpVerified,
        this.userType,
        this.id,
        this.name,
        this.email,
        this.phoneNumber,
        this.password,
        this.image,
        this.updatedAt,
        this.createdAt});

  User.fromJson(Map<String, dynamic> json) {
    isOtpVerified = json['is_otp_verified'];
    userType = json['user_type'];
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    password = json['password'];
    image = json['image'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_otp_verified'] = this.isOtpVerified;
    data['user_type'] = this.userType;
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['password'] = this.password;
    data['image'] = this.image;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    return data;
  }
}