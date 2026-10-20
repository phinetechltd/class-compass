import 'package:flutter/cupertino.dart';
import 'package:class_compass/feature/course_management/course_category/domain/model/course_category_model.dart';
import 'package:class_compass/helper/price_converter.dart';


class CourseModel {
  bool? status;
  String? message;
  Data? data;


  CourseModel({this.status, this.message, this.data,});

  CourseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] is Map ? Data.fromJson(json['data']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? currentPage;
  List<CourseItem>? data;
  int? total;

  Data(
      {this.currentPage,
        this.data,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <CourseItem>[];
      json['data'].forEach((v) {
        data!.add(CourseItem.fromJson(v));
      });
    }

    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    return data;
  }
}

class CourseItem {
  int? id;
  String? categoryName;
  String? title;
  String? slug;
  String? image;
  String? videoType;
  String? videoUrl;
  String? embeddedUrl;
  String? uploadedVideoPath;
  String? status;
  String? publishDate;
  String? type;
  String? paymentType;
  String? invoiceTitle;
  double? regularPrice;
  double? offerPrice;
  int? repeatCount;
  int? fakeEnrolledStudents;
  int? totalClasses;
  int? totalNotes;
  int? totalExams;
  String? paymentDuration;
  int? totalCycles;
  int? isInfinity;
  int? isAutoGenerateInvoice;
  String? description;
  String? classRoutineImage;
  int? totalView;
  int? totalEnrolled;
  int? createdBy;
  String? authorName;
  String? authorImage;
  String? createdAt;
  CourseCategoryItem? courseCategory;
  Author? author;
  TextEditingController? discountPriceController;
  bool isSelected = false;

  CourseItem(
      {this.id,
        this.categoryName,
        this.title,
        this.slug,
        this.image,
        this.videoType,
        this.videoUrl,
        this.embeddedUrl,
        this.uploadedVideoPath,
        this.status,
        this.publishDate,
        this.type,
        this.paymentType,
        this.invoiceTitle,
        this.regularPrice,
        this.offerPrice,
        this.repeatCount,
        this.fakeEnrolledStudents,
        this.totalClasses,
        this.totalNotes,
        this.totalExams,
        this.paymentDuration,
        this.totalCycles,
        this.isInfinity,
        this.isAutoGenerateInvoice,
        this.description,
        this.classRoutineImage,
        this.totalView,
        this.totalEnrolled,
        this.createdBy,
        this.authorName,
        this.authorImage,
        this.createdAt,
        this.courseCategory,
        this.author,
        this.discountPriceController,
        this.isSelected = false,
      });

  CourseItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    title = json['title'];
    slug = json['slug'];
    image = json['image'];
    videoType = json['video_type'];
    videoUrl = json['video_url'];
    embeddedUrl = json['embedded_url'];
    uploadedVideoPath = json['uploaded_video_path'];
    status = json['status'];
    publishDate = json['publish_date'];
    type = json['type'];
    paymentType = json['payment_type'];
    invoiceTitle = json['invoice_title'];
    regularPrice = PriceConverter.parseAmount(json['regular_price']);
    offerPrice = PriceConverter.parseAmount(json['offer_price']);
    repeatCount = PriceConverter.parseInt(json['repeat_count']);
    fakeEnrolledStudents = PriceConverter.parseInt(json['fake_enrolled_students']);
    totalClasses = PriceConverter.parseInt(json['total_classes']);
    totalNotes = PriceConverter.parseInt(json['total_notes']);
    totalExams = PriceConverter.parseInt(json['total_exams']);
    paymentDuration = json['payment_duration'];
    totalCycles = PriceConverter.parseInt(json['total_cycles']);
    isInfinity = PriceConverter.parseInt(json['is_infinity']);
    isAutoGenerateInvoice = PriceConverter.parseInt(json['is_auto_generate_invoice']);
    description = json['description'];
    classRoutineImage = json['class_routine_image'];
    totalView = PriceConverter.parseInt(json['total_view']);
    totalEnrolled = PriceConverter.parseInt(json['total_enrolled']);
    createdBy = PriceConverter.parseInt(json['created_by']);
    authorName = json['author_name'];
    authorImage = json['author_image'];
    createdAt = json['created_at'];
    courseCategory = json['course_category'] is Map ? CourseCategoryItem.fromJson(json['course_category'])
        : null;
    author = json['author'] is Map ? Author.fromJson(json['author']) : null;
    discountPriceController = TextEditingController(text: "0");
    isSelected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category_name'] = categoryName;
    data['title'] = title;
    data['slug'] = slug;
    data['image'] = image;
    data['video_type'] = videoType;
    data['video_url'] = videoUrl;
    data['embedded_url'] = embeddedUrl;
    data['uploaded_video_path'] = uploadedVideoPath;
    data['status'] = status;
    data['publish_date'] = publishDate;
    data['type'] = type;
    data['payment_type'] = paymentType;
    data['invoice_title'] = invoiceTitle;
    data['regular_price'] = regularPrice;
    data['offer_price'] = offerPrice;
    data['repeat_count'] = repeatCount;
    data['fake_enrolled_students'] = fakeEnrolledStudents;
    data['total_classes'] = totalClasses;
    data['total_notes'] = totalNotes;
    data['total_exams'] = totalExams;
    data['payment_duration'] = paymentDuration;
    data['total_cycles'] = totalCycles;
    data['is_infinity'] = isInfinity;
    data['is_auto_generate_invoice'] = isAutoGenerateInvoice;
    data['description'] = description;
    data['class_routine_image'] = classRoutineImage;
    data['total_view'] = totalView;
    data['total_enrolled'] = totalEnrolled;
    data['created_by'] = createdBy;
    data['author_name'] = authorName;
    data['author_image'] = authorImage;
    data['created_at'] = createdAt;
    data['offer_price'] = offerPrice;
    data['regular_price'] = regularPrice;
    data['discount_price'] = discountPriceController?.text;
    data['is_auto_generate_invoice'] = isAutoGenerateInvoice;
    if (courseCategory != null) {
      data['course_category'] = courseCategory!.toJson();
    }
    if (author != null) {
      data['author'] = author!.toJson();
    }
    data['discount_price_controller'] = discountPriceController?.text;
    data['is_selected'] = isSelected;
    return data;
  }
}


class Author {
  int? id;
  String? firstName;

  Author({this.id, this.firstName});

  Author.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = firstName;
    return data;
  }
}
