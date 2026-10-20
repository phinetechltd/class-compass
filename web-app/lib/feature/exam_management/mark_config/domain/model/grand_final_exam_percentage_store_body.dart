import 'package:flutter/cupertino.dart';

class GrandFinalExamPercentageStoreBody {
  int? classId;
  List<Percentages>? percentages;
  List<SerialNo>? serialNo;

  GrandFinalExamPercentageStoreBody(
      {this.classId, this.percentages, this.serialNo});

  GrandFinalExamPercentageStoreBody.fromJson(Map<String, dynamic> json) {
    classId = json['class_id'];
    if (json['percentages'] != null) {
      percentages = <Percentages>[];
      json['percentages'].forEach((v) {
        percentages!.add(Percentages.fromJson(v));
      });
    }
    if (json['serial_no'] != null) {
      serialNo = <SerialNo>[];
      json['serial_no'].forEach((v) {
        serialNo!.add(SerialNo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['class_id'] = classId;
    if (percentages != null) {
      data['percentages'] = percentages!.map((v) => v.toJson()).toList();
    }
    if (serialNo != null) {
      data['serial_no'] = serialNo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Percentages {
  int? examId;
  String? percentage;

  Percentages({this.examId, this.percentage});

  Percentages.fromJson(Map<String, dynamic> json) {
    examId = json['exam_id'];
    percentage = json['percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['exam_id'] = examId;
    data['percentage'] = percentage;
    return data;
  }
}

class SerialNo {
  int? examId;
  String? serialNo;

  SerialNo({this.examId, this.serialNo});

  SerialNo.fromJson(Map<String, dynamic> json) {
    examId = json['exam_id'];
    serialNo = json['serial_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['exam_id'] = examId;
    data['serial_no'] = serialNo;
    return data;
  }
}

class GrandFinalExamPercentageBody{
  final int examId;
  final String name;
  TextEditingController percentage;
  TextEditingController serialNo;
  GrandFinalExamPercentageBody( {required this.examId,required this.name, required this.percentage, required this.serialNo,});
}

