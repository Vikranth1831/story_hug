class SaveAudioModel {
  bool? success;
  String? message;
  Data? data;

  SaveAudioModel({this.success, this.message, this.data});

  SaveAudioModel.fromJson(Map<String, dynamic> json) {
    success = json['success']?? false ;
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
  String? voiceName;
  String? sampleFilePath;

  Data({this.id, this.parentId, this.voiceName, this.sampleFilePath});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    voiceName = json['voice_name'];
    sampleFilePath = json['sample_file_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['voice_name'] = this.voiceName;
    data['sample_file_path'] = this.sampleFilePath;
    return data;
  }
}
