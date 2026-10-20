import 'package:class_compass/helper/price_converter.dart';

class GrandFinalMarkUpdateModel {
  bool? status;
  String? message;
  Data? data;

  GrandFinalMarkUpdateModel({this.status, this.message, this.data});

  GrandFinalMarkUpdateModel.fromJson(Map<String, dynamic> json) {
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
  bool? status;
  List<PercentageItem>? data;

  Data({this.status, this.data});

  Data.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <PercentageItem>[];
      json['data'].forEach((v) {
        data!.add(PercentageItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PercentageItem {
  int? examId;
  String? examName;
  double? percentage;
  int? serialNo;

  PercentageItem({this.examId, this.examName, this.percentage, this.serialNo});

  PercentageItem.fromJson(Map<String, dynamic> json) {
    examId = PriceConverter.parseInt(json['exam_id']);
    examName = json['exam_name'];
    percentage = PriceConverter.parseAmount(json['percentage']);
    serialNo = PriceConverter.parseInt(json['serial_no']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['exam_id'] = examId;
    data['exam_name'] = examName;
    data['percentage'] = percentage;
    data['serial_no'] = serialNo;
    return data;
  }
}
