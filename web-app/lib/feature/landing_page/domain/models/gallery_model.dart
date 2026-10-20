class GalleryModel {
  bool? status;
  String? message;
  Data? data;

  GalleryModel({this.status, this.message, this.data});

  GalleryModel.fromJson(Map<String, dynamic> json) {
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
  String? pageTitle;
  List<AcademicImages>? academicImages;

  Data({this.pageTitle, this.academicImages});

  Data.fromJson(Map<String, dynamic> json) {
    pageTitle = json['pageTitle'];
    if (json['academicImages'] != null) {
      academicImages = <AcademicImages>[];
      json['academicImages'].forEach((v) {
        academicImages!.add(AcademicImages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pageTitle'] = pageTitle;
    if (academicImages != null) {
      data['academicImages'] =
          academicImages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AcademicImages {
  int? id;
  String? title;
  String? heading;
  String? description;
  String? image;

  AcademicImages(
      {this.id,
        this.title,
        this.heading,
        this.description,
        this.image});

  AcademicImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    heading = json['heading'];
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['heading'] = heading;
    data['description'] = description;
    data['image'] = image;
    return data;
  }
}
