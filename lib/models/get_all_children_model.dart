class GetAllChildrenModel {
  String? message;
  List<Children>? children;
  bool? success;

  GetAllChildrenModel({this.message, this.children, this.success});

  GetAllChildrenModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['children'] != null) {
      children = <Children>[];
      json['children'].forEach((v) {
        children!.add(new Children.fromJson(v));
      });
    }
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.children != null) {
      data['children'] = this.children!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    return data;
  }
}

class Children {
  int? id;
  String? name;
  Null? image;
  int? age;
  String? gender;
  int? parentId;
  String? createdAt;
  String? updatedAt;

  Children(
      {this.id,
        this.name,
        this.image,
        this.age,
        this.gender,
        this.parentId,
        this.createdAt,
        this.updatedAt});

  Children.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    age = json['age'];
    gender = json['gender'];
    parentId = json['parent_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['parent_id'] = this.parentId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}