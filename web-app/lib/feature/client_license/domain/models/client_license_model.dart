import 'package:class_compass/helper/price_converter.dart';

class ClientLicenseItem {
  int? id;
  int? instituteId;
  int? planId;
  String? licenseKey;
  String? status;
  String? issuedAt;
  String? expiresAt;
  int? studentLimit;
  int? branchLimit;
  String? notes;
  String? instituteName;
  String? planName;

  ClientLicenseItem({
    this.id,
    this.instituteId,
    this.planId,
    this.licenseKey,
    this.status,
    this.issuedAt,
    this.expiresAt,
    this.studentLimit,
    this.branchLimit,
    this.notes,
    this.instituteName,
    this.planName,
  });

  ClientLicenseItem.fromJson(Map<String, dynamic> json) {
    id = PriceConverter.parseInt(json['id']);
    instituteId = PriceConverter.parseInt(json['institute_id']);
    planId = json['plan_id'] == null ? null : PriceConverter.parseInt(json['plan_id']);
    licenseKey = json['license_key'];
    status = json['status'];
    issuedAt = _parseDate(json['issued_at']);
    expiresAt = _parseDate(json['expires_at']);
    studentLimit = json['student_limit'] == null ? null : PriceConverter.parseInt(json['student_limit']);
    branchLimit = json['branch_limit'] == null ? null : PriceConverter.parseInt(json['branch_limit']);
    notes = json['notes'];
    instituteName = json['institute_name'];
    planName = json['plan_name'];
  }

  static String? _parseDate(dynamic value) {
    if (value == null) return null;
    final text = value.toString();
    return text.length >= 10 ? text.substring(0, 10) : text;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'institute_id': instituteId,
      'plan_id': planId,
      'license_key': licenseKey,
      'status': status,
      'issued_at': issuedAt,
      'expires_at': expiresAt,
      'student_limit': studentLimit,
      'branch_limit': branchLimit,
      'notes': notes,
    };
  }
}

class ClientLicenseBody {
  int? instituteId;
  int? planId;
  String? licenseKey;
  String? status;
  String? issuedAt;
  String? expiresAt;
  String? studentLimit;
  String? branchLimit;
  String? notes;

  ClientLicenseBody({
    this.instituteId,
    this.planId,
    this.licenseKey,
    this.status,
    this.issuedAt,
    this.expiresAt,
    this.studentLimit,
    this.branchLimit,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'institute_id': instituteId,
      'plan_id': planId,
      'license_key': licenseKey,
      'status': status,
      'issued_at': issuedAt,
      'expires_at': expiresAt,
      'student_limit': studentLimit,
      'branch_limit': branchLimit,
      'notes': notes,
    };
  }
}
