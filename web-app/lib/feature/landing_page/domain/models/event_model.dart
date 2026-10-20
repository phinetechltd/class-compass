class EventFrontEndModel {
  bool? status;
  String? message;
  List<EventItem>? data;


  EventFrontEndModel({this.status, this.message, this.data});

  EventFrontEndModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <EventItem>[];
      json['data'].forEach((v) {
        data!.add(EventItem.fromJson(v));
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

class EventItem {
  int? id;
  String? startDate;
  String? endDate;
  String? name;
  String? image;
  String? details;
  String? location;
  String? createdAt;

  EventItem(
      {this.id,
        this.startDate,
        this.endDate,
        this.name,
        this.image,
        this.details,
        this.location,
        this.createdAt});

  EventItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    name = json['name'];
    image = json['image'];
    details = json['details'];
    location = json['location'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['name'] = name;
    data['image'] = image;
    data['details'] = details;
    data['location'] = location;
    data['created_at'] = createdAt;
    return data;
  }
}
