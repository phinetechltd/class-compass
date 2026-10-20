import 'package:class_compass/helper/price_converter.dart';

class StudentAttendanceReport {
  bool? status;
  String? message;
  List<AttendanceReportItem>? data;

  StudentAttendanceReport({this.status, this.message, this.data});

  StudentAttendanceReport.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AttendanceReportItem>[];
      json['data'].forEach((v) {
        data!.add(AttendanceReportItem.fromJson(v));
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

class AttendanceReportItem {
  int? studentId;
  String? studentName;
  double? present;
  double? absent;
  double? attendanceRatio;

  AttendanceReportItem(
      {this.studentId,
        this.studentName,
        this.present,
        this.absent,
        this.attendanceRatio});

  AttendanceReportItem.fromJson(Map<String, dynamic> json) {
    studentId = json['student_id'];
    studentName = json['student_name'];
    present = PriceConverter.parseAmount(json['present']);
    absent = PriceConverter.parseAmount(json['absent']);
    attendanceRatio = PriceConverter.parseAmount(json['attendance_ratio']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['student_id'] = studentId;
    data['student_name'] = studentName;
    data['present'] = present;
    data['absent'] = absent;
    data['attendance_ratio'] = attendanceRatio;
    return data;
  }
}
