class CreatePaymentModel {
  String? message;
  bool? success;
  Order? order;
  PaymentRecord? paymentRecord;

  CreatePaymentModel({
    this.message,
    this.success,
    this.order,
    this.paymentRecord,
  });

  CreatePaymentModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['success'];
    order = json['order'] != null ? Order.fromJson(json['order']) : null;
    paymentRecord = json['paymentRecord'] != null
        ? PaymentRecord.fromJson(json['paymentRecord'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['message'] = message;
    data['success'] = success;
    if (order != null) data['order'] = order!.toJson();
    if (paymentRecord != null) {
      data['paymentRecord'] = paymentRecord!.toJson();
    }
    return data;
  }
}

class Order {
  int? amount;
  int? amountDue;
  int? amountPaid;
  int? attempts;
  int? createdAt;
  String? currency;
  String? entity;
  String? id;
  List<dynamic>? notes;      // FIXED
  String? offerId;
  String? receipt;
  String? status;

  Order({
    this.amount,
    this.amountDue,
    this.amountPaid,
    this.attempts,
    this.createdAt,
    this.currency,
    this.entity,
    this.id,
    this.notes,
    this.offerId,
    this.receipt,
    this.status,
  });

  Order.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    amountDue = json['amount_due'];
    amountPaid = json['amount_paid'];
    attempts = json['attempts'];
    createdAt = json['created_at'];
    currency = json['currency'];
    entity = json['entity'];
    id = json['id'];
    notes = json['notes'] != null ? List<dynamic>.from(json['notes']) : [];
    offerId = json['offer_id'];
    receipt = json['receipt'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['amount'] = amount;
    data['amount_due'] = amountDue;
    data['amount_paid'] = amountPaid;
    data['attempts'] = attempts;
    data['created_at'] = createdAt;
    data['currency'] = currency;
    data['entity'] = entity;
    data['id'] = id;
    if (notes != null) data['notes'] = notes;
    data['offer_id'] = offerId;
    data['receipt'] = receipt;
    data['status'] = status;
    return data;
  }
}

class PaymentRecord {
  int? id;
  String? razorpayOrderId;
  int? amount;
  String? currency;
  String? status;
  int? parentId;
  int? subscriptionId;
  String? updatedAt;
  String? createdAt;

  PaymentRecord({
    this.id,
    this.razorpayOrderId,
    this.amount,
    this.currency,
    this.status,
    this.parentId,
    this.subscriptionId,
    this.updatedAt,
    this.createdAt,
  });

  PaymentRecord.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    razorpayOrderId = json['razorpay_order_id'];
    amount = json['amount'];
    currency = json['currency'];
    status = json['status'];
    parentId = json['parent_id'];
    subscriptionId = json['subscription_id'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['razorpay_order_id'] = razorpayOrderId;
    data['amount'] = amount;
    data['currency'] = currency;
    data['status'] = status;
    data['parent_id'] = parentId;
    data['subscription_id'] = subscriptionId;
    data['updatedAt'] = updatedAt;
    data['createdAt'] = createdAt;
    return data;
  }
}
