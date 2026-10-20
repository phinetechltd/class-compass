class MarkInputModel {
  bool? status;
  String? message;
  MarkConfigItem? data;

  MarkInputModel({this.status, this.message, this.data});

  MarkInputModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] is Map ? MarkConfigItem.fromJson(json['data']) : null;
  }

}

class MarkConfigItem {
  List<MarkConfig>? markConfig;
  List<Students>? students;

  MarkConfigItem({this.markConfig, this.students});

  MarkConfigItem.fromJson(Map<String, dynamic> json) {
    if (json['markConfig'] != null) {
      markConfig = <MarkConfig>[];
      json['markConfig'].forEach((v) { markConfig!.add(MarkConfig.fromJson(v)); });
    }
    if (json['students'] != null) {
      students = <Students>[];
      json['students'].forEach((v) { students!.add(Students.fromJson(v)); });
    }
  }

}

class MarkConfig {
  MarkConfigExamCode? markConfigExamCode;

  MarkConfig({this.markConfigExamCode});

  MarkConfig.fromJson(Map<String, dynamic> json) {
  markConfigExamCode = json['mark_config_exam_code'] is Map ? MarkConfigExamCode.fromJson(json['mark_config_exam_code']) : null;
  }


}

class ClassItem {
  int? id;
  String? className;

  ClassItem({this.id, this.className});

  ClassItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    className = json['class_name'];
  }

}

class Group {
  int? id;
  String? groupName;

  Group({this.id, this.groupName});

  Group.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupName = json['group_name'];
  }

}

class Subject {
  int? id;
  String? subjectName;

  Subject({this.id, this.subjectName});

  Subject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subjectName = json['subject_name'];
  }

}

class MarkConfigExamCode {
  int? id;
  String? title;
  String? totalMarks;
  String? passMark;
  String? acceptance;
  MarkConfigExamCode({this.id, this.title, this.totalMarks, this.passMark, this.acceptance});

  MarkConfigExamCode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    totalMarks = json['total_marks'].toString();
    passMark = json['pass_mark'].toString();
    acceptance = json['acceptance'].toString();
  }

}

class Students {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? roleId;
  String? status;
  String? userType;
  String? roll;
  String? className;
  String? sectionName;
  String? groupName;
  String? userId;
  String? gender;
  String? religion;
  String? studentStatus;

  Students({this.id, this.name, this.email, this.phone, this.image,
    this.roleId, this.status, this.userType, this.roll, this.className, this.sectionName, this.groupName, this.userId, this.gender, this.religion, this.studentStatus});

  Students.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    roleId = json['role_id'].toString();
    status = json['status'].toString();
    userType = json['user_type'];
    roll = json['roll'];
    className = json['class_name'];
    sectionName = json['section_name'];
    groupName = json['group_name'];
    userId = json['user_id'].toString();
    gender = json['gender'];
    religion = json['religion'];
    studentStatus = json['student_status'];
  }

}
