class ChapterModel {
  bool? status;
  String? message;
  Data? data;

  ChapterModel({this.status, this.message, this.data});

  ChapterModel.fromJson(Map<String, dynamic> json) {
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
  List<ChapterItem>? data;
  int? total;

  Data(
      {this.currentPage,
        this.data,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <ChapterItem>[];
      json['data'].forEach((v) {
        data!.add(ChapterItem.fromJson(v));
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

class ChapterItem {
  int? id;
  int? instituteId;
  int? courseId;
  String? courseTitle;
  String? title;
  String? slug;
  int? priority;
  String? image;
  String? description;
  String? metaDescription;
  String? metaKeywords;
  int? createdBy;
  String? createdByName;
  String? status;


  ChapterItem(
      {this.id,
        this.instituteId,
        this.courseId,
        this.courseTitle,
        this.title,
        this.slug,
        this.priority,
        this.image,
        this.description,
        this.metaDescription,
        this.metaKeywords,
        this.createdBy,
        this.createdByName,
        this.status,
        });

  ChapterItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instituteId = json['institute_id'];
    courseId = json['course_id'];
    courseTitle = json['course_title'];
    title = json['title'];
    slug = json['slug'];
    priority = json['priority'];
    image = json['image'];
    description = json['description'];
    metaDescription = json['meta_description'];
    metaKeywords = json['meta_keywords'];
    createdBy = json['created_by'];
    createdByName = json['created_by_name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['institute_id'] = instituteId;
    data['course_id'] = courseId;
    data['course_title'] = courseTitle;
    data['title'] = title;
    data['slug'] = slug;
    data['priority'] = priority;
    data['image'] = image;
    data['description'] = description;
    data['meta_description'] = metaDescription;
    data['meta_keywords'] = metaKeywords;
    data['created_by'] = createdBy;
    data['created_by_name'] = createdByName;
    data['status'] = status;
    return data;
  }
}

