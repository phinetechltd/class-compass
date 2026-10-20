class UserListForSmsModel {
  bool? status;
  String? message;
  List<UserItemForSms>? data;

  UserListForSmsModel({this.status, this.message, this.data});

  UserListForSmsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <UserItemForSms>[];
      json['data'].forEach((v) {
        data!.add(UserItemForSms.fromJson(v));
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

class UserItemForSms {
  int? id;
  String? name;
  String? phone;
  String? userType;
  bool? selected;


  UserItemForSms({this.id, this.name, this.phone, this.userType, this.selected});

  UserItemForSms.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    userType = json['user_type'];
    selected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['user_type'] = userType;
    data['selected'] = selected;
    return data;
  }
}
