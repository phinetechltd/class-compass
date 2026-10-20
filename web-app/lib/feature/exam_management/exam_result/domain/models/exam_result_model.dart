import 'package:class_compass/helper/price_converter.dart';

class ExamResultModel {
  bool? success;
  String? message;
  Summary? summary;
  List<ExamResultItem>? data;

  ExamResultModel({this.success, this.message, this.summary, this.data});

  ExamResultModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    summary =
    json['summary'] is Map ? Summary.fromJson(json['summary']) : null;
    if (json['data'] != null) {
      data = <ExamResultItem>[];
      json['data'].forEach((v) {
        data!.add(ExamResultItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (summary != null) {
      data['summary'] = summary!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Summary {
  int? totalStudents;
  int? passed;
  int? failed;

  Summary({this.totalStudents, this.passed, this.failed});

  Summary.fromJson(Map<String, dynamic> json) {
    totalStudents = PriceConverter.parseInt(json['total_students']);
    passed = PriceConverter.parseInt(json['passed']);
    failed = PriceConverter.parseInt(json['failed']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_students'] = totalStudents;
    data['passed'] = passed;
    data['failed'] = failed;
    return data;
  }
}

class ExamResultItem {
  int? studentId;
  String? studentName;
  String? roll;
  double? totalMarks;
  double? gpa;
  String? grade;
  String? status;
  List<Subjects>? subjects;

  ExamResultItem(
      {this.studentId,
        this.studentName,
        this.roll,
        this.totalMarks,
        this.gpa,
        this.grade,
        this.status,
        this.subjects});

  ExamResultItem.fromJson(Map<String, dynamic> json) {
    studentId = PriceConverter.parseInt(json['student_id']);
    studentName = json['student_name'];
    roll = json['roll'].toString();
    totalMarks = PriceConverter.parseAmount(json['total_marks']);
    gpa = PriceConverter.parseAmount(json['gpa']);
    grade = json['grade'];
    status = json['status'].toString();
    if (json['subjects'] != null) {
      subjects = <Subjects>[];
      json['subjects'].forEach((v) {
        subjects!.add(Subjects.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['student_id'] = studentId;
    data['student_name'] = studentName;
    data['roll'] = roll;
    data['total_marks'] = totalMarks;
    data['gpa'] = gpa;
    data['grade'] = grade;
    data['status'] = status;
    if (subjects != null) {
      data['subjects'] = subjects!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subjects {
  int? subjectId;
  String? subjectName;
  String? totalMarks;
  double? percentage;
  String? grade;
  String? gradePoint;

  Subjects(
      {this.subjectId,
        this.subjectName,
        this.totalMarks,
        this.percentage,
        this.grade,
        this.gradePoint});

  Subjects.fromJson(Map<String, dynamic> json) {
    subjectId = PriceConverter.parseInt(json['subject_id']);
    subjectName = json['subject_name'];
    totalMarks = json['total_marks'].toString();
    percentage = PriceConverter.parseAmount(json['percentage']);
    grade = json['grade'].toString();
    gradePoint = json['grade_point'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subject_id'] = subjectId;
    data['subject_name'] = subjectName;
    data['total_marks'] = totalMarks;
    data['percentage'] = percentage;
    data['grade'] = grade;
    data['grade_point'] = gradePoint;
    return data;
  }
}
