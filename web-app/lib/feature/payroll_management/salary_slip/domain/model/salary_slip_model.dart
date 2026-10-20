import 'package:class_compass/helper/price_converter.dart';

class SalarySlipModel {
  bool? status;
  String? message;
  SalarySlipItem? data;

  SalarySlipModel({this.status, this.message, this.data});

  SalarySlipModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] is Map ? SalarySlipItem.fromJson(json['data']) : null;
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

class SalarySlipItem {
  int? year;
  String? month;
  List<SalarySlips>? salarySlips;

  SalarySlipItem({this.year, this.month, this.salarySlips});

  SalarySlipItem.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    month = json['month'];
    if (json['salary_slips'] != null) {
      salarySlips = <SalarySlips>[];
      json['salary_slips'].forEach((v) {
        salarySlips!.add(SalarySlips.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['year'] = year;
    data['month'] = month;
    if (salarySlips != null) {
      data['salary_slips'] = salarySlips!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SalarySlips {
  User? user;
  List<SalaryHeads>? salaryHeads;
  List<SalaryHeadUserPayrolls>? salaryHeadUserPayrolls;
  bool isSelected = false;

  SalarySlips({this.user, this.salaryHeads, this.salaryHeadUserPayrolls, this.isSelected = false});

  SalarySlips.fromJson(Map<String, dynamic> json) {
    user = json['user'] is Map ? User.fromJson(json['user']) : null;
    if (json['salary_heads'] != null) {
      salaryHeads = <SalaryHeads>[];
      json['salary_heads'].forEach((v) {
        salaryHeads!.add(SalaryHeads.fromJson(v));
      });
    }
    if (json['salary_head_user_payrolls'] != null) {
      salaryHeadUserPayrolls = <SalaryHeadUserPayrolls>[];
      json['salary_head_user_payrolls'].forEach((v) {
        salaryHeadUserPayrolls!.add(SalaryHeadUserPayrolls.fromJson(v));
      });
    }
    isSelected = json['isSelected'] ?? false;


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (salaryHeads != null) {
      data['salary_heads'] = salaryHeads!.map((v) => v.toJson()).toList();
    }
    if (salaryHeadUserPayrolls != null) {
      data['salary_head_user_payrolls'] =
          salaryHeadUserPayrolls!.map((v) => v.toJson()).toList();
    }
    data['isSelected'] = isSelected;
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? userType;
  UserPayroll? userPayroll;

  User({this.id, this.name, this.userType, this.userPayroll});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    userType = json['user_type'];
    userPayroll = json['user_payroll'] is Map ? UserPayroll.fromJson(json['user_payroll'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['user_type'] = userType;
    if (userPayroll != null) {
      data['user_payroll'] = userPayroll!.toJson();
    }
    return data;
  }
}

class UserPayroll {
  int? id;
  int? userId;
  String? netSalary;
  String? currentDue;
  String? currentAdvance;
  String? createdAt;
  String? updatedAt;

  UserPayroll(
      {this.id,
        this.userId,
        this.netSalary,
        this.currentDue,
        this.currentAdvance,
        this.createdAt,
        this.updatedAt});

  UserPayroll.fromJson(Map<String, dynamic> json) {
    id = PriceConverter.parseInt(json['id']);
    userId = PriceConverter.parseInt(json['user_id']);
    netSalary = json['net_salary'];
    currentDue = json['current_due'];
    currentAdvance = json['current_advance'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['net_salary'] = netSalary;
    data['current_due'] = currentDue;
    data['current_advance'] = currentAdvance;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class SalaryHeads {
  int? id;
  String? name;
  String? type;

  SalaryHeads(
      {this.id,
        this.name,
        this.type,});

  SalaryHeads.fromJson(Map<String, dynamic> json) {
    id = PriceConverter.parseInt(json['id']);
    name = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    return data;
  }
}

class SalaryHeadUserPayrolls {
  int? id;
  int? userPayrollId;
  int? salaryHeadId;
  double? amount;
  int? userId;
  double? netSalary;
  double? currentDue;
  double? currentAdvance;

  SalaryHeadUserPayrolls(
      {this.id,
        this.userPayrollId,
        this.salaryHeadId,
        this.amount,
        this.userId,
        this.netSalary,
        this.currentDue,
        this.currentAdvance});

  SalaryHeadUserPayrolls.fromJson(Map<String, dynamic> json) {
    id = PriceConverter.parseInt(json['id']);
    userPayrollId = PriceConverter.parseInt(json['user_payroll_id']);
    salaryHeadId = PriceConverter.parseInt(json['salary_head_id']);
    amount = PriceConverter.parseAmount(json['amount']);
    userId = PriceConverter.parseInt(json['user_id']);
    netSalary = PriceConverter.parseAmount(json['net_salary']);
    currentDue = PriceConverter.parseAmount(json['current_due']);
    currentAdvance = PriceConverter.parseAmount(json['current_advance']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_payroll_id'] = userPayrollId;
    data['salary_head_id'] = salaryHeadId;
    data['amount'] = amount;
    data['user_id'] = userId;
    data['net_salary'] = netSalary;
    data['current_due'] = currentDue;
    data['current_advance'] = currentAdvance;
    return data;
  }
}
