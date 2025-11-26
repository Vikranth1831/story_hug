class SubSubOfCategoryModel {
  String? message;
  List<SubofSubCategories>? subofSubCategories;
  bool? success;

  SubSubOfCategoryModel({this.message, this.subofSubCategories, this.success});

  SubSubOfCategoryModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['subofSubCategories'] != null) {
      subofSubCategories = <SubofSubCategories>[];
      json['subofSubCategories'].forEach((v) {
        subofSubCategories!.add(new SubofSubCategories.fromJson(v));
      });
    }
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.subofSubCategories != null) {
      data['subofSubCategories'] =
          this.subofSubCategories!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    return data;
  }
}

class SubofSubCategories {
  int? id;
  int? subcategoryId;
  String? image;
  String? subofSubcategoryName;
  String? createdAt;
  String? updatedAt;

  SubofSubCategories(
      {this.id,
        this.subcategoryId,
        this.image,
        this.subofSubcategoryName,
        this.createdAt,
        this.updatedAt});

  SubofSubCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subcategoryId = json['subcategory_id'];
    image = json['image'];
    subofSubcategoryName = json['subof_subcategory_name'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['subcategory_id'] = this.subcategoryId;
    data['image'] = this.image;
    data['subof_subcategory_name'] = this.subofSubcategoryName;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
