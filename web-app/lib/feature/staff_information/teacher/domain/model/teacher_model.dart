import 'package:class_compass/feature/staff_information/staff/domain/models/staff_model.dart';

class TeacherModel {
  bool? status;
  String? message;
  Data? data;

  TeacherModel({this.status, this.message, this.data});

  TeacherModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] is Map ? Data.fromJson(json['data']) : null;

  }

}

class Data {
  int? currentPage;
  List<StaffItem>? data;
  int? total;

  Data({this.currentPage, this.data, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <StaffItem>[];
      json['data'].forEach((v) {
        data!.add(StaffItem.fromJson(v));
      });
    }
    total = json['total'];
  }


}



