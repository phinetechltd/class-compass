import 'package:class_compass/helper/price_converter.dart';

class PayrollAssignModel {
  bool? status;
  String? message;
  List<PayrollUserItem>? data;

  PayrollAssignModel({this.status, this.message, this.data});

  PayrollAssignModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PayrollUserItem>[];
      json['data'].forEach((v) {
        data!.add(PayrollUserItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PayrollUserItem {
  User? user;
  List<SalaryHeads>? salaryHeads;
  List<SalaryHeadUserPayrolls>? salaryHeadUserPayrolls;

  PayrollUserItem({this.user, this.salaryHeads, this.salaryHeadUserPayrolls});

  PayrollUserItem.fromJson(Map<String, dynamic> json) {
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
  String? netSalary;
  String? currentDue;
  String? currentAdvance;
  String? createdAt;
  String? updatedAt;

  UserPayroll(
      {this.id,
        this.netSalary,
        this.currentDue,
        this.currentAdvance,
        this.createdAt,
        this.updatedAt});

  UserPayroll.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    netSalary = json['net_salary'];
    currentDue = json['current_due'];
    currentAdvance = json['current_advance'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
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
    id = json['id'];
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
    userPayrollId = PriceConverter.parseInt( json['user_payroll_id']);
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
