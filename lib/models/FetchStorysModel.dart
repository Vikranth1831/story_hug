class FetchStorysModel {
  String? message;
  List<Stroy>? stroy;
  bool? success;

  FetchStorysModel({this.message, this.stroy, this.success});

  FetchStorysModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['stroy'] != null) {
      stroy = <Stroy>[];
      json['stroy'].forEach((v) {
        stroy!.add(new Stroy.fromJson(v));
      });
    }
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.stroy != null) {
      data['stroy'] = this.stroy!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    return data;
  }
}

class Stroy {
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
  bool? isFavorate;
  String? createdAt;
  String? updatedAt;

  Stroy(
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
        this.isFavorate,
        this.createdAt,
        this.updatedAt});

  Stroy.fromJson(Map<String, dynamic> json) {
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
    isFavorate = json['is_favorate'];
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
    data['is_favorate'] = this.isFavorate;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
