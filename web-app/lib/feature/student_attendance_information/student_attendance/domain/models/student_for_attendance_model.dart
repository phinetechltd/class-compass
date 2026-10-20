import 'package:class_compass/helper/price_converter.dart';

class StudentForAttendanceModel {
  bool? status;
  String? message;
  List<StudentItem>? data;

  StudentForAttendanceModel({this.status, this.message, this.data});

  StudentForAttendanceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <StudentItem>[];
      json['data'].forEach((v) {
        data!.add(StudentItem.fromJson(v));
      });
    }
  }

}

class StudentItem {
  int? studentId;
  String? name;
  String? phone;
  String? rollNo;
  bool? isPresent;


  StudentItem(
      {
        this.studentId,
        this.name,
        this.phone,
        this.rollNo,

        this.isPresent
        });

  StudentItem.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    rollNo = json['roll_no'].toString();
    studentId = PriceConverter.parseInt(json['student_id']);
    isPresent = false;
  }
}
