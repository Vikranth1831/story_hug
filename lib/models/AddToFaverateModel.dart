class AddToFaverateModel {
  bool? success;
  String? message;
  bool? isFavourated;

  AddToFaverateModel({this.success, this.message, this.isFavourated});

  AddToFaverateModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    isFavourated = json['is_favourated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['is_favourated'] = this.isFavourated;
    return data;
  }
}
