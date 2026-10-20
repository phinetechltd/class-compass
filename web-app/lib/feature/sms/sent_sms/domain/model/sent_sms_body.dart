class SentSmsBody {
  String? userType;
  String? body;
  List<Users>? users;

  SentSmsBody({this.userType, this.body, this.users});

  SentSmsBody.fromJson(Map<String, dynamic> json) {
    userType = json['user_type'];
    body = json['body'];
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_type'] = userType;
    data['body'] = body;
    if (users != null) {
      data['users'] = users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  int? userId;
  String? mobileNumber;

  Users({this.userId, this.mobileNumber});

  Users.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    mobileNumber = json['mobile_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['mobile_number'] = mobileNumber;
    return data;
  }
}
