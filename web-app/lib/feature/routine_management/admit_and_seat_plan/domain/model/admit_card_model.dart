import 'package:class_compass/feature/academic_configuration/group/domain/model/group_model.dart';
import 'package:class_compass/feature/academic_configuration/section/domain/model/section_model.dart';
import 'package:class_compass/feature/academic_configuration/session/domain/models/session_model.dart';
import 'package:class_compass/feature/academic_configuration/class/domain/model/class_model.dart';
import 'package:class_compass/feature/academic_configuration/student_categories/domain/model/student_categories_model.dart';
import 'package:class_compass/helper/price_converter.dart';

class AdmitCardModel {
  bool? status;
  String? message;
  Data? data;

  AdmitCardModel({this.status, this.message, this.data});

  AdmitCardModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] is Map ? Data.fromJson(json['data']) : null;
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

class Data {
  String? type;
  String? examName;
  List<AdmitCardItem>? data;

  Data({this.type, this.examName, this.data});

  Data.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    examName = json['exam_name'];
    if (json['data'] != null) {
      data = <AdmitCardItem>[];
      json['data'].forEach((v) {
        data!.add(AdmitCardItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['exam_name'] = examName;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AdmitCardItem {
  int? id;
  int? instituteId;
  int? branchId;
  int? sessionId;
  int? studentId;
  int? classId;
  int? sectionId;
  String? roll;
  String? qrCode;
  String? optionalSubject;
  Student? student;
  SessionItem? session;
  ClassItem? classItem;
  SectionItem? section;

  AdmitCardItem(
      {this.id,
        this.instituteId,
        this.branchId,
        this.sessionId,
        this.studentId,
        this.classId,
        this.sectionId,
        this.roll,
        this.qrCode,
        this.optionalSubject,
        this.student,
        this.session,
        this.classItem,
        this.section});

  AdmitCardItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instituteId = json['institute_id'];
    branchId = json['branch_id'];
    sessionId = json['session_id'];
    studentId = json['student_id'];
    classId = json['class_id'];
    sectionId = json['section_id'];
    roll = json['roll'];
    qrCode = json['qr_code'];
    optionalSubject = json['optional_subject'];
    student =
    json['student'] is Map ? Student.fromJson(json['student']) : null;
    session =
    json['session'] is Map ? SessionItem.fromJson(json['session']) : null;
    classItem = json['class'] is Map ? ClassItem.fromJson(json['class'])
        : null;
    section =
    json['section'] is Map ? SectionItem.fromJson(json['section']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['institute_id'] = instituteId;
    data['branch_id'] = branchId;
    data['session_id'] = sessionId;
    data['student_id'] = studentId;
    data['class_id'] = classId;
    data['section_id'] = sectionId;
    data['roll'] = roll;
    data['qr_code'] = qrCode;
    data['optional_subject'] = optionalSubject;
    return data;
  }
}
class Student {
  int? id;
  String? firstName;
  String? lastName;
  String? phone;
  String? registerNo;
  String? fatherName;
  String? motherName;
  String? gender;
  String? bloodGroup;
  String? religion;
  String? address;
  String? nationality;
  User? user;
  GroupItem? studentGroup;
  StudentCategoryItem? studentCategory;

  Student(
      {this.id,
        this.firstName,
        this.lastName,
        this.phone,
        this.registerNo,
        this.fatherName,
        this.motherName,
        this.gender,
        this.bloodGroup,
        this.religion,
        this.address,
        this.nationality,
        this.user,
        this.studentGroup,
        this.studentCategory});

  Student.fromJson(Map<String, dynamic> json) {
    id = PriceConverter.parseInt(json['id']);
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    registerNo = (json['registration_no'] ?? json['register_no'] ?? '').toString();
    fatherName = json['father_name'];
    motherName = json['mother_name'];
    gender = json['gender'];
    bloodGroup = json['blood_group'];
    religion = json['religion'];
    address = json['address'];
    nationality = json['nationality'];
    user = json['user'] is Map ? User.fromJson(json['user']) : null;
    studentGroup = json['student_group'] is Map ? GroupItem.fromJson(json['student_group'])
        : null;
    studentCategory = json['student_category'] is Map ? StudentCategoryItem.fromJson(json['student_category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['phone'] = phone;
    data['register_no'] = registerNo;
    data['father_name'] = fatherName;
    data['mother_name'] = motherName;
    data['gender'] = gender;
    data['blood_group'] = bloodGroup;
    data['religion'] = religion;
    data['address'] = address;
    data['nationality'] = nationality;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (studentGroup != null) {
      data['student_group'] = studentGroup!.toJson();
    }
    if (studentCategory != null) {
      data['student_category'] = studentCategory!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;

  User({this.id, this.name, this.email, this.phone, this.image});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['image'] = image;
    return data;
  }
}



