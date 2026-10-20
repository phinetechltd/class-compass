
import 'package:class_compass/helper/price_converter.dart';

class MobileAppItem {
  int? id;
  String? title;
  String? heading;
  String? description;
  String? image;
  String? featureOne;
  String? featureTwo;
  String? featureThree;
  String? playStoreLink;
  String? appStoreLink;

  MobileAppItem(
      {this.id,
        this.title,
        this.heading,
        this.description,
        this.image,
        this.featureOne,
        this.featureTwo,
        this.featureThree,
        this.playStoreLink,
        this.appStoreLink,});

  MobileAppItem.fromJson(Map<String, dynamic> json) {
    id = PriceConverter.parseInt(json['id']);
    title = json['title'];
    heading = json['heading'];
    description = json['description'];
    image = json['image'];
    featureOne = json['feature_one'];
    featureTwo = json['feature_two'];
    featureThree = json['feature_three'];
    playStoreLink = json['play_store_link'];
    appStoreLink = json['app_store_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['heading'] = heading;
    data['description'] = description;
    data['image'] = image;
    data['feature_one'] = featureOne;
    data['feature_two'] = featureTwo;
    data['feature_three'] = featureThree;
    data['play_store_link'] = playStoreLink;
    data['app_store_link'] = appStoreLink;
    return data;
  }
}


