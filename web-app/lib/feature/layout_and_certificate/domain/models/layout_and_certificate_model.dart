import 'package:class_compass/helper/price_converter.dart';

class LayoutAndCertificateModel {
  bool? status;
  String? message;
  Data? data;

  LayoutAndCertificateModel({this.status, this.message, this.data});

  LayoutAndCertificateModel.fromJson(Map<String, dynamic> json) {
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
  StudentSession? studentSession;

  Data({this.type, this.studentSession});

  Data.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    studentSession = json['student_session'] is Map ? StudentSession.fromJson(json['student_session'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    if (studentSession != null) {
      data['student_session'] = studentSession!.toJson();
    }
    return data;
  }
}

class StudentSession {
  int? id;
  String? roll;
  String? qrCode;
  String? createdAt;
  String? updatedAt;
  Student? student;
  Session? session;
  ClassItem? classItem;
  Section? section;

  StudentSession(
      {this.id,
        this.roll,
        this.qrCode,
        this.createdAt,
        this.updatedAt,
        this.student,
        this.session,
        this.classItem,
        this.section});

  StudentSession.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roll = json['roll'];
    qrCode = json['qr_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    student = json['student'] is Map ? Student.fromJson(json['student']) : null;
    session = json['session'] is Map ? Session.fromJson(json['session']) : null;
    classItem = json['class'] is Map ? ClassItem.fromJson(json['class']) : null;
    section = json['section'] is Map ? Section.fromJson(json['section']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['roll'] = roll;
    data['qr_code'] = qrCode;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (student != null) {
      data['student'] = student!.toJson();
    }
    if (session != null) {
      data['session'] = session!.toJson();
    }
    if (classItem != null) {
      data['class'] = classItem!.toJson();
    }
    if (section != null) {
      data['section'] = section!.toJson();
    }
    return data;
  }
}

class Student {
  int? id;
  String? group;
  String? firstName;
  String? lastName;
  String? phone;
  int? registerNo;
  String? fatherName;
  String? motherName;
  String? birthday;
  String? gender;
  String? bloodGroup;
  String? religion;
  String? address;
  String? nationality;
  StudentGroup? studentGroup;
  StudentCategory? studentCategory;

  Student(
      {this.id,
        this.group,
        this.firstName,
        this.lastName,
        this.phone,
        this.registerNo,
        this.fatherName,
        this.motherName,
        this.birthday,
        this.gender,
        this.bloodGroup,
        this.religion,
        this.address,
        this.nationality,
        this.studentGroup,
        this.studentCategory});

  Student.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    group = json['group'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'].toString();
    registerNo = PriceConverter.parseInt(json['register_no']);
    fatherName = json['father_name'];
    motherName = json['mother_name'];
    birthday = json['birthday'];
    gender = json['gender'];
    bloodGroup = json['blood_group'];
    religion = json['religion'];
    address = json['address'];
    nationality = json['nationality'];
    studentGroup = json['student_group'] is Map ? StudentGroup.fromJson(json['student_group'])
        : null;
    studentCategory = json['student_category'] is Map ? StudentCategory.fromJson(json['student_category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['group'] = group;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['phone'] = phone;
    data['register_no'] = registerNo;
    data['father_name'] = fatherName;
    data['mother_name'] = motherName;
    data['birthday'] = birthday;
    data['gender'] = gender;
    data['blood_group'] = bloodGroup;
    data['religion'] = religion;
    data['address'] = address;
    data['nationality'] = nationality;
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
  int? status;

  User({this.id, this.name, this.email, this.phone, this.image, this.status});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['image'] = image;
    data['status'] = status;
    return data;
  }
}

class StudentGroup {
  int? id;
  String? groupName;
  String? createdAt;
  String? updatedAt;

  StudentGroup(
      {this.id,
        this.groupName,
        this.createdAt,
        this.updatedAt});

  StudentGroup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupName = json['group_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['group_name'] = groupName;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class StudentCategory {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  StudentCategory(
      {this.id,
        this.name,
        this.createdAt,
        this.updatedAt});

  StudentCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Session {
  int? id;
  String? session;
  String? year;
  String? createdAt;
  String? updatedAt;

  Session({this.id, this.session, this.year, this.createdAt, this.updatedAt});

  Session.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    session = json['session'];
    year = json['year'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['session'] = session;
    data['year'] = year;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class ClassItem {
  int? id;
  String? className;
  int? status;
  String? createdAt;
  String? updatedAt;

  ClassItem(
      {this.id,
        this.className,
        this.status,
        this.createdAt,
        this.updatedAt});

  ClassItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    className = json['class_name'];
    status = PriceConverter.parseInt(json['status']);
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['class_name'] = className;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Section {
  int? id;
  String? sectionName;
  String? roomNo;


  Section(
      {this.id,
        this.sectionName,
        this.roomNo,});

  Section.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sectionName = json['section_name'];
    roomNo = json['room_no'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['section_name'] = sectionName;
    data['room_no'] = roomNo;
    return data;
  }
}
