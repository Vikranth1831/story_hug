class DefaultVoiceModel {
  bool? success;
  String? message;
  Data? data;

  DefaultVoiceModel({this.success, this.message, this.data});

  DefaultVoiceModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  int? parentId;
  Null? voiceId;
  String? voiceName;
  bool? isDefault;

  Data({this.id, this.parentId, this.voiceId, this.voiceName, this.isDefault});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    voiceId = json['voice_id'];
    voiceName = json['voiceName'];
    isDefault = json['isDefault'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['voice_id'] = this.voiceId;
    data['voiceName'] = this.voiceName;
    data['isDefault'] = this.isDefault;
    return data;
  }
}
