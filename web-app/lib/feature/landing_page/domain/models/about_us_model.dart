class AboutUsModel {
  bool? status;
  String? message;
  LandingAboutUsItem? data;

  AboutUsModel({this.status, this.message, this.data});

  AboutUsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] is Map ? LandingAboutUsItem.fromJson(json['data']) : null;
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

class LandingAboutUsItem {
  int? id;
  String? title;
  String? description;
  String? image;


  LandingAboutUsItem(
      {this.id,
        this.title,
        this.description,
        this.image,
      });

  LandingAboutUsItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['image'] = image;
    return data;
  }
}
