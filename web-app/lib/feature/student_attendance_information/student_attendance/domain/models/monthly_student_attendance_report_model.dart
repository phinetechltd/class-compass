import 'package:class_compass/helper/price_converter.dart';

class MonthlyStudentAttendanceReportModel {
  bool? status;
  String? message;
  MonthlyAttendanceItem? data;

  MonthlyStudentAttendanceReportModel({this.status, this.message, this.data});

  MonthlyStudentAttendanceReportModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] is Map ? MonthlyAttendanceItem.fromJson(json['data']) : null;
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

class MonthlyAttendanceItem {
  String? month;
  int? numOfDays;
  List<Report>? report;

  MonthlyAttendanceItem(
      {
        this.month,
        this.numOfDays,
        this.report});

  MonthlyAttendanceItem.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    numOfDays = json['num_of_days'];
    if (json['report'] != null) {
      report = <Report>[];
      json['report'].forEach((v) {
        report!.add(Report.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['month'] = month;
    data['num_of_days'] = numOfDays;
    if (report != null) {
      data['report'] = report!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Report {
  int? studentId;
  String? studentName;
  String? roll;
  String? studentPhone;
  List<Attendance>? attendance;

  Report({this.studentName, this.roll, this.studentPhone, this.attendance});

  Report.fromJson(Map<String, dynamic> json) {
    studentId = PriceConverter.parseInt(json['student_id']);
    studentName = json['student_name'];
    roll = json['roll'];
    studentPhone = json['student_phone'];
    if (json['attendance'] != null) {
      attendance = <Attendance>[];
      json['attendance'].forEach((v) {
        attendance!.add(Attendance.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['student_id'] = studentId;
    data['student_name'] = studentName;
    data['roll'] = roll;
    data['student_phone'] = studentPhone;
    if (attendance != null) {
      data['attendance'] = attendance!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attendance {
  String? date;
  String? status;

  Attendance({this.date, this.status});

  Attendance.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['status'] = status;
    return data;
  }
}
