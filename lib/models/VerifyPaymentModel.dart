class VerifyPaymentModel {
  String? message;
  bool? success;
  Payment? payment;
  Parent? parent;

  VerifyPaymentModel({this.message, this.success, this.payment, this.parent});

  VerifyPaymentModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['success'];
    payment =
    json['payment'] != null ? new Payment.fromJson(json['payment']) : null;
    parent =
    json['parent'] != null ? new Parent.fromJson(json['parent']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['success'] = this.success;
    if (this.payment != null) {
      data['payment'] = this.payment!.toJson();
    }
    if (this.parent != null) {
      data['parent'] = this.parent!.toJson();
    }
    return data;
  }
}

class Payment {
  int? id;
  String? razorpayOrderId;
  String? razorpayPaymentId;
  String? razorpaySignature;
  int? amount;
  String? currency;
  String? status;
  int? parentId;
  int? subscriptionId;
  String? createdAt;
  String? updatedAt;

  Payment(
      {this.id,
        this.razorpayOrderId,
        this.razorpayPaymentId,
        this.razorpaySignature,
        this.amount,
        this.currency,
        this.status,
        this.parentId,
        this.subscriptionId,
        this.createdAt,
        this.updatedAt});

  Payment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    razorpayOrderId = json['razorpay_order_id'];
    razorpayPaymentId = json['razorpay_payment_id'];
    razorpaySignature = json['razorpay_signature'];
    amount = json['amount'];
    currency = json['currency'];
    status = json['status'];
    parentId = json['parent_id'];
    subscriptionId = json['subscription_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['razorpay_order_id'] = this.razorpayOrderId;
    data['razorpay_payment_id'] = this.razorpayPaymentId;
    data['razorpay_signature'] = this.razorpaySignature;
    data['amount'] = this.amount;
    data['currency'] = this.currency;
    data['status'] = this.status;
    data['parent_id'] = this.parentId;
    data['subscription_id'] = this.subscriptionId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Parent {
  int? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? password;
  Null? image;
  Null? otp;
  Null? otpExpiry;
  bool? isOtpVerified;
  String? subscriptionStart;
  String? subscriptionEnd;
  int? activeSubscriptionId;
  String? activeSubscriptionPlanType;
  String? userType;
  String? refreshToken;
  Null? selectedChildId;
  String? fcmToken;
  String? createdAt;
  String? updatedAt;

  Parent(
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

  Parent.fromJson(Map<String, dynamic> json) {
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
