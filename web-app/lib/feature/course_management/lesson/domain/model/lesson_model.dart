class LessonModel {
  bool? status;
  String? message;
  Data? data;

  LessonModel({this.status, this.message, this.data});

  LessonModel.fromJson(Map<String, dynamic> json) {
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
  List<LessonItem>? data;
  int? total;

  Data(
      {this.currentPage,
        this.data,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <LessonItem>[];
      json['data'].forEach((v) {
        data!.add(LessonItem.fromJson(v));
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

class LessonItem {
  int? id;
  int? instituteId;
  int? courseId;
  int? chapterId;
  String? title;
  String? slug;
  int? priority;
  String? description;
  String? metaDescription;
  String? metaKeywords;
  int? totalView;
  int? isFree;
  int? isLive;
  String? type;
  String? label;
  String? videoUrl;
  String? embeddedUrl;
  int? createdBy;
  String? createdByName;
  String? status;

  LessonItem(
      {this.id,
        this.instituteId,
        this.courseId,
        this.chapterId,
        this.title,
        this.slug,
        this.priority,
        this.description,
        this.metaDescription,
        this.metaKeywords,
        this.totalView,
        this.isFree,
        this.isLive,
        this.type,
        this.label,
        this.videoUrl,
        this.embeddedUrl,
        this.createdBy,
        this.createdByName,
        this.status,});

  LessonItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instituteId = json['institute_id'];
    courseId = json['course_id'];
    chapterId = json['chapter_id'];
    title = json['title'];
    slug = json['slug'];
    priority = json['priority'];
    description = json['description'];
    metaDescription = json['meta_description'];
    metaKeywords = json['meta_keywords'];
    totalView = json['total_view'];
    isFree = json['is_free'];
    isLive = json['is_live'];
    type = json['type'];
    label = json['label'];
    videoUrl = json['video_url'];
    embeddedUrl = json['embedded_url'];
    createdBy = json['created_by'];
    createdByName = json['created_by_name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['institute_id'] = instituteId;
    data['course_id'] = courseId;
    data['chapter_id'] = chapterId;
    data['title'] = title;
    data['slug'] = slug;
    data['priority'] = priority;
    data['description'] = description;
    data['meta_description'] = metaDescription;
    data['meta_keywords'] = metaKeywords;
    data['total_view'] = totalView;
    data['is_free'] = isFree;
    data['is_live'] = isLive;
    data['type'] = type;
    data['label'] = label;
    data['video_url'] = videoUrl;
    data['embedded_url'] = embeddedUrl;
    data['created_by'] = createdBy;
    data['created_by_name'] = createdByName;
    data['status'] = status;
    return data;
  }
}
