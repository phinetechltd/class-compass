class BannerModel {
  bool? status;
  String? message;
  List<BannerItem>? data;


  BannerModel({this.status, this.message, this.data});

  BannerModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <BannerItem>[];
      json['data'].forEach((v) {
        data!.add(BannerItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
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


  BannerItem(
      {this.id,
        this.title,
        this.description,
        this.buttonName,
        this.buttonLink,
        this.image,
      });

  BannerItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    buttonName = json['button_name'];
    buttonLink = json['button_link'];
    image = json['image'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['button_name'] = buttonName;
    data['button_link'] = buttonLink;
    data['image'] = image;
    return data;
  }
}
