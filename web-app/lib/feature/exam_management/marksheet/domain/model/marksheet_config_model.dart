

import 'package:class_compass/helper/price_converter.dart';

class MarkSheetConfigItem {
  int? id;
  String? name;
  int? signatureId;
  String? signatureImage;
  String? teacherSignatureId;
  String? teacherSignatureImage;
  String? headerLogo;
  String? stampImage;
  String? borderDesign;
  String? watermark;
  int? status;

  MarkSheetConfigItem(
      {this.id,
        this.name,
        this.signatureId,
        this.signatureImage,
        this.teacherSignatureId,
        this.teacherSignatureImage,
        this.headerLogo,
        this.stampImage,
        this.borderDesign,
        this.watermark,
        this.status});

  MarkSheetConfigItem.fromJson(Map<String, dynamic> json) {
    id = PriceConverter.parseInt(json['id']);
    name = json['name'];
    signatureId = PriceConverter.parseInt(json['signature_id']);
    signatureImage = json['signature_image'];
    teacherSignatureId = json['teacher_signature_id'].toString();
    teacherSignatureImage = json['teacher_signature_image'];
    headerLogo = json['header_logo'];
    stampImage = json['stamp_image'];
    borderDesign = json['border_design'];
    watermark = json['watermark'];
    status = PriceConverter.parseInt(json['status']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['signature_id'] = signatureId;
    data['signature_image'] = signatureImage;
    data['teacher_signature_id'] = teacherSignatureId;
    data['teacher_signature_image'] = teacherSignatureImage;
    data['header_logo'] = headerLogo;
    data['stamp_image'] = stampImage;
    data['border_design'] = borderDesign;
    data['watermark'] = watermark;
    data['status'] = status;
    return data;
  }
}

