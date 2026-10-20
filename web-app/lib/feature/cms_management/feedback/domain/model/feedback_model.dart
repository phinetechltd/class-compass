import 'package:class_compass/helper/price_converter.dart';

class FeedbackModel {
  bool? status;
  String? message;
  Data? data;

  FeedbackModel({this.status, this.message, this.data});

  FeedbackModel.fromJson(Map<String, dynamic> json) {
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
  List<FeedbackItem>? data;
  int? total;

  Data({this.currentPage, this.data, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <FeedbackItem>[];
      json['data'].forEach((v) {
        data!.add(FeedbackItem.fromJson(v));
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

class FeedbackItem {
  int? id;
  String? name;
  String? thumbnailImage;
  String? description;
  int? status;

  FeedbackItem(
      {this.id,
        this.name,
        this.thumbnailImage,
        this.description,
        this.status,});

  FeedbackItem.fromJson(Map<String, dynamic> json) {
    id = PriceConverter.parseInt(json['id']);
    name = json['name'];
    thumbnailImage = json['thumbnail_image'];
    description = json['description'];
    status = PriceConverter.parseInt(json['status']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['thumbnail_image'] = thumbnailImage;
    data['description'] = description;
    data['status'] = status;
    return data;
  }
}


