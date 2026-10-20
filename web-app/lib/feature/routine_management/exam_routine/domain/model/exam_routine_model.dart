import 'package:flutter/cupertino.dart';
import 'package:class_compass/feature/exam_management/exam/domain/model/exam_model.dart';
class ExamRoutineModel {
  bool? status;
  String? message;
  List<ExamRoutineItem>? data;


  ExamRoutineModel({this.status, this.message, this.data});

  ExamRoutineModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ExamRoutineItem>[];
      json['data'].forEach((v) {
        data!.add(ExamRoutineItem.fromJson(v));
      });
    }

  }

}

class ExamRoutineItem {
  String? subjectName;
  String? subjectCode;
  String? subjectType;
  String? id;
  String? subjectId;
  String? date;
  String? startTime;
  String? endTime;
  String? room;
  ExamItem? exam;

  ExamRoutineItem(
      {this.subjectName,
        this.subjectCode,
        this.subjectType,
        this.id,
        this.date,
        this.startTime,
        this.endTime,
        this.room,
        this.exam});

  ExamRoutineItem.fromJson(Map<String, dynamic> json) {
    subjectName = json['subject_name'].toString();
    subjectCode = json['subject_code'].toString();
    subjectType = json['subject_type'].toString();
    id = json['id'].toString();
    subjectId = json['subject_id'].toString();
    date = json['date'].toString();
    startTime = json['start_time'].toString();
    endTime = json['end_time'].toString();
    room = json['room'].toString();
    exam = json['exam'] is Map ? ExamItem.fromJson(json['exam']) : null;
  }

}


class ExamRoutineItemBody{
  String subjectId;
  String subjectName;
  TextEditingController dateController;
  TextEditingController startTimeController;
  TextEditingController endTimeController;
  TextEditingController roomController;

  ExamRoutineItemBody(
      {required this.subjectId,
        required this.subjectName,
      required this.dateController,
      required this.startTimeController,
      required this.endTimeController,
      required this.roomController});
}