class SampleTextModel {
  bool? success;
  String? text;
  String? estimatedDuration;

  SampleTextModel({this.success, this.text, this.estimatedDuration});

  SampleTextModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    text = json['text'];
    estimatedDuration = json['estimatedDuration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['text'] = this.text;
    data['estimatedDuration'] = this.estimatedDuration;
    return data;
  }
}
