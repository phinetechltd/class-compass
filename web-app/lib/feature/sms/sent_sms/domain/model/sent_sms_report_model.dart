
class SmsReportItem {
  int? id;
  String? receiver;
  String? userType;
  String? message;
  String? createdAt;

  SmsReportItem(
      {this.id,
        this.receiver,
        this.userType,
        this.message,
        this.createdAt,});

  SmsReportItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    receiver = json['receiver'];
    userType = json['user_type'];
    message = json['message'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['receiver'] = receiver;
    data['user_type'] = userType;
    data['message'] = message;
    data['created_at'] = createdAt;
    return data;
  }
}

