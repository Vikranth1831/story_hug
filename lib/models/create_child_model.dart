class CreateChildrenModel {
  String? message;
  Child? child;
  bool? success;

  CreateChildrenModel({this.message, this.child, this.success});

  CreateChildrenModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    child = json['child'] != null ? new Child.fromJson(json['child']) : null;
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.child != null) {
      data['child'] = this.child!.toJson();
    }
    data['success'] = this.success;
    return data;
  }
}

class Child {
  int? id;
  String? name;
  String? gender;
  String? age;
  Null? image;
  int? parentId;
  String? updatedAt;
  String? createdAt;

  Child(
      {this.id,
        this.name,
        this.gender,
        this.age,
        this.image,
        this.parentId,
        this.updatedAt,
        this.createdAt});

  Child.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    gender = json['gender'];
    age = json['age'];
    image = json['image'];
    parentId = json['parent_id'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['age'] = this.age;
    data['image'] = this.image;
    data['parent_id'] = this.parentId;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    return data;
  }
}