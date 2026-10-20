import 'package:class_compass/helper/price_converter.dart';


class PackageItem {
  int? id;
  String? name;
  String? description;
  int? studentLimit;
  int? branchLimit;
  double? price;
  int? durationDays;
  int? isCustom;
  int? isFree;

  PackageItem(
      {this.id,
        this.name,
        this.description,
        this.studentLimit,
        this.branchLimit,
        this.price,
        this.durationDays,
        this.isCustom,
        this.isFree,
        });

  PackageItem.fromJson(Map<String, dynamic> json) {
    id = PriceConverter.parseInt(json['id']);
    name = json['name'];
    description = json['description'];
    studentLimit = PriceConverter.parseInt(json['student_limit']);
    branchLimit = PriceConverter.parseInt(json['branch_limit']);
    price = double.parse(json['price'].toString());
    durationDays = PriceConverter.parseInt(json['duration_days']);
    isCustom = PriceConverter.parseInt(json['is_custom']);
    isFree = PriceConverter.parseInt(json['is_free']);

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['student_limit'] = studentLimit;
    data['branch_limit'] = branchLimit;
    data['price'] = price;
    data['duration_days'] = durationDays;
    data['is_custom'] = isCustom;
    data['is_free'] = isFree;
    return data;
  }
}

