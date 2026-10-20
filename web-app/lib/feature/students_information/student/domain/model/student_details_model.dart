import 'package:class_compass/feature/academic_configuration/class/domain/model/class_model.dart';
import 'package:class_compass/feature/academic_configuration/group/domain/model/group_model.dart';
import 'package:class_compass/feature/academic_configuration/section/domain/model/section_model.dart';
import 'package:class_compass/feature/academic_configuration/session/domain/models/session_model.dart';
import 'package:class_compass/feature/academic_configuration/student_categories/domain/model/student_categories_model.dart';

class StudentDetailsModel {
  bool? status;
  String? message;
  StudentInfo? data;

  StudentDetailsModel({this.status, this.message, this.data});

  StudentDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] is Map ? StudentInfo.fromJson(json['data']) : null;
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

class StudentInfo {
  int? id;
  int? userId;
  String? group;
  int? studentCategoryId;
  String? firstName;
  String? lastName;
  String? phone;
  String? registerNo;
  String? rollNo;
  String? fatherName;
  String? motherName;
  String? birthday;
  String? gender;
  String? bloodGroup;
  String? religion;
  String? address;
  String? status;
  String? informationSentToName;
  String? informationSentToRelation;
  String? informationSentToPhone;
  String? informationSentToAddress;

  String? nationality;
  String? nidNo;
  String? ethnic;
  String? dateOfAdmission;
  String? applicationNumber;
  String? admissionPlace;
  String? tcDate;
  String? createdAt;
  String? nativeName;
  String? nickName;
  String? fatherPhoneNo;
  String? fatherOccupation;
  String? fatherDesignation;
  String? fatherOfficeAddress;
  String? fatherNid;
  String? motherPhoneNo;
  String? motherOccupation;
  String? motherDesignation;
  String? motherOfficeAddress;
  String? motherNid;
  String? localGuardianRelation;
  String? localGuardianName;
  String? localGuardianOccupation;
  String? localGuardianDesignation;
  String? localGuardianPhoneRes;
  String? localGuardianPhoneOffice;
  String? localGuardianNid;
  String? presentAddress;
  String? presentAddressPhone;
  String? permanentAddress;
  User? user;
  StudentSession? studentSession;
  StudentCategoryItem? studentCategory;
  GroupItem? studentGroup;

  StudentInfo(
      {this.id,
        this.userId,
        this.group,
        this.studentCategoryId,
        this.firstName,
        this.lastName,
        this.phone,
        this.registerNo,
        this.rollNo,
        this.fatherName,
        this.motherName,
        this.birthday,
        this.gender,
        this.bloodGroup,
        this.religion,
        this.address,
        this.status,
        this.informationSentToName,
        this.informationSentToRelation,
        this.informationSentToPhone,
        this.informationSentToAddress,
        this.nationality,
        this.nidNo,
        this.ethnic,
        this.dateOfAdmission,
        this.applicationNumber,
        this.admissionPlace,
        this.tcDate,
        this.createdAt,
        this.nativeName,
        this.nickName,
        this.fatherPhoneNo,
        this.fatherOccupation,
        this.fatherDesignation,
        this.fatherOfficeAddress,
        this.fatherNid,
        this.motherPhoneNo,
        this.motherOccupation,
        this.motherDesignation,
        this.motherOfficeAddress,
        this.motherNid,
        this.localGuardianRelation,
        this.localGuardianName,
        this.localGuardianOccupation,
        this.localGuardianDesignation,
        this.localGuardianPhoneRes,
        this.localGuardianPhoneOffice,
        this.localGuardianNid,
        this.presentAddress,
        this.presentAddressPhone,
        this.permanentAddress,
        this.user,
        this.studentSession,
        this.studentCategory,
        this.studentGroup});

  StudentInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    group = json['group'];
    studentCategoryId = json['student_category_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    registerNo = json['register_no'];
    rollNo = json['roll_no'];
    fatherName = json['father_name'];
    motherName = json['mother_name'];
    birthday = json['birthday'];
    gender = json['gender'];
    bloodGroup = json['blood_group'];
    religion = json['religion'];
    address = json['address'];
    status = json['status'];
    informationSentToName = json['information_sent_to_name'];
    informationSentToRelation = json['information_sent_to_relation'];
    informationSentToPhone = json['information_sent_to_phone'];
    informationSentToAddress = json['information_sent_to_address'];
    nationality = json['nationality'];
    nidNo = json['nid_no'];
    ethnic = json['ethnic'];
    dateOfAdmission = json['date_of_admission'];
    applicationNumber = json['application_number'];
    admissionPlace = json['admission_place'];
    tcDate = json['tc_date'];
    createdAt = json['created_at'];
    nativeName = json['native_name'];
    nickName = json['nick_name'];
    fatherPhoneNo = json['father_phone_no'];
    fatherOccupation = json['father_occupation'];
    fatherDesignation = json['father_designation'];
    fatherOfficeAddress = json['father_office_address'];
    fatherNid = json['father_nid'];
    motherPhoneNo = json['mother_phone_no'];
    motherOccupation = json['mother_occupation'];
    motherDesignation = json['mother_designation'];
    motherOfficeAddress = json['mother_office_address'];
    motherNid = json['mother_nid'];
    localGuardianRelation = json['local_guardian_relation'];
    localGuardianName = json['local_guardian_name'];
    localGuardianOccupation = json['local_guardian_occupation'];
    localGuardianDesignation = json['local_guardian_designation'];
    localGuardianPhoneRes = json['local_guardian_phone_res'];
    localGuardianPhoneOffice = json['local_guardian_phone_office'];
    localGuardianNid = json['local_guardian_nid'];
    presentAddress = json['present_address'];
    presentAddressPhone = json['present_address_phone'];
    permanentAddress = json['permanent_address'];

    user = json['user'] is Map ? User.fromJson(json['user']) : null;
    studentSession = json['student_session'] is Map ? StudentSession.fromJson(json['student_session'])
        : null;
    studentCategory = json['student_category'] is Map ? StudentCategoryItem.fromJson(json['student_category'])
        : null;
    studentGroup = json['student_group'] is Map ? GroupItem.fromJson(json['student_group'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['group'] = group;
    data['student_category_id'] = studentCategoryId;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['phone'] = phone;
    data['register_no'] = registerNo;
    data['roll_no'] = rollNo;
    data['father_name'] = fatherName;
    data['mother_name'] = motherName;
    data['birthday'] = birthday;
    data['gender'] = gender;
    data['blood_group'] = bloodGroup;
    data['religion'] = religion;
    data['address'] = address;
    data['status'] = status;
    data['information_sent_to_name'] = informationSentToName;
    data['information_sent_to_relation'] = informationSentToRelation;
    data['information_sent_to_phone'] = informationSentToPhone;
    data['information_sent_to_address'] = informationSentToAddress;
    data['nationality'] = nationality;
    data['nid_no'] = nidNo;
    data['ethnic'] = ethnic;
    data['date_of_admission'] = dateOfAdmission;
    data['application_number'] = applicationNumber;
    data['admission_place'] = admissionPlace;
    data['tc_date'] = tcDate;
    data['created_at'] = createdAt;
    data['native_name'] = nativeName;
    data['nick_name'] = nickName;
    data['father_phone_no'] = fatherPhoneNo;
    data['father_occupation'] = fatherOccupation;
    data['father_designation'] = fatherDesignation;
    data['father_office_address'] = fatherOfficeAddress;
    data['father_nid'] = fatherNid;
    data['mother_phone_no'] = motherPhoneNo;
    data['mother_occupation'] = motherOccupation;
    data['mother_designation'] = motherDesignation;
    data['mother_office_address'] = motherOfficeAddress;
    data['mother_nid'] = motherNid;
    data['local_guardian_relation'] = localGuardianRelation;
    data['local_guardian_name'] = localGuardianName;
    data['local_guardian_occupation'] = localGuardianOccupation;
    data['local_guardian_designation'] = localGuardianDesignation;
    data['local_guardian_phone_res'] = localGuardianPhoneRes;
    data['local_guardian_phone_office'] = localGuardianPhoneOffice;
    data['local_guardian_nid'] = localGuardianNid;
    data['present_address'] = presentAddress;
    data['present_address_phone'] = presentAddressPhone;
    data['permanent_address'] = permanentAddress;

    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (studentSession != null) {
      data['student_session'] = studentSession!.toJson();
    }
    if (studentCategory != null) {
      data['student_category'] = studentCategory!.toJson();
    }
    if (studentGroup != null) {
      data['student_group'] = studentGroup!.toJson();
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

class StudentSession {
  int? id;
  int? sectionId;
  String? roll;
  String? qrCode;
  ClassItem? classItem;
  SectionItem? section;
  SessionItem? session;

  StudentSession(
      {this.id,
        this.sectionId,
        this.roll,
        this.qrCode,
        this.classItem,
        this.section,
        this.session});

  StudentSession.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sectionId = json['section_id'];
    roll = json['roll'];
    qrCode = json['qr_code'];
    classItem = json['class'] is Map ? ClassItem.fromJson(json['class'])
        : null;
    section =
    json['section'] is Map ? SectionItem.fromJson(json['section']) : null;
    session =
    json['session'] is Map ? SessionItem.fromJson(json['session']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['section_id'] = sectionId;
    data['roll'] = roll;
    data['qr_code'] = qrCode;
    if (classItem != null) {
      data['class'] = classItem!.toJson();
    }
    if (section != null) {
      data['section'] = section!.toJson();
    }
    if (session != null) {
      data['session'] = session!.toJson();
    }
    return data;
  }
}

