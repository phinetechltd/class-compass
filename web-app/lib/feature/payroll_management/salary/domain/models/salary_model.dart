import 'package:class_compass/helper/price_converter.dart';

class SalaryModel {
  bool? status;
  String? message;
  SalaryItem? data;

  SalaryModel({this.status, this.message, this.data});

  SalaryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] is Map ? SalaryItem.fromJson(json['data']) : null;
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

class SalaryItem {
  int? year;
  int? month;
  List<SalarySlips>? salarySlips;

  SalaryItem({this.year, this.month, this.salarySlips});

  SalaryItem.fromJson(Map<String, dynamic> json) {
    year = PriceConverter.parseInt(json['year']);
    month = PriceConverter.parseInt(json['month']);
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
  PayrollUser? user;
  List<SalaryHeads>? salaryHeads;
  List<SalaryHeadUserPayrolls>? salaryHeadUserPayrolls;
  double? dueAmount;
  double? netSalary;
  double? payableAmount;
  double? salarySlips;

  SalarySlips(
      {this.user,
        this.salaryHeads,
        this.salaryHeadUserPayrolls,
        this.dueAmount,
        this.netSalary,
        this.payableAmount,
        this.salarySlips});

  SalarySlips.fromJson(Map<String, dynamic> json) {
    user = json['user'] is Map ? PayrollUser.fromJson(json['user']) : null;
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
    dueAmount = PriceConverter.parseAmount(json['due_amount']);
    netSalary = PriceConverter.parseAmount(json['net_salary']);
    payableAmount = PriceConverter.parseAmount(json['payable_amount']);
    salarySlips = PriceConverter.parseAmount(json['salary_slips']);
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
    data['due_amount'] = dueAmount;
    data['net_salary'] = netSalary;
    data['payable_amount'] = payableAmount;
    data['salary_slips'] = salarySlips;
    return data;
  }
}

class PayrollUser {
  int? id;
  String? name;
  String? userType;
  UserPayroll? userPayroll;
  List<PayslipSalary>? payslipSalary;

  PayrollUser(
      {this.id,
        this.name,
        this.userType,
        this.userPayroll,
        this.payslipSalary});

  PayrollUser.fromJson(Map<String, dynamic> json) {
    id = PriceConverter.parseInt(json['id']);
    name = json['name'];
    userType = json['user_type'];
    userPayroll = json['user_payroll'] is Map ? UserPayroll.fromJson(json['user_payroll'])
        : null;
    if (json['payslip_salary'] != null) {
      payslipSalary = <PayslipSalary>[];
      json['payslip_salary'].forEach((v) {
        payslipSalary!.add(PayslipSalary.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['user_type'] = userType;
    if (userPayroll != null) {
      data['user_payroll'] = userPayroll!.toJson();
    }
    if (payslipSalary != null) {
      data['payslip_salary'] =
          payslipSalary!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserPayroll {
  int? id;
  double? netSalary;
  double? currentDue;
  double? currentAdvance;

  UserPayroll(
      {this.id,
        this.netSalary,
        this.currentDue,
        this.currentAdvance,
       });

  UserPayroll.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    netSalary = PriceConverter.parseAmount(json['net_salary']);
    currentDue = PriceConverter.parseAmount(json['current_due']);
    currentAdvance = PriceConverter.parseAmount(json['current_advance']);

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['net_salary'] = netSalary;
    data['current_due'] = currentDue;
    data['current_advance'] = currentAdvance;
    return data;
  }
}

class PayslipSalary {
  int? id;
  String? year;
  String? month;
  String? paidAmount;
  String? isPaid;

  PayslipSalary(
      {this.id,
        this.year,
        this.month,
        this.paidAmount,
        this.isPaid,
        });

  PayslipSalary.fromJson(Map<String, dynamic> json) {
    id = PriceConverter.parseInt(json['id']);
    year = json['year'].toString();
    month = json['month'].toString();
    paidAmount = json['paid_amount'];
    isPaid = json['is_paid'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['year'] = year;
    data['month'] = month;
    data['paid_amount'] = paidAmount;
    data['is_paid'] = isPaid;
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
        this.type,
        });

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
  double? amount;
  double? netSalary;
  double? currentDue;
  double? currentAdvance;

  SalaryHeadUserPayrolls(
      {this.id,
        this.amount,
        this.netSalary,
        this.currentDue,
        this.currentAdvance});

  SalaryHeadUserPayrolls.fromJson(Map<String, dynamic> json) {
    id = PriceConverter.parseInt(json['id']);
    amount = PriceConverter.parseAmount(json['amount']);
    netSalary = PriceConverter.parseAmount(json['net_salary']);
    currentDue = PriceConverter.parseAmount(json['current_due']);
    currentAdvance = PriceConverter.parseAmount(json['current_advance']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['amount'] = amount;
    data['net_salary'] = netSalary;
    data['current_due'] = currentDue;
    data['current_advance'] = currentAdvance;
    return data;
  }
}
