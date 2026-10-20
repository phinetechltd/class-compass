
class HostelMemberItem {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? status;
  String? userStatus;
  String? roll;
  String? className;
  String? sectionName;

  HostelMemberItem(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.image,
        this.userStatus,
        this.roll,
        this.className,
        this.sectionName});

  HostelMemberItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    status = json['status'];
    userStatus = json['user_status'];
    roll = json['roll'];
    className = json['class_name'];
    sectionName = json['section_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['image'] = image;
    data['status'] = status;

    data['user_status'] = userStatus;
    data['roll'] = roll;
    data['class_name'] = className;
    data['section_name'] = sectionName;
    return data;
  }
}
