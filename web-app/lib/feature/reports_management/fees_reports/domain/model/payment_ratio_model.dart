class PaymentRatioModel {
  bool? status;
  String? message;
  List<PaymentRatioItem>? data;

  PaymentRatioModel({this.status, this.message, this.data});

  PaymentRatioModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PaymentRatioItem>[];
      json['data'].forEach((v) {
        data!.add(PaymentRatioItem.fromJson(v));
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

class PaymentRatioItem {
  String? className;
  String? totalStudents;
  String? paidStudents;
  String? paidPercentage;
  String? unpaidStudents;
  String? unpaidPercentage;

  PaymentRatioItem(
      {this.className,
        this.totalStudents,
        this.paidStudents,
        this.paidPercentage,
        this.unpaidStudents,
        this.unpaidPercentage});

  PaymentRatioItem.fromJson(Map<String, dynamic> json) {
    className = json['class_name'];
    totalStudents = json['total_students'];
    paidStudents = json['paid_students'];
    paidPercentage = json['paid_percentage'];
    unpaidStudents = json['unpaid_students'];
    unpaidPercentage = json['unpaid_percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['class_name'] = className;
    data['total_students'] = totalStudents;
    data['paid_students'] = paidStudents;
    data['paid_percentage'] = paidPercentage;
    data['unpaid_students'] = unpaidStudents;
    data['unpaid_percentage'] = unpaidPercentage;
    return data;
  }
}
