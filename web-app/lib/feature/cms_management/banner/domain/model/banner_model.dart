import 'package:class_compass/helper/price_converter.dart';

class BannerModel {
  bool? status;
  String? message;
  Data? data;

  BannerModel({this.status, this.message, this.data});

  BannerModel.fromJson(Map<String, dynamic> json) {
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
  List<BannerItem>? data;
  int? total;

  Data(
      {this.currentPage,
        this.data,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <BannerItem>[];
      json['data'].forEach((v) {
        data!.add(BannerItem.fromJson(v));
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

class BannerItem {
  int? id;
  String? title;
  String? description;
  String? buttonName;
  String? buttonLink;
  String? image;
  int? status;
  String? createdAt;

  BannerItem(
      {this.id,
        this.title,
        this.description,
        this.buttonName,
        this.buttonLink,
        this.image,
        this.status,
        this.createdAt});

  BannerItem.fromJson(Map<String, dynamic> json) {
    id = PriceConverter.parseInt(json['id']);
    title = json['title'];
    description = json['description'];
    buttonName = json['button_name'];
    buttonLink = json['button_link'];
    image = json['image'];
    status = PriceConverter.parseInt(json['status']);
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['button_name'] = buttonName;
    data['button_link'] = buttonLink;
    data['image'] = image;
    data['status'] = status;
    data['created_at'] = createdAt;
    return data;
  }
}

