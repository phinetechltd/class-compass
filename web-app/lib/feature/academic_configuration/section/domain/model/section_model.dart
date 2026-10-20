class SectionModel {
  bool? status;
  String? message;
  Data? data;

  SectionModel({this.status, this.message, this.data});

  SectionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] is Map ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? currentPage;
  List<SectionItem>? data;
  int? total;

  Data(
      {this.currentPage,
        this.data,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <SectionItem>[];
      json['data'].forEach((v) {
        data!.add(SectionItem.fromJson(v));
      });
    }
    total = json['total'];
  }
}

class SectionItem {
  int? id;
  String? sectionName;
  String? className;
  String? groupName;
  String? teacherName;

  SectionItem(
      {this.id,
        this.sectionName,
        this.className,
        this.groupName,
        this.teacherName,
       });

  SectionItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sectionName = json['section_name'];
    className = json['class_name'];
    groupName = json['group_name'];
    teacherName = json['teacher_name'];
  }

  //toJson
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['section_name'] = sectionName;
    data['class_name'] = className;
    data['group_name'] = groupName;
    data['teacher_name'] = teacherName;
    return data;
  }

}
