class StaffAttendanceReportModel {
  bool? status;
  String? message;
  List<StaffAttendanceReportItem>? data;

  StaffAttendanceReportModel({this.status, this.message, this.data});

  StaffAttendanceReportModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <StaffAttendanceReportItem>[];
      json['data'].forEach((v) {
        data!.add(StaffAttendanceReportItem.fromJson(v));
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

class StaffAttendanceReportItem {
  int? userId;
  String? name;
  String? role;
  int? present;
  int? absent;
  int? onLeave;
  List<Logs>? logs;

  StaffAttendanceReportItem(
      {this.userId,
        this.name,
        this.role,
        this.present,
        this.absent,
        this.onLeave,
        this.logs
      });

  StaffAttendanceReportItem.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    role = json['role'];
    present = json['present'];
    absent = json['absent'];
    onLeave = json['on_leave'];
    if (json['logs'] != null) {
      logs = <Logs>[];
      json['logs'].forEach((v) {
        logs!.add(Logs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['name'] = name;
    data['role'] = role;
    data['present'] = present;
    data['absent'] = absent;
    data['on_leave'] = onLeave;
    if (logs != null) {
      data['logs'] = logs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Logs {
  String? date;
  int? attendance;
  String? startTime;
  String? endTime;

  Logs({this.date, this.attendance, this.startTime, this.endTime});

  Logs.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    attendance = json['attendance'];
    startTime = json['start_time'];
    endTime = json['end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['attendance'] = attendance;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    return data;
  }
}