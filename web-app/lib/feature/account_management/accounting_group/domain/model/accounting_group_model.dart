class AccountingGroupModel {
  bool? status;
  String? message;
  Data? data;

  AccountingGroupModel({this.status, this.message, this.data});

  AccountingGroupModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] is Map ? Data.fromJson(json['data']) : null;
  }

}

class Data {
  int? currentPage;
  List<AccountingGroupItem>? data;
  int? total;

  Data({this.currentPage, this.data, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <AccountingGroupItem>[];
      json['data'].forEach((v) {
        data!.add(AccountingGroupItem.fromJson(v));
      });
    }
    total = json['total'];
  }

}

class AccountingGroupItem {
  int? id;
  String? accountingCategoryId;
  String? name;
  AccountingCategory? accountingCategory;

  AccountingGroupItem(
      {this.id,
        this.accountingCategoryId,
        this.name,
        this.accountingCategory});

  AccountingGroupItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountingCategoryId = json['accounting_category_id'].toString();
    name = json['name'];
    accountingCategory = json['accounting_category'] is Map ? AccountingCategory.fromJson(json['accounting_category'])
        : null;
  }
}
class AccountingCategory {
  int? id;
  String? name;

  AccountingCategory({this.id, this.name});

  AccountingCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
