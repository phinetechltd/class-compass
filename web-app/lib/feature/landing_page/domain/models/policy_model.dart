import 'package:class_compass/helper/price_converter.dart';

class PolicyModel {
  bool? status;
  String? message;
  PolicyItem? data;

  PolicyModel({this.status, this.message, this.data});

  PolicyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] is Map ? PolicyItem.fromJson(json['data']) : null;
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

class PolicyItem {
  int? id;
  int? type;
  String? description;

  PolicyItem({this.id, this.type, this.description});

  PolicyItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = PriceConverter.parseInt(json['type']);
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['description'] = description;
    return data;
  }
}
