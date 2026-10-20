import 'package:flutter/widgets.dart';

class FeeDateConfigSearchModel {
  bool? status;
  String? message;
  List<FeeDateConfigSearchItem>? data;

  FeeDateConfigSearchModel({this.status, this.message, this.data});

  FeeDateConfigSearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <FeeDateConfigSearchItem>[];
      json['data'].forEach((v) {
        data!.add(FeeDateConfigSearchItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FeeDateConfigSearchItem {
  int? id;
  int? feeMapId;
  int? feeSubHeadId;
  String? name;
  TextEditingController? payableDateController;
  TextEditingController? fineActiveDateController;

  FeeDateConfigSearchItem(
      {this.id,
        this.feeMapId,
        this.feeSubHeadId,
        this.name,
        this.payableDateController,
        this.fineActiveDateController
      });

  FeeDateConfigSearchItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    feeMapId = json['fee_map_id'];
    feeSubHeadId = json['fee_sub_head_id'];
    name = json['name'];
    payableDateController = TextEditingController(text: json['payable_date']);
    fineActiveDateController = TextEditingController(text: json['fine_active_date']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fee_map_id'] = feeMapId;
    data['fee_sub_head_id'] = feeSubHeadId;
    data['name'] = name;
    data['payable_date'] = payableDateController?.text;
    data['fine_active_date'] = fineActiveDateController?.text;
    return data;
  }
}
