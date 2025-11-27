class SubScriptionModel {
  String? message;
  List<SubscriptionPlans>? subscriptionPlans;

  SubScriptionModel({this.message, this.subscriptionPlans});

  SubScriptionModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['subscriptionPlans'] != null) {
      subscriptionPlans = <SubscriptionPlans>[];
      json['subscriptionPlans'].forEach((v) {
        subscriptionPlans!.add(new SubscriptionPlans.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.subscriptionPlans != null) {
      data['subscriptionPlans'] =
          this.subscriptionPlans!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubscriptionPlans {
  int? id;
  String? planType;
  int? planPrice;
  int? planExpiry;
  String? features;
  String? createdAt;
  String? updatedAt;

  SubscriptionPlans(
      {this.id,
        this.planType,
        this.planPrice,
        this.planExpiry,
        this.features,
        this.createdAt,
        this.updatedAt});

  SubscriptionPlans.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    planType = json['plan_type'];
    planPrice = json['plan_price'];
    planExpiry = json['plan_expiry'];
    features = json['features'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['plan_type'] = this.planType;
    data['plan_price'] = this.planPrice;
    data['plan_expiry'] = this.planExpiry;
    data['features'] = this.features;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
