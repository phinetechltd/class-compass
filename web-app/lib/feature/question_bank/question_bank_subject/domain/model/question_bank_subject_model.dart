

import 'package:class_compass/helper/price_converter.dart';

class QuestionBankSubjectItem {
  int? id;
  int? classId;
  int? groupId;
  String? className;
  String? groupName;
  String? name;
  int? categoryId;
  String? categoryName;


  QuestionBankSubjectItem(
      {this.id,
        this.classId,
        this.groupId,
        this.className,
        this.groupName,
        this.name,
        this.categoryId,
        this.categoryName
      });

  QuestionBankSubjectItem.fromJson(Map<String, dynamic> json) {
    id = PriceConverter.parseInt(json['id']);
    classId = PriceConverter.parseInt(json['class_id']);
    groupId = PriceConverter.parseInt(json['group_id']);
    className = json['class_name'];
    groupName = json['group_name'];
    name = json['name'];
    categoryId = PriceConverter.parseInt(json['question_category_id']);
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['class_id'] = classId;
    data['group_id'] = groupId;
    data['class_name'] = className;
    data['group_name'] = groupName;
    data['name'] = name;
    data['question_category_id'] = categoryId;
    data['category_name'] = categoryName;
    return data;
  }
}

