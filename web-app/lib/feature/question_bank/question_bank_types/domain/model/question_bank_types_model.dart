import 'package:class_compass/helper/price_converter.dart';

class QuestionBankTypesModel {
  bool? status;
  String? message;
  Data? data;

  QuestionBankTypesModel({this.status, this.message, this.data});

  QuestionBankTypesModel.fromJson(Map<String, dynamic> json) {
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
  int? currentPage;
  List<QuestionBankTypesItem>? data;
  int? total;

  Data(
      {this.currentPage,
        this.data,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <QuestionBankTypesItem>[];
      json['data'].forEach((v) {
        data!.add(QuestionBankTypesItem.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    return data;
  }
}

class QuestionBankTypesItem {
  int? id;
  String? typeName;
  int? status;
  bool? isSelected;

  QuestionBankTypesItem({this.id, this.typeName, this.status, this.isSelected});

  QuestionBankTypesItem.fromJson(Map<String, dynamic> json) {
    id = PriceConverter.parseInt(json['id']);
    typeName = json['type_name'];
    status = PriceConverter.parseInt(json['status']);
    isSelected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type_name'] = typeName;
    data['status'] = status;
    return data;
  }
}
