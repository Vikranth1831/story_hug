class SelectChildModel {
  String? message;
  int? selectedChildId;
  bool? success;

  SelectChildModel({this.message, this.selectedChildId, this.success});

  SelectChildModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    selectedChildId = json['selected_child_id'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['selected_child_id'] = this.selectedChildId;
    data['success'] = this.success;
    return data;
  }
}