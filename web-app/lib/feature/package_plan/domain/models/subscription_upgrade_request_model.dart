

import 'package:class_compass/helper/price_converter.dart';

class SubscriptionUpgradeRequestItem {
  int? id;
  String? instituteId;
  String? planId;
  String? extraDays;
  String? amountPaid;
  String? paymentMethod;
  String? notes;
  String? status;
  String? approvedBy;
  String? approvedAt;
  String? createdAt;
  String? updatedAt;
  Institute? institute;
  Plan? plan;

  SubscriptionUpgradeRequestItem(
      {this.id,
        this.instituteId,
        this.planId,
        this.extraDays,
        this.amountPaid,
        this.paymentMethod,
        this.notes,
        this.status,
        this.approvedBy,
        this.approvedAt,
        this.createdAt,
        this.updatedAt,
        this.institute,
        this.plan});

  SubscriptionUpgradeRequestItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instituteId = json['institute_id'];
    planId = json['plan_id'];
    extraDays = json['extra_days'];
    amountPaid = json['amount_paid'];
    paymentMethod = json['payment_method'];
    notes = json['notes'];
    status = json['status'];
    approvedBy = json['approved_by'];
    approvedAt = json['approved_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    institute = json['institute'] is Map ? Institute.fromJson(json['institute'])
        : null;
    plan = json['plan'] is Map ? Plan.fromJson(json['plan']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['institute_id'] = instituteId;
    data['plan_id'] = planId;
    data['extra_days'] = extraDays;
    data['amount_paid'] = amountPaid;
    data['payment_method'] = paymentMethod;
    data['notes'] = notes;
    data['status'] = status;
    data['approved_by'] = approvedBy;
    data['approved_at'] = approvedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (institute != null) {
      data['institute'] = institute!.toJson();
    }
    if (plan != null) {
      data['plan'] = plan!.toJson();
    }
    return data;
  }
}

class Institute {
  int? id;
  String? name;

  Institute({this.id, this.name});

  Institute.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Plan {
  int? id;
  String? name;
  double? price;
  String? durationDays;

  Plan({this.id, this.name, this.price, this.durationDays});

  Plan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = PriceConverter.parseAmount(json['price']);
    durationDays = json['duration_days'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['duration_days'] = durationDays;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}
