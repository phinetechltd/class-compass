import 'package:class_compass/helper/price_converter.dart';

class AbsentStudentModel {
  bool? status;
  String? message;
  List<AbsentStudentItem>? data;

  AbsentStudentModel({this.status, this.message, this.data});

  AbsentStudentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AbsentStudentItem>[];
      json['data'].forEach((v) {
        data!.add(AbsentStudentItem.fromJson(v));
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

class AbsentStudentItem {
  int? studentId;
  String? name;
  String? rollNo;
  String? phone;
  int? attendance;
  int? periodId;
  String? date;
  bool? selected;

  AbsentStudentItem(
      {this.studentId,
        this.name,
        this.rollNo,
        this.phone,
        this.attendance,
        this.periodId,
        this.date,
        this.selected
      });

  AbsentStudentItem.fromJson(Map<String, dynamic> json) {
    studentId = PriceConverter.parseInt(json['student_id']);
    name = json['name'];
    rollNo = json['roll_no'];
    phone = json['phone'].toString();
    attendance = json['attendance'];
    periodId = PriceConverter.parseInt(json['period_id']);
    date = json['date'];
    selected = json['selected']?? false;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['student_id'] = studentId;
    data['name'] = name;
    data['roll_no'] = rollNo;
    data['phone'] = phone;
    data['attendance'] = attendance;
    data['period_id'] = periodId;
    data['date'] = date;
    data['selected'] = selected;
    return data;
  }
}
