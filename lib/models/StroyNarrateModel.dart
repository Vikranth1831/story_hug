class StroyNarrateModel {
  bool? success;
  String? message;
  Data? data;

  StroyNarrateModel({this.success, this.message, this.data});

  StroyNarrateModel.fromJson(Map<String, dynamic> json) {
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
  String? audioUrl;
  String? audioFileName;
  String? storyId;
  dynamic voiceId;
  int? textLength;
  String? source;
  String? generatedAt;

  Data(
      {this.audioUrl,
        this.audioFileName,
        this.storyId,
        this.voiceId,
        this.textLength,
        this.source,
        this.generatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    audioUrl = json['audioUrl'];
    audioFileName = json['audioFileName'];
    storyId = json['story_id'];
    voiceId = json['voice_id'];
    textLength = json['textLength'];
    source = json['source'];
    generatedAt = json['generatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['audioUrl'] = this.audioUrl;
    data['audioFileName'] = this.audioFileName;
    data['story_id'] = this.storyId;
    data['voice_id'] = this.voiceId;
    data['textLength'] = this.textLength;
    data['source'] = this.source;
    data['generatedAt'] = this.generatedAt;
    return data;
  }
}
