import 'package:class_compass/helper/price_converter.dart';

class AdvanceSalaryModel {
  bool? status;
  String? message;
  AdvanceSalaryItem? data;

  AdvanceSalaryModel({this.status, this.message, this.data});

  AdvanceSalaryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] is Map ? AdvanceSalaryItem.fromJson(json['data']) : null;
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

class AdvanceSalaryItem {
  List<UserPayroll>? userPayroll;

  AdvanceSalaryItem({this.userPayroll});

  AdvanceSalaryItem.fromJson(Map<String, dynamic> json) {
    if (json['userPayroll'] != null) {
      userPayroll = <UserPayroll>[];
      json['userPayroll'].forEach((v) {
        userPayroll!.add(UserPayroll.fromJson(v));
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

class UserPayroll {
  int? id;
  int? userId;
  double? netSalary;
  String? currentDue;
  double? currentAdvance;
  String? createdAt;
  User? user;

  UserPayroll(
      {this.id,
        this.userId,
        this.netSalary,
        this.currentDue,
        this.currentAdvance,
        this.createdAt,
        this.user});

  UserPayroll.fromJson(Map<String, dynamic> json) {
    id = PriceConverter.parseInt(json['id']);
    userId = PriceConverter.parseInt(json['user_id']);
    netSalary = PriceConverter.parseAmount(json['net_salary']);
    currentDue = json['current_due'];
    currentAdvance = PriceConverter.parseAmount(json['current_advance']);
    createdAt = json['created_at'];
    user = json['user'] is Map ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['net_salary'] = netSalary;
    data['current_due'] = currentDue;
    data['current_advance'] = currentAdvance;
    data['created_at'] = createdAt;
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
    id = PriceConverter.parseInt(json['id']);
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