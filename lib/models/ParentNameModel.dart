class GetParentDetailsModel {
  String? message;
  bool? success;
  Data? data;

  GetParentDetailsModel({this.message, this.success, this.data});

  GetParentDetailsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? password;
  Null? image;
  Null? otp;
  Null? otpExpiry;
  bool? isOtpVerified;
  Null? subscriptionStart;
  Null? subscriptionEnd;
  Null? activeSubscriptionId;
  Null? activeSubscriptionPlanType;
  String? userType;
  String? refreshToken;
  int? selectedChildId;
  String? fcmToken;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.name,
        this.email,
        this.phoneNumber,
        this.password,
        this.image,
        this.otp,
        this.otpExpiry,
        this.isOtpVerified,
        this.subscriptionStart,
        this.subscriptionEnd,
        this.activeSubscriptionId,
        this.activeSubscriptionPlanType,
        this.userType,
        this.refreshToken,
        this.selectedChildId,
        this.fcmToken,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    password = json['password'];
    image = json['image'];
    otp = json['otp'];
    otpExpiry = json['otp_expiry'];
    isOtpVerified = json['is_otp_verified'];
    subscriptionStart = json['subscription_start'];
    subscriptionEnd = json['subscription_end'];
    activeSubscriptionId = json['active_subscription_id'];
    activeSubscriptionPlanType = json['active_subscription_plan_type'];
    userType = json['user_type'];
    refreshToken = json['refresh_token'];
    selectedChildId = json['selected_child_id'];
    fcmToken = json['fcm_token'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['password'] = this.password;
    data['image'] = this.image;
    data['otp'] = this.otp;
    data['otp_expiry'] = this.otpExpiry;
    data['is_otp_verified'] = this.isOtpVerified;
    data['subscription_start'] = this.subscriptionStart;
    data['subscription_end'] = this.subscriptionEnd;
    data['active_subscription_id'] = this.activeSubscriptionId;
    data['active_subscription_plan_type'] = this.activeSubscriptionPlanType;
    data['user_type'] = this.userType;
    data['refresh_token'] = this.refreshToken;
    data['selected_child_id'] = this.selectedChildId;
    data['fcm_token'] = this.fcmToken;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
