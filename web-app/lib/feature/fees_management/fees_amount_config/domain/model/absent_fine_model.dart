import 'package:class_compass/helper/price_converter.dart';

class AbsentFineItem {
  int? id;
  double? feeAmount;
  ClassItem? classItem;
  Period? period;

  AbsentFineItem(
      {this.id,
        this.feeAmount,
        this.classItem,
        this.period});

  AbsentFineItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    feeAmount = PriceConverter.parseAmount(json['fee_amount']);
    classItem = json['class'] is Map ? ClassItem.fromJson(json['class'])
        : null;
    period =
    json['period'] is Map ? Period.fromJson(json['period']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fee_amount'] = feeAmount;
    if (classItem != null) {
      data['class'] = classItem!.toJson();
    }
    if (period != null) {
      data['period'] = period!.toJson();
    }
    return data;
  }
}

class ClassItem {
  int? id;
  String? className;

  ClassItem({this.id, this.className});

  ClassItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    className = json['class_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['class_name'] = className;
    return data;
  }
}

class Period {
  int? id;
  String? period;

  Period({this.id, this.period});

  Period.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    period = json['period'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['period'] = period;
    return data;
  }
}
