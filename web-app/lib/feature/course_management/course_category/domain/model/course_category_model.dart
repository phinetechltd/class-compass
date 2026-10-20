

import 'package:class_compass/helper/price_converter.dart';

class CourseCategoryItem {
  int? id;
  String? name;
  String? slug;
  String? image;
  String? bgColor;
  int? priority;
  int? enableHomepage;
  String? description;
  int? status;
  String? createdAt;

  CourseCategoryItem(
      {this.id,
        this.name,
        this.slug,
        this.image,
        this.bgColor,
        this.priority,
        this.enableHomepage,
        this.description,
        this.status,
        this.createdAt});

  CourseCategoryItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
    bgColor = json['bg_color'];
    priority = PriceConverter.parseInt(json['priority']);
    enableHomepage = PriceConverter.parseInt(json['enable_homepage']);
    description = json['description'];
    status = PriceConverter.parseInt(json['status']);
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['image'] = image;
    data['bg_color'] = bgColor;
    data['priority'] = priority;
    data['enable_homepage'] = enableHomepage;
    data['description'] = description;
    data['status'] = status;
    data['created_at'] = createdAt;
    return data;
  }
}
