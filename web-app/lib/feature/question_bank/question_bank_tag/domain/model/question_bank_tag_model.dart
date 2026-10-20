

import 'package:class_compass/helper/price_converter.dart';

class QuestionBankTagItem {
  int? id;
  String? tagName;
  int? status;
  bool? isSelected;

  QuestionBankTagItem({this.id, this.tagName, this.status, this.isSelected});

  QuestionBankTagItem.fromJson(Map<String, dynamic> json) {
    id = PriceConverter.parseInt(json['id']);
    tagName = json['tag_name'];
    status = PriceConverter.parseInt(json['status']);
    isSelected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tag_name'] = tagName;
    data['status'] = status;
    return data;
  }
}

