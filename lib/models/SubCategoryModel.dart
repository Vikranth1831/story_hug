class SubCategoryModel {
  String? message;
  List<SubCategories>? subCategories;

  SubCategoryModel({this.message, this.subCategories});

  SubCategoryModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['SubCategories'] != null) {
      subCategories = <SubCategories>[];
      json['SubCategories'].forEach((v) {
        subCategories!.add(new SubCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.subCategories != null) {
      data['SubCategories'] =
          this.subCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCategories {
  int? id;
  int? categoryId;
  String? image;
  String? subcategoryName;
  String? createdAt;
  String? updatedAt;

  SubCategories(
      {this.id,
        this.categoryId,
        this.image,
        this.subcategoryName,
        this.createdAt,
        this.updatedAt});

  SubCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    image = json['image'];
    subcategoryName = json['subcategory_name'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['image'] = this.image;
    data['subcategory_name'] = this.subcategoryName;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
