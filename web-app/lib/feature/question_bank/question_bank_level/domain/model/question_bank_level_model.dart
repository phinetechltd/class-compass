class QuestionBankLevelModel {
  bool? status;
  String? message;
  Data? data;
  QuestionBankLevelModel({this.status, this.message, this.data});

  QuestionBankLevelModel.fromJson(Map<String, dynamic> json) {
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
  List<QuestionBankLevelItem>? data;
  int? total;

  Data(
      {this.currentPage,
        this.data,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <QuestionBankLevelItem>[];
      json['data'].forEach((v) {
        data!.add(QuestionBankLevelItem.fromJson(v));
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

class QuestionBankLevelItem {
  int? id;
  String? levelName;
  bool? isSelected;


  QuestionBankLevelItem({this.id, this.levelName, this.isSelected});

  QuestionBankLevelItem.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id']?.toString() ??'');
    levelName = json['level_name'];
    isSelected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['level_name'] = levelName;
    return data;
  }
}

