import 'package:class_compass/feature/academic_configuration/section/domain/model/section_model.dart';
import 'package:class_compass/feature/academic_configuration/session/domain/models/session_model.dart';
import 'package:class_compass/helper/price_converter.dart';

import '../../../../academic_configuration/class/domain/model/class_model.dart';
import '../../../../students_information/student/domain/model/student_model.dart';

class PaidReportModel {
  bool? status;
  String? message;
  List<PaidReportInfo>? data;

  PaidReportModel({this.status, this.message, this.data});

  PaidReportModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PaidReportInfo>[];
      json['data'].forEach((v) {
        data!.add(PaidReportInfo.fromJson(v));
      });
    }
  }

}

class PaidReportInfo {
  int? id;
  String? invoiceId;
  String? invoiceDate;
  int? sessionId;
  String? tcAmount;
  String? attendanceFine;
  String? quizFine;
  String? labFine;
  String? totalPayable;
  String? totalPaid;
  String? totalDue;
  String? note;
  String? createdAt;
  StudentItem? student;
  List<PaidDetailsInfo>? details;

  PaidReportInfo(
      {this.id,
        this.invoiceId,
        this.invoiceDate,
        this.sessionId,
        this.tcAmount,
        this.attendanceFine,
        this.quizFine,
        this.labFine,
        this.totalPayable,
        this.totalPaid,
        this.totalDue,
        this.note,
        this.createdAt,
        this.student,
        this.details});

  PaidReportInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    invoiceId = json['invoice_id'];
    invoiceDate = json['invoice_date'];
    sessionId = json['session_id'];
    tcAmount = json['tc_amount'];
    attendanceFine = json['attendance_fine'];
    quizFine = json['quiz_fine'];
    labFine = json['lab_fine'];
    totalPayable = json['total_payable'];
    totalPaid = json['total_paid'];
    totalDue = json['total_due'];
    note = json['note'];
    createdAt = json['created_at'];
    student =
    json['student'] is Map ? StudentItem.fromJson(json['student']) : null;
    if (json['details'] != null) {
      details = <PaidDetailsInfo>[];
      json['details'].forEach((v) {
        details!.add(PaidDetailsInfo.fromJson(v));
      });
    }
  }
}



class StudentSession {
  int? id;
  String? roll;
  String? qrCode;
  ClassItem? classItem;
  SectionItem? section;
  SessionItem? session;

  StudentSession(
      {this.id,
        this.roll,
        this.qrCode,
        this.classItem,
        this.section,
        this.session});

  StudentSession.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roll = json['roll'].toString();
    qrCode = json['qr_code'];
    classItem = json['class'] is Map ? ClassItem.fromJson(json['class'])
        : null;
    section =
    json['section'] is Map ? SectionItem.fromJson(json['section']) : null;
    session =
    json['session'] is Map ? SessionItem.fromJson(json['session']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['roll'] = roll;
    data['qr_code'] = qrCode;
    if (classItem != null) {
      data['class_item'] = classItem!.toJson();
    }
    if (section != null) {
      data['section'] = section!.toJson();
    }
    if (session != null) {
      data['session'] = session!.toJson();
    }
    return data;
  }
}


class PaidDetailsInfo {
  int? id;
  String? totalDue;
  String? totalPayable;
  String? totalPaid;
  String? waiver;
  String? finePayable;
  String? feePayable;
  String? feeAndFinePayable;
  String? feeAndFinePaid;
  String? previousDuePayable;
  String? previousDuePaid;
  FeeHead? feeHead;

  PaidDetailsInfo(
      {this.id,
        this.totalDue,
        this.totalPayable,
        this.totalPaid,
        this.waiver,
        this.finePayable,
        this.feePayable,
        this.feeAndFinePayable,
        this.feeAndFinePaid,
        this.previousDuePayable,
        this.previousDuePaid,
        this.feeHead,
      });

  PaidDetailsInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totalDue = json['total_due'];
    totalPayable = json['total_payable'];
    totalPaid = json['total_paid'];
    waiver = json['waiver'];
    finePayable = json['fine_payable'];
    feePayable = json['fee_payable'];
    feeAndFinePayable = json['fee_and_fine_payable'];
    feeAndFinePaid = json['fee_and_fine_paid'];
    previousDuePayable = json['previous_due_payable'];
    previousDuePaid = json['previous_due_paid'];
    feeHead = json['fee_head'] is Map ? FeeHead.fromJson(json['fee_head'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['total_due'] = totalDue;
    data['total_payable'] = totalPayable;
    data['total_paid'] = totalPaid;
    data['waiver'] = waiver;
    data['fine_payable'] = finePayable;
    data['fee_payable'] = feePayable;
    data['fee_and_fine_payable'] = feeAndFinePayable;
    data['fee_and_fine_paid'] = feeAndFinePaid;
    data['previous_due_payable'] = previousDuePayable;
    data['previous_due_paid'] = previousDuePaid;
    if (feeHead != null) {
      data['fee_head'] = feeHead!.toJson();
    }
    return data;
  }
}

class FeeHead {
  int? id;
  String? name;
  int? serial;
  List<FeeSubHeads>? feeSubHeads;

  FeeHead(
      {this.id,
        this.name,
        this.serial,
        this.feeSubHeads});

  FeeHead.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    serial = PriceConverter.parseInt(json['serial']);
    if (json['fee_sub_heads'] != null) {
      feeSubHeads = <FeeSubHeads>[];
      json['fee_sub_heads'].forEach((v) {
        feeSubHeads!.add(FeeSubHeads.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['serial'] = serial;
    if (feeSubHeads != null) {
      data['fee_sub_heads'] = feeSubHeads!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FeeSubHeads {
  int? id;
  String? name;
  int? serial;

  FeeSubHeads(
      {this.id,
        this.name,
        this.serial,
      });

  FeeSubHeads.fromJson(Map<String, dynamic> json) {
    id = PriceConverter.parseInt(json['id']);
    name = json['name'];
    serial = json['serial'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['serial'] = serial;
    return data;
  }
}
