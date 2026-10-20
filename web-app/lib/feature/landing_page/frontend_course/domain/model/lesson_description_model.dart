import 'package:class_compass/feature/course_management/course/domain/model/course_details_model.dart';

class LessonDescriptionModel {
  bool? status;
  String? message;
  Contents? data;

  LessonDescriptionModel({this.status, this.message, this.data,});

  LessonDescriptionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] is Map ? Contents.fromJson(json['data']) : null;

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


