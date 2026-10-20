import 'package:class_compass/helper/price_converter.dart';

class FeesModel {
  bool? status;
  String? message;
  Data? data;


  FeesModel({this.status, this.message, this.data});

  FeesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] is Map ? Data.fromJson(json['data']) : null;

  }

}

class Data {
  int? currentPage;
  List<FeesItem>? data;
  int? total;

  Data({this.currentPage, this.data,  this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <FeesItem>[];
      json['data'].forEach((v) { data!.add(FeesItem.fromJson(v)); });
    }
    total = json['total'];
  }

}

class FeesItem {
  int? id;
  String? feeHeadId;
  double? feeAmount;
  double? fineAmount;
  ClassItem? classItem;
  Section? section;
  Group? group;
  StudentCategory? studentCategory;
  FeeHead? feeHead;

  FeesItem({this.id, this.feeHeadId, this.feeAmount, this.fineAmount,
     this.section, this.group, this.studentCategory, this.feeHead});

FeesItem.fromJson(Map<String, dynamic> json) {
  id = json['id'];
  feeHeadId = json['fee_head_id'].toString();
  feeAmount = PriceConverter.parseAmount(json['fee_amount']);
  fineAmount = PriceConverter.parseAmount(json['fine_amount']);
  classItem = json['class'] is Map ? ClassItem.fromJson(json['class']) : null;
  section = json['section'] is Map ? Section.fromJson(json['section']) : null;
  group = json['group'] is Map ? Group.fromJson(json['group']) : null;
  studentCategory = json['student_category'] is Map ? StudentCategory.fromJson(json['student_category']) : null;
  feeHead = json['fee_head'] is Map ? FeeHead.fromJson(json['fee_head']) : null;
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

class Section {
  int? id;
  String? sectionName;

  Section({this.id, this.sectionName});

  Section.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sectionName = json['section_name'];
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

class StudentCategory {
  int? id;
  String? name;

  StudentCategory({this.id, this.name});

  StudentCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }


}

class FeeHead {
  int? id;
  String? name;
  List<FeeSubHeads>? feeSubHeads;

  FeeHead({this.id, this.name, this.feeSubHeads});

  FeeHead.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['fee_sub_heads'] != null) {
      feeSubHeads = <FeeSubHeads>[];
      json['fee_sub_heads'].forEach((v) { feeSubHeads!.add(FeeSubHeads.fromJson(v)); });
    }
  }


}

class FeeSubHeads {
  int? id;
  String? feeHeadId;
  String? name;
  String? serial;


  FeeSubHeads({this.id, this.feeHeadId, this.name, this.serial});

  FeeSubHeads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    feeHeadId = json['fee_head_id'].toString();
    name = json['name'];
    serial = json['serial'].toString();
  }


}
