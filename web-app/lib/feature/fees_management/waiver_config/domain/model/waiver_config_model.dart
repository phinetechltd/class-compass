import 'package:class_compass/helper/price_converter.dart';

class WaiverConfigModel {
  bool? status;
  String? message;
  WaiverConfigItem? data;

  WaiverConfigModel({this.status, this.message, this.data});

  WaiverConfigModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] is Map ? WaiverConfigItem.fromJson(json['data']) : null;
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

class WaiverConfigItem {
  List<WaiverList>? waiverList;

  WaiverConfigItem({this.waiverList});

  WaiverConfigItem.fromJson(Map<String, dynamic> json) {
    if (json['waiver_list'] != null) {
      waiverList = <WaiverList>[];
      json['waiver_list'].forEach((v) {
        waiverList!.add(WaiverList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (waiverList != null) {
      data['waiver_list'] = waiverList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WaiverList {
  int? waiverConfigId;
  double? waiverAmount;
  int? studentId;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? roll;
  String? className;
  String? sectionName;
  int? feeHeadId;
  String? feeHeadName;
  int? waiverId;
  String? waiverName;

  WaiverList(
      {this.waiverConfigId,
        this.waiverAmount,
        this.studentId,
        this.firstName,
        this.lastName,
        this.email,
        this.phone,
        this.roll,
        this.className,
        this.sectionName,
        this.feeHeadId,
        this.feeHeadName,
        this.waiverId,
        this.waiverName});

  WaiverList.fromJson(Map<String, dynamic> json) {
    waiverConfigId = PriceConverter.parseInt(json['waiver_config_id']);
    waiverAmount = PriceConverter.parseAmount(json['waiver_amount']);
    studentId = PriceConverter.parseInt(json['student_id']);
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    roll = json['roll'];
    className = json['class_name'];
    sectionName = json['section_name'];
    feeHeadId = PriceConverter.parseInt(json['fee_head_id']);
    feeHeadName = json['fee_head_name'];
    waiverId = PriceConverter.parseInt(json['waiver_id']);
    waiverName = json['waiver_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['waiver_config_id'] = waiverConfigId;
    data['waiver_amount'] = waiverAmount;
    data['student_id'] = studentId;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    data['roll'] = roll;
    data['class_name'] = className;
    data['section_name'] = sectionName;
    data['fee_head_id'] = feeHeadId;
    data['fee_head_name'] = feeHeadName;
    data['waiver_id'] = waiverId;
    data['waiver_name'] = waiverName;
    return data;
  }
}
