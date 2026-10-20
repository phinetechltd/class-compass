

import 'package:class_compass/helper/price_converter.dart';

class ReadyToJoinItem {
  int? id;
  String? title;
  String? description;
  String? buttonName;
  String? buttonLink;
  String? icon;
  int? status;
  String? createdAt;

  ReadyToJoinItem(
      {this.id,
        this.title,
        this.description,
        this.buttonName,
        this.buttonLink,
        this.icon,
        this.status,
        this.createdAt});

  ReadyToJoinItem.fromJson(Map<String, dynamic> json) {
    id = PriceConverter.parseInt(json['id']);
    title = json['title'];
    description = json['description'];
    buttonName = json['button_name'];
    buttonLink = json['button_link'];
    icon = json['icon'];
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
    data['icon'] = icon;
    data['status'] = status;
    data['created_at'] = createdAt;
    return data;
  }
}

