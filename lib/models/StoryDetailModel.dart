class StoryDetailModel {
  String? message;
  Story? story;
  bool? success;

  StoryDetailModel({this.message, this.story, this.success});

  StoryDetailModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    story = json['story'] != null ? new Story.fromJson(json['story']) : null;
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.story != null) {
      data['story'] = this.story!.toJson();
    }
    data['success'] = this.success;
    return data;
  }
}

class Story {
  int? id;
  String? title;
  String? content;
  String? description;
  Null? image;
  int? categoryId;
  int? subcategoryId;
  int? subofSubcategoryId;
  String? suitableFor;
  bool? status;
  String? language;
  String? createdAt;
  String? updatedAt;

  Story(
      {this.id,
        this.title,
        this.content,
        this.description,
        this.image,
        this.categoryId,
        this.subcategoryId,
        this.subofSubcategoryId,
        this.suitableFor,
        this.status,
        this.language,
        this.createdAt,
        this.updatedAt});

  Story.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    description = json['description'];
    image = json['image'];
    categoryId = json['category_id'];
    subcategoryId = json['subcategory_id'];
    subofSubcategoryId = json['subof_subcategory_id'];
    suitableFor = json['suitable_for'];
    status = json['status'];
    language = json['language'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['description'] = this.description;
    data['image'] = this.image;
    data['category_id'] = this.categoryId;
    data['subcategory_id'] = this.subcategoryId;
    data['subof_subcategory_id'] = this.subofSubcategoryId;
    data['suitable_for'] = this.suitableFor;
    data['status'] = this.status;
    data['language'] = this.language;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
