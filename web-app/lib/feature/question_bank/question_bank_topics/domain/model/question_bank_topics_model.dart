import 'package:class_compass/helper/price_converter.dart';


class QuestionBankTopicsItem {
  int? id;
  int? chapterId;
  String? chapterName;
  String? name;
  int? status;

  QuestionBankTopicsItem(
      {this.id,
        this.chapterId,
        this.chapterName,
        this.name,
        this.status,});

  QuestionBankTopicsItem.fromJson(Map<String, dynamic> json) {
    id = PriceConverter.parseInt(json['id']);
    chapterId = PriceConverter.parseInt(json['chapter_id']);
    chapterName = json['chapter_name'];
    name = json['name'];
    status = PriceConverter.parseInt(json['status']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['chapter_id'] = chapterId;
    data['chapter_name'] = chapterName;
    data['name'] = name;
    data['status'] = status;
    return data;
  }
}

