class GroupModel {
  bool? status;
  String? message;
  Data? data;

  GroupModel({this.status, this.message, this.data});

  GroupModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] is Map ? Data.fromJson(json['data']) : null;
  }

}

class Data {
  int? currentPage;
  List<GroupItem>? data;
  int? total;

  Data(
      {this.currentPage,
        this.data,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <GroupItem>[];
      json['data'].forEach((v) {
        data!.add(GroupItem.fromJson(v));
      });
    }
    total = json['total'];
  }

}

class GroupItem {
  int? id;
  String? groupName;
  String? createdAt;
  String? updatedAt;

  GroupItem({this.id, this.groupName, this.createdAt, this.updatedAt});

  GroupItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupName = json['group_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  //toJson
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['group_name'] = groupName;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

}


