import 'package:class_compass/helper/price_converter.dart';
import 'my_course_model.dart';

class FrontendCourseModel {
  bool? status;
  String? message;
  Data? data;

  FrontendCourseModel({this.status, this.message, this.data, });

  FrontendCourseModel.fromJson(Map<String, dynamic> json) {
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
  List<CourseCategories>? courseCategories;

  Data({this.pageTitle, this.courseCategories});

  Data.fromJson(Map<String, dynamic> json) {
    pageTitle = json['pageTitle'];
    if (json['courseCategories'] != null) {
      courseCategories = <CourseCategories>[];
      json['courseCategories'].forEach((v) {
        courseCategories!.add(CourseCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pageTitle'] = pageTitle;
    if (courseCategories != null) {
      data['courseCategories'] =
          courseCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CourseCategories {
  int? id;
  String? name;
  String? slug;
  String? createdAt;
  List<CourseItem>? courses;

  CourseCategories(
      {this.id,
        this.name,
        this.slug,
        this.createdAt,
        this.courses});

  CourseCategories.fromJson(Map<String, dynamic> json) {
    id = PriceConverter.parseInt(json['id']);
    name = json['name'];
    slug = json['slug'];
    createdAt = json['created_at'];
    if (json['courses'] != null) {
      courses = <CourseItem>[];
      json['courses'].forEach((v) {
        courses!.add(CourseItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['created_at'] = createdAt;
    if (courses != null) {
      data['courses'] = courses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

