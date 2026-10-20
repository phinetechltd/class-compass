class QuestionCategoryModel {
  bool? status;
  String? message;
  Data? data;

  QuestionCategoryModel({this.status, this.message, this.data});

  QuestionCategoryModel.fromJson(Map<String, dynamic> json) {
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
  List<QuestionCategoryItem>? data;
  int? total;

  Data(
      {this.currentPage,
        this.data,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <QuestionCategoryItem>[];
      json['data'].forEach((v) {
        data!.add(QuestionCategoryItem.fromJson(v));
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

class QuestionCategoryItem {
  int? id;
  int? instituteId;
  String? name;
  int? priority;
  String? description;
  String? createdAt;

  QuestionCategoryItem(
      {this.id,
        this.instituteId,
        this.name,
        this.priority,
        this.description,
        this.createdAt});

  QuestionCategoryItem.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id']?.toString() ??'');
    instituteId = int.tryParse(json['institute_id']?.toString() ?? '');
    name = json['name'];
    priority = int.tryParse(json['priority']?.toString() ?? '');
    description = json['description'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['institute_id'] = instituteId;
    data['name'] = name;
    data['priority'] = priority;
    data['description'] = description;
    data['created_at'] = createdAt;
    return data;
  }
}


