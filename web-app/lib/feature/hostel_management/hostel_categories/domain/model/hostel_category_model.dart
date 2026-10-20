
import 'package:class_compass/helper/price_converter.dart';

class HostelCategoryItem {
  int? id;
  int? hostelId;
  String? standard;
  double? hostelFee;
  String? note;
  String? createdAt;
  String? updatedAt;
  String? hostelName;
  String? type;
  String? address;

  HostelCategoryItem(
      {this.id,
        this.hostelId,
        this.standard,
        this.hostelFee,
        this.note,
        this.createdAt,
        this.updatedAt,
        this.hostelName,
        this.type,
        this.address});

  HostelCategoryItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hostelId = PriceConverter.parseInt(json['hostel_id']);
    standard = json['standard'];
    hostelFee = PriceConverter.parseAmount(json['hostel_fee']);
    note = json['note'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    hostelName = json['hostel_name'];
    type = json['type'].toString();
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['hostel_id'] = hostelId;
    data['standard'] = standard;
    data['hostel_fee'] = hostelFee;
    data['note'] = note;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['hostel_name'] = hostelName;
    data['type'] = type;
    data['address'] = address;
    return data;
  }
}
