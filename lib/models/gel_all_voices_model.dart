class GetAllVoiceModel {
  bool? success;
  List<Voices>? voices;
  DefaultVoice? defaultVoice;

  GetAllVoiceModel({this.success, this.voices, this.defaultVoice});

  GetAllVoiceModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['voices'] != null) {
      voices = <Voices>[];
      json['voices'].forEach((v) {
        voices!.add(new Voices.fromJson(v));
      });
    }
    defaultVoice = json['defaultVoice'] != null
        ? new DefaultVoice.fromJson(json['defaultVoice'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.voices != null) {
      data['voices'] = this.voices!.map((v) => v.toJson()).toList();
    }
    if (this.defaultVoice != null) {
      data['defaultVoice'] = this.defaultVoice!.toJson();
    }
    return data;
  }
}

class Voices {
  int? id;
  int? parentId;
  String? voiceId;
  String? voiceName;
  String? description;
  bool? isDefault;
  String? sampleFilePath;
  String? createdAt;
  String? updatedAt;

  Voices(
      {this.id,
        this.parentId,
        this.voiceId,
        this.voiceName,
        this.description,
        this.isDefault,
        this.sampleFilePath,
        this.createdAt,
        this.updatedAt});

  Voices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    voiceId = json['voice_id'];
    voiceName = json['voiceName'];
    description = json['description'];
    isDefault = json['isDefault'];
    sampleFilePath = json['sampleFilePath'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['voice_id'] = this.voiceId;
    data['voiceName'] = this.voiceName;
    data['description'] = this.description;
    data['isDefault'] = this.isDefault;
    data['sampleFilePath'] = this.sampleFilePath;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class DefaultVoice {
  int? id;
  int? parentId;
  Null? voiceId;
  String? voiceName;
  String? description;
  bool? isDefault;
  String? sampleFilePath;
  String? createdAt;
  String? updatedAt;

  DefaultVoice(
      {this.id,
        this.parentId,
        this.voiceId,
        this.voiceName,
        this.description,
        this.isDefault,
        this.sampleFilePath,
        this.createdAt,
        this.updatedAt});

  DefaultVoice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    voiceId = json['voice_id'];
    voiceName = json['voiceName'];
    description = json['description'];
    isDefault = json['isDefault'];
    sampleFilePath = json['sampleFilePath'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['voice_id'] = this.voiceId;
    data['voiceName'] = this.voiceName;
    data['description'] = this.description;
    data['isDefault'] = this.isDefault;
    data['sampleFilePath'] = this.sampleFilePath;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
