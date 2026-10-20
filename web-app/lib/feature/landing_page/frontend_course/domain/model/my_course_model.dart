import 'package:class_compass/helper/price_converter.dart';

class MyCourseModel {
  bool? status;
  String? message;
  List<MyCourseItem>? data;

  MyCourseModel({this.status, this.message, this.data});

  MyCourseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <MyCourseItem>[];
      json['data'].forEach((v) {
        data!.add(MyCourseItem.fromJson(v));
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

class MyCourseItem {
  int? id;
  int? instituteId;
  int? studentId;
  int? courseId;
  String? enrollmentType;
  String? enrollmentDate;
  String? subscriptionStart;
  String? subscriptionEnd;
  double? amountPaid;
  String? status;
  CourseItem? course;

  MyCourseItem(
      {this.id,
        this.instituteId,
        this.studentId,
        this.courseId,
        this.enrollmentType,
        this.enrollmentDate,
        this.subscriptionStart,
        this.subscriptionEnd,
        this.amountPaid,
        this.status,
        this.course});

  MyCourseItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instituteId = json['institute_id'];
    studentId = json['student_id'];
    courseId = json['course_id'];
    enrollmentType = json['enrollment_type'];
    enrollmentDate = json['enrollment_date'];
    subscriptionStart = json['subscription_start'];
    subscriptionEnd = json['subscription_end'];
    amountPaid = PriceConverter.parseAmount(json['amount_paid']);
    status = json['status'];
    course =
    json['course'] is Map ? CourseItem.fromJson(json['course']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['institute_id'] = instituteId;
    data['student_id'] = studentId;
    data['course_id'] = courseId;
    data['enrollment_type'] = enrollmentType;
    data['enrollment_date'] = enrollmentDate;
    data['subscription_start'] = subscriptionStart;
    data['subscription_end'] = subscriptionEnd;
    data['amount_paid'] = amountPaid;
    data['status'] = status;
    if (course != null) {
      data['course'] = course!.toJson();
    }
    return data;
  }
}

class CourseItem {
  int? id;
  int? courseCategoryId;
  String? title;
  String? slug;
  String? image;
  String? videoType;
  String? videoUrl;
  String? embeddedUrl;
  String? uploadedVideoPath;
  String? status;
  String? type;
  String? paymentType;
  String? invoiceTitle;
  int? fakeEnrolledStudents;
  int? totalClasses;
  int? totalNotes;
  int? totalExams;
  double? regularPrice;
  double? offerPrice;
  String? description;
  Author? author;

  CourseItem(
      {this.id,
        this.courseCategoryId,
        this.title,
        this.slug,
        this.image,
        this.videoType,
        this.videoUrl,
        this.embeddedUrl,
        this.uploadedVideoPath,
        this.status,
        this.type,
        this.paymentType,
        this.invoiceTitle,
        this.fakeEnrolledStudents,
        this.totalClasses,
        this.totalNotes,
        this.totalExams,
        this.regularPrice,
        this.offerPrice,
        this.description,
        this.author,
      });

  CourseItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseCategoryId = PriceConverter.parseInt(json['course_category_id']);
    title = json['title'];
    slug = json['slug'];
    image = json['image'];
    videoType = json['video_type'].toString();
    videoUrl = json['video_url'].toString();
    embeddedUrl = json['embedded_url'];
    uploadedVideoPath = json['uploaded_video_path'];
    status = json['status'].toString();
    type = json['type'].toString();
    paymentType = json['payment_type'].toString();
    invoiceTitle = json['invoice_title'];
    fakeEnrolledStudents = PriceConverter.parseInt(json['fake_enrolled_students']);
    totalClasses = PriceConverter.parseInt(json['total_classes']);
    totalNotes = PriceConverter.parseInt(json['total_notes']);
    totalExams = PriceConverter.parseInt(json['total_exams']);
    regularPrice = PriceConverter.parseAmount(json['regular_price']);
    offerPrice = PriceConverter.parseAmount(json['offer_price']);
    description = json['description'];
    author = json['author'] is Map ? Author.fromJson(json['author']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['course_category_id'] = courseCategoryId;
    data['title'] = title;
    data['slug'] = slug;
    data['image'] = image;
    data['video_type'] = videoType;
    data['video_url'] = videoUrl;
    data['embedded_url'] = embeddedUrl;
    data['uploaded_video_path'] = uploadedVideoPath;
    data['status'] = status;
    data['type'] = type;
    data['payment_type'] = paymentType;
    data['invoice_title'] = invoiceTitle;
    data['fake_enrolled_students'] = fakeEnrolledStudents;
    data['total_classes'] = totalClasses;
    data['total_notes'] = totalNotes;
    data['total_exams'] = totalExams;
    data['regular_price'] = regularPrice;
    data['offer_price'] = offerPrice;
    data['description'] = description;
    if (author != null) {
      data['author'] = author!.toJson();
    }
    return data;
  }
}
class Author {
  int? id;
  String? firstName;
  String? lastName;

  Author({this.id, this.firstName, this.lastName});

  Author.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    return data;
  }
}
