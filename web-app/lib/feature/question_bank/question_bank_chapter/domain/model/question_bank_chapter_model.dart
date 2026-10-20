class QuestionBankChapterModel {
  bool? status;
  String? message;
  Data? data;

  QuestionBankChapterModel({this.status, this.message, this.data});

  QuestionBankChapterModel.fromJson(Map<String, dynamic> json) {
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
  List<QuestionBankChapterItem>? data;
  int? total;

  Data({this.currentPage, this.data, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <QuestionBankChapterItem>[];
      json['data'].forEach((v) {
        data!.add(QuestionBankChapterItem.fromJson(v));
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

class QuestionBankChapterItem {
  int? id;
  int? subjectId;
  String? subjectName;
  String? name;

  QuestionBankChapterItem({this.id, this.subjectId, this.subjectName, this.name});

  QuestionBankChapterItem.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    subjectId = int.parse(json['subject_id'].toString());
    subjectName = json['subject_name'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['subject_id'] = subjectId;
    data['subject_name'] = subjectName;
    data['name'] = name;
    return data;
  }
}

