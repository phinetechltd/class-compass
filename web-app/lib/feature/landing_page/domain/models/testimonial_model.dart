import 'package:class_compass/helper/price_converter.dart';

class TestimonialModel {
  bool? status;
  String? message;
  List<TestimonialItem>? data;


  TestimonialModel({this.status, this.message, this.data});

  TestimonialModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <TestimonialItem>[];
      json['data'].forEach((v) {
        data!.add(TestimonialItem.fromJson(v));
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

class TestimonialItem {
  int? id;
  int? userId;
  String? description;
  int? status;
  User? user;

  TestimonialItem(
      {this.id,
        this.userId,
        this.description,
        this.status,
        this.user});

  TestimonialItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = PriceConverter.parseInt(json['user_id']);
    description = json['description'];
    status = PriceConverter.parseInt(json['status']);
    user = json['user'] is Map ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['description'] = description;
    data['status'] = status;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? image;

  User({this.id, this.name, this.phone, this.email, this.image});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['image'] = image;
    return data;
  }
}
