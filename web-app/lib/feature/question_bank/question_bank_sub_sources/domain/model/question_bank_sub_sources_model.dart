class QuestionBankSubSourceModel {
  bool? status;
  String? message;
  Data? data;
  QuestionBankSubSourceModel(
      {this.status, this.message, this.data,});

  QuestionBankSubSourceModel.fromJson(Map<String, dynamic> json) {
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
  List<QuestionBankSubSourceItem>? data;
  int? total;

  Data({this.currentPage, this.data, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <QuestionBankSubSourceItem>[];
      json['data'].forEach((v) {
        data!.add(QuestionBankSubSourceItem.fromJson(v));
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

class QuestionBankSubSourceItem {
  int? id;
  int? sourceId;
  String? sourceName;
  String? subSourceName;
  bool? isSelected;

  QuestionBankSubSourceItem(
      {this.id,
        this.sourceId,
        this.sourceName,
        this.subSourceName,
        this.isSelected = false,
      });

  QuestionBankSubSourceItem.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    sourceId = int.parse(json['source_id'].toString());
    sourceName = json['source_name'];
    subSourceName = json['sub_source_name'];
    isSelected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['source_id'] = sourceId;
    data['source_name'] = sourceName;
    data['sub_source_name'] = subSourceName;
    data['isSelected'] = isSelected;
    return data;
  }
}
