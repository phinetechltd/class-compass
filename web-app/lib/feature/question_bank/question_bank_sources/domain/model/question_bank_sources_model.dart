import 'package:class_compass/helper/price_converter.dart';



class QuestionBankSourcesItem {
  int? id;
  String? sourceName;
  int? status;
  bool? isSelected;

  QuestionBankSourcesItem({this.id, this.sourceName, this.status, this.isSelected});

  QuestionBankSourcesItem.fromJson(Map<String, dynamic> json) {
    id = PriceConverter.parseInt(json['id']);
    sourceName = json['source_name'];
    status = PriceConverter.parseInt(json['status']);
    isSelected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['source_name'] = sourceName;
    data['status'] = status;
    data['isSelected'] = isSelected;
    return data;
  }
}

