class LoginModel {
  bool? status;
  String? message;
  Data? data;

  LoginModel({this.status, this.message, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] as bool?;
    message = json['message']?.toString();
    data = json['data'] != null ? Data.fromJson(json['data'] as Map<String, dynamic>) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
class Data {
  String? accessToken;
  int? accessTokenExpiry;
  String? refreshToken;
  int? refreshTokenExpiry;
  String? tokenType;
  User? user;

  Data({
    this.accessToken,
    this.accessTokenExpiry,
    this.refreshToken,
    this.refreshTokenExpiry,
    this.tokenType,
    this.user,
  });

  Data.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token']?.toString();

    // ---- FIX: always parse expiry into int ----
    final accExp = json['access_token_expiry'];
    accessTokenExpiry =
    accExp is int ? accExp : int.tryParse(accExp.toString());

    refreshToken = json['refresh_token']?.toString();

    final refExp = json['refresh_token_expiry'];
    refreshTokenExpiry =
    refExp is int ? refExp : int.tryParse(refExp.toString());

    tokenType = json['token_type']?.toString();

    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['access_token_expiry'] = accessTokenExpiry;
    data['refresh_token'] = refreshToken;
    data['refresh_token_expiry'] = refreshTokenExpiry;
    data['token_type'] = tokenType;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}


class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? refreshToken;
  String? role;
  String? profileImage;
  String? address;
  String? city;
  String? state;
  String? fcmToken;
  String? deviceType;
  int? isActive;
  String? emailVerifiedAt;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  String? profileImageUrl;
  int? serviceMan;

  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.refreshToken,
    this.role,
    this.profileImage,
    this.address,
    this.city,
    this.state,
    this.fcmToken,
    this.deviceType,
    this.isActive,
    this.emailVerifiedAt,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.profileImageUrl,
    this.serviceMan,
  });

  User.fromJson(Map<String, dynamic> json) {
    // id might be int or string
    final rawId = json['id'];
    if (rawId is int) {
      id = rawId;
    } else if (rawId is String) {
      id = int.tryParse(rawId);
    }

    name = json['name']?.toString();
    email = json['email']?.toString();

    // phone may come as int or string
    phone = json['phone']?.toString();

    refreshToken = json['refresh_token']?.toString();
    role = json['role']?.toString();

    // profile_image might be null or string or int (rare) — convert to string if present
    profileImage = json['profile_image'] != null ? json['profile_image']?.toString() : null;

    address = json['address']?.toString();

    // city could be int (0) or string — convert to string to avoid type errors
    city = json['city'] != null ? json['city'].toString() : null;

    state = json['state']?.toString();
    fcmToken = json['fcm_token']?.toString();
    deviceType = json['device_type']?.toString();

    // is_active expected as int
    final rawIsActive = json['is_active'];
    if (rawIsActive is int) {
      isActive = rawIsActive;
    } else if (rawIsActive is String) {
      isActive = int.tryParse(rawIsActive);
    }

    emailVerifiedAt = json['email_verified_at']?.toString();
    deletedAt = json['deleted_at']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
    profileImageUrl = json['profile_image_url']?.toString();

    final rawServiceMan = json['service_man'];
    if (rawServiceMan is int) {
      serviceMan = rawServiceMan;
    } else if (rawServiceMan is String) {
      serviceMan = int.tryParse(rawServiceMan);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['refresh_token'] = refreshToken;
    data['role'] = role;
    data['profile_image'] = profileImage;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['fcm_token'] = fcmToken;
    data['device_type'] = deviceType;
    data['is_active'] = isActive;
    data['email_verified_at'] = emailVerifiedAt;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['profile_image_url'] = profileImageUrl;
    data['service_man'] = serviceMan;
    return data;
  }
}
