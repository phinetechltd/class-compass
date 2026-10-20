import 'package:flutter/cupertino.dart';
import 'package:class_compass/helper/price_converter.dart';

class StudentModel {
  bool? status;
  String? message;
  List<StudentItem>? data;


  StudentModel({this.status, this.message, this.data});

  StudentModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? name;
  String? qrCode;
  String? firstName;
  String? lastName;
  String? image;
  String? phone;
  String? email;
  String? registerNo;
  String? fatherName;
  String? motherName;
  String? gender;
  String? bloodGroup;
  String? religion;
  String? address;
  String? status;
  String? nationality;
  String? createdAt;
  String? updatedAt;
  String? roll;
  String? prevRoll;
  String? newRoll;
  String? className;
  String? sectionName;
  String? groupName;
  int? classId;
  int? sectionId;
  int? groupId;
  TextEditingController? newRollController;
  String? informationSentToName;
  String? informationSentToRelation;
  String? informationSentToPhone;
  String? informationSentToAddress;
  String? informationSentToEmail;
  User? user;
  bool? isSelected = false;


  StudentItem(
      {this.id,
        this.name,
        this.qrCode,
        this.firstName,
        this.lastName,
        this.image,
        this.phone,
        this.email,
        this.registerNo,
        this.fatherName,
        this.motherName,
        this.gender,
        this.bloodGroup,
        this.religion,
        this.address,
        this.status,
        this.nationality,
        this.createdAt,
        this.updatedAt,
        this.roll,
        this.prevRoll,
        this.newRoll,
        this.className,
        this.sectionName,
        this.groupName,
        this.classId,
        this.sectionId,
        this.groupId,
        this.newRollController,
        this.informationSentToName,
        this.informationSentToRelation,
        this.informationSentToPhone,
        this.informationSentToAddress,
        this.informationSentToEmail,
        this.user,
        this.isSelected
      });

  StudentItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    qrCode = json['qr_code'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    image = json['image'];
    phone = json['phone'];
    email = json['email'];
    registerNo = json['registration_no'].toString();
    fatherName = json['father_name'];
    motherName = json['mother_name'];
    gender = json['gender'];
    bloodGroup = json['blood_group'];
    religion = json['religion'];
    address = json['address'];
    status = json['status'].toString();
    nationality = json['nationality'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    roll = json['roll'];
    prevRoll = json['prev_roll'];
    newRoll = json['new_roll'];
    className = json['class_name'];
    sectionName = json['section_name'];
    groupName = json['group_name'];
    classId = PriceConverter.parseInt(json['class_id']);
    sectionId = PriceConverter.parseInt(json['section_id']);
    groupId = PriceConverter.parseInt(json['group_id']);
    newRollController = TextEditingController(text: json['roll']);
    informationSentToName = json['information_sent_to_name'];
    informationSentToRelation = json['information_sent_to_relation'];
    informationSentToPhone = json['information_sent_to_phone'];
    informationSentToAddress = json['information_sent_to_address'];
    informationSentToEmail = json['information_sent_to_email'];
    user = json['user'] is Map ? User.fromJson(json['user']) : null;
    isSelected = false;
  }
  //toJson


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