class FaveratesModel {
  String? message;
  List<Favourate>? favourate;
  bool? success;

  FaveratesModel({this.message, this.favourate, this.success});

  FaveratesModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['Favourate'] != null) {
      favourate = <Favourate>[];
      json['Favourate'].forEach((v) {
        favourate!.add(new Favourate.fromJson(v));
      });
    }
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.favourate != null) {
      data['Favourate'] = this.favourate!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    return data;
  }
}

class Favourate {
  int? id;
  int? storyId;
  int? parentId;
  int? childId;
  String? createdAt;
  String? updatedAt;
  Story? story;
  bool? isFavourated;

  Favourate(
      {this.id,
        this.storyId,
        this.parentId,
        this.childId,
        this.createdAt,
        this.updatedAt,
        this.story,
        this.isFavourated});

  Favourate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storyId = json['story_id'];
    parentId = json['parent_id'];
    childId = json['child_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    story = json['story'] != null ? new Story.fromJson(json['story']) : null;
    isFavourated = json['is_favourated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['story_id'] = this.storyId;
    data['parent_id'] = this.parentId;
    data['child_id'] = this.childId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.story != null) {
      data['story'] = this.story!.toJson();
    }
    data['is_favourated'] = this.isFavourated;
    return data;
  }
}

class Story {
  int? id;
  String? title;
  String? content;
  String? description;
  String? image;
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
