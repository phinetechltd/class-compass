

import 'package:class_compass/helper/price_converter.dart';

class WhyChooseUsItem {
  int? id;
  String? title;
  String? description;
  String? icon;
  String? createdAt;

  WhyChooseUsItem(
      {this.id,
        this.title,
        this.description,
        this.icon,
        this.createdAt,});

  WhyChooseUsItem.fromJson(Map<String, dynamic> json) {
    id = PriceConverter.parseInt(json['id']);
    title = json['title'];
    description = json['description'];
    icon = json['icon'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['icon'] = icon;
    data['created_at'] = createdAt;
    return data;
  }
}

