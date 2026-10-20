import 'package:class_compass/helper/price_converter.dart';

class DueModel {
  bool? status;
  String? message;
  DueItem? data;

  DueModel({this.status, this.message, this.data});

  DueModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] is Map ? DueItem.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DueItem {
  List<DueUserPayroll>? userPayroll;

  DueItem({this.userPayroll});

  DueItem.fromJson(Map<String, dynamic> json) {
    if (json['userPayroll'] != null) {
      userPayroll = <DueUserPayroll>[];
      json['userPayroll'].forEach((v) {
        userPayroll!.add(DueUserPayroll.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userPayroll != null) {
      data['userPayroll'] = userPayroll!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DueUserPayroll {
  int? id;
  int? instituteId;
  int? branchId;
  int? userId;
  String? netSalary;
  double? currentDue;
  String? currentAdvance;
  String? createdAt;
  String? updatedAt;
  User? user;

  DueUserPayroll(
      {this.id,
        this.instituteId,
        this.branchId,
        this.userId,
        this.netSalary,
        this.currentDue,
        this.currentAdvance,
        this.createdAt,
        this.updatedAt,
        this.user});

  DueUserPayroll.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instituteId = json['institute_id'];
    branchId = json['branch_id'];
    userId = json['user_id'];
    netSalary = json['net_salary'];
    currentDue = PriceConverter.parseAmount(json['current_due']);
    currentAdvance = json['current_advance'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] is Map ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['institute_id'] = instituteId;
    data['branch_id'] = branchId;
    data['user_id'] = userId;
    data['net_salary'] = netSalary;
    data['current_due'] = currentDue;
    data['current_advance'] = currentAdvance;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? phone;
  String? userType;
  String? image;

  User({this.id, this.name, this.phone, this.userType, this.image});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    userType = json['user_type'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['user_type'] = userType;
    data['image'] = image;
    return data;
  }
}
