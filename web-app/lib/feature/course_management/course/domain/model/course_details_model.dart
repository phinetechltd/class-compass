

import 'package:class_compass/feature/zoom_class/domain/model/zoom_class_model.dart';
import 'package:class_compass/helper/price_converter.dart';

class CourseDetailsModel {
  bool? status;
  String? message;
  Data? data;

  CourseDetailsModel({this.status, this.message, this.data});

  CourseDetailsModel.fromJson(Map<String, dynamic> json) {
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
  int? courseId;
  String? courseTitle;
  String? courseSlug;
  String? courseDescription;
  String? courseImage;
  String? courseVideoType;
  String? courseVideoUrl;
  String? courseEmbeddedUrl;
  String? courseUploadedVideoPath;
  String? courseStatus;
  String? coursePublishDate;
  String? courseType;
  String? coursePaymentType;
  String? courseInvoiceTitle;
  String? courseRegularPrice;
  String? courseOfferPrice;
  int? courseRepeatCount;
  int? courseFakeEnrolledStudents;
  int? courseTotalClasses;
  int? courseTotalNotes;
  int? courseTotalExams;
  String? coursePaymentDuration;
  int? courseTotalCycles;
  int? courseIsInfinity;
  int? courseIsAutoGenerateInvoice;
  String? courseClassRoutineImage;
  int? courseTotalView;
  int? courseTotalEnrolled;
  List<CourseChapters>? courseChapters;
  List<ZoomItem>? zoomMeetings;

  Data(
      {this.courseId,
        this.courseTitle,
        this.courseSlug,
        this.courseDescription,
        this.courseImage,
        this.courseVideoType,
        this.courseVideoUrl,
        this.courseEmbeddedUrl,
        this.courseUploadedVideoPath,
        this.courseStatus,
        this.coursePublishDate,
        this.courseType,
        this.coursePaymentType,
        this.courseInvoiceTitle,
        this.courseRegularPrice,
        this.courseOfferPrice,
        this.courseRepeatCount,
        this.courseFakeEnrolledStudents,
        this.courseTotalClasses,
        this.courseTotalNotes,
        this.courseTotalExams,
        this.coursePaymentDuration,
        this.courseTotalCycles,
        this.courseIsInfinity,
        this.courseIsAutoGenerateInvoice,
        this.courseClassRoutineImage,
        this.courseTotalView,
        this.courseTotalEnrolled,
        this.courseChapters,
        this.zoomMeetings,});

  Data.fromJson(Map<String, dynamic> json) {
    courseId = json['course_id'];
    courseTitle = json['course_title'];
    courseSlug = json['course_slug'];
    courseDescription = json['course_description'];
    courseImage = json['course_image'];
    courseVideoType = json['course_video_type'];
    courseVideoUrl = json['course_video_url'];
    courseEmbeddedUrl = json['course_embedded_url'];
    courseUploadedVideoPath = json['course_uploaded_video_path'];
    courseStatus = json['course_status'];
    coursePublishDate = json['course_publish_date'];
    courseType = json['course_type'];
    coursePaymentType = json['course_payment_type'];
    courseInvoiceTitle = json['course_invoice_title'];
    courseRegularPrice = json['course_regular_price'];
    courseOfferPrice = json['course_offer_price'];
    courseRepeatCount = PriceConverter.parseInt(json['course_repeat_count']);
    courseFakeEnrolledStudents = PriceConverter.parseInt(json['course_fake_enrolled_students']);
    courseTotalClasses = PriceConverter.parseInt(json['course_total_classes']);
    courseTotalNotes = PriceConverter.parseInt(json['course_total_notes']);
    courseTotalExams = PriceConverter.parseInt(json['course_total_exams']);
    coursePaymentDuration = json['course_payment_duration'];
    courseTotalCycles = PriceConverter.parseInt(json['course_total_cycles']);
    courseIsInfinity = PriceConverter.parseInt(json['course_is_infinity']);
    courseIsAutoGenerateInvoice = PriceConverter.parseInt(json['course_is_auto_generate_invoice']);
    courseClassRoutineImage = json['course_class_routine_image'];
    courseTotalView = PriceConverter.parseInt(json['course_total_view']);
    courseTotalEnrolled = PriceConverter.parseInt(json['course_total_enrolled']);
    if (json['course_chapters'] != null) {
      courseChapters = <CourseChapters>[];
      json['course_chapters'].forEach((v) {
        courseChapters!.add(CourseChapters.fromJson(v));
      });
    }
    if (json['zoom_meetings'] != null) {
      zoomMeetings = <ZoomItem>[];
      json['zoom_meetings'].forEach((v) {
        zoomMeetings!.add(ZoomItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['course_id'] = courseId;
    data['course_title'] = courseTitle;
    data['course_slug'] = courseSlug;
    data['course_description'] = courseDescription;
    data['course_image'] = courseImage;
    data['course_video_type'] = courseVideoType;
    data['course_video_url'] = courseVideoUrl;
    data['course_embedded_url'] = courseEmbeddedUrl;
    data['course_uploaded_video_path'] = courseUploadedVideoPath;
    data['course_status'] = courseStatus;
    data['course_publish_date'] = coursePublishDate;
    data['course_type'] = courseType;
    data['course_payment_type'] = coursePaymentType;
    data['course_invoice_title'] = courseInvoiceTitle;
    data['course_regular_price'] = courseRegularPrice;
    data['course_offer_price'] = courseOfferPrice;
    data['course_repeat_count'] = courseRepeatCount;
    data['course_fake_enrolled_students'] = courseFakeEnrolledStudents;
    data['course_total_classes'] = courseTotalClasses;
    data['course_total_notes'] = courseTotalNotes;
    data['course_total_exams'] = courseTotalExams;
    data['course_payment_duration'] = coursePaymentDuration;
    data['course_total_cycles'] = courseTotalCycles;
    data['course_is_infinity'] = courseIsInfinity;
    data['course_is_auto_generate_invoice'] = courseIsAutoGenerateInvoice;
    data['course_class_routine_image'] = courseClassRoutineImage;
    data['course_total_view'] = courseTotalView;
    data['course_total_enrolled'] = courseTotalEnrolled;
    if (courseChapters != null) {
      data['course_chapters'] =
          courseChapters!.map((v) => v.toJson()).toList();
    }
    if (zoomMeetings != null) {
      data['zoom_meetings'] =
          zoomMeetings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CourseChapters {
  int? chapterId;
  String? chapterTitle;
  String? chapterDescription;
  List<Contents>? contents;
  int? chapterPriority;


  CourseChapters(
      {this.chapterId,
        this.chapterTitle,
        this.chapterDescription,
        this.contents,
        this.chapterPriority
      });

  CourseChapters.fromJson(Map<String, dynamic> json) {
    chapterId = json['chapter_id'];
    chapterTitle = json['chapter_title'];
    chapterDescription = json['chapter_description'];
    if (json['contents'] != null) {
      contents = <Contents>[];
      json['contents'].forEach((v) {
        contents!.add(Contents.fromJson(v));
      });
    }
    chapterPriority = PriceConverter.parseInt(json['chapter_priority']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chapter_id'] = chapterId;
    data['chapter_title'] = chapterTitle;
    data['chapter_description'] = chapterDescription;
    if (contents != null) {
      data['contents'] = contents!.map((v) => v.toJson()).toList();
    }
    data['chapter_priority'] = chapterPriority;
    return data;
  }
}

class Contents {
  int? contentId;
  String? type;
  int? typeId;
  int? serial;
  String? title;
  String? thumbnailImage;
  String? videoType;
  String? videoUrl;
  String? uploadedVideoPath;
  List<Attachments>? attachments;
  String? documentFile;
  String? description;
  String? guidelines;
  int? isScheduled;
  String? scheduledAt;
  int? playbackHours;
  int? playbackMinutes;
  int? playbackSeconds;
  String? visibility;
  String? password;
  String? status;
  String? accessPassword;
  bool? showDescriptionOnCoursePage;
  String? quizType;
  List<int>? questionIds;
  String? startTime;
  String? endTime;
  bool? hasTimeLimit;
  int? timeLimitValue;
  String? timeLimitUnit;
  String? onExpiry;
  double? marksPerQuestion;
  double? negativeMarksPerWrongAnswer;
  double? passMark;
  int? attemptsAllowed;
  String? resultVisibility;
  int? layoutPages;
  bool? shuffleQuestions;
  bool? shuffleOptions;
  String? accessType;

  Contents(
      {this.contentId,
        this.type,
        this.typeId,
        this.serial,
        this.title,
        this.thumbnailImage,
        this.videoType,
        this.videoUrl,
        this.uploadedVideoPath,
        this.attachments,
        this.documentFile,
        this.description,
        this.guidelines,
        this.isScheduled,
        this.scheduledAt,
        this.playbackHours,
        this.playbackMinutes,
        this.playbackSeconds,
        this.visibility,
        this.password,
        this.status,
        this.accessPassword,
        this.showDescriptionOnCoursePage,
        this.quizType,
        this.questionIds,
        this.startTime,
        this.endTime,
        this.hasTimeLimit,
        this.timeLimitValue,
        this.timeLimitUnit,
        this.onExpiry,
        this.marksPerQuestion,
        this.negativeMarksPerWrongAnswer,
        this.passMark,
        this.attemptsAllowed,
        this.resultVisibility,
        this.layoutPages,
        this.shuffleQuestions,
        this.shuffleOptions,
        this.accessType
      });

  Contents.fromJson(Map<String, dynamic> json) {
    contentId = json['content_id'];
    type = json['type'];
    typeId = PriceConverter.parseInt(json['type_id']);
    serial = PriceConverter.parseInt(json['serial']);
    title = json['title'];
    thumbnailImage = json['thumbnail_image'];
    videoType = json['video_type'];
    videoUrl = json['video_url'];
    uploadedVideoPath = json['uploaded_video_path'];
    if (json['attachments'] != null) {
      attachments = <Attachments>[];
      json['attachments'].forEach((v) {
        attachments!.add(Attachments.fromJson(v));
      });
    }
    documentFile = json['document_file'];
    description = json['description'];
    guidelines = json['guidelines'];
    isScheduled = PriceConverter.parseInt(json['is_scheduled']);
    scheduledAt = json['scheduled_at'];
    playbackHours = PriceConverter.parseInt(json['playback_hours']);
    playbackMinutes = PriceConverter.parseInt(json['playback_minutes']);
    playbackSeconds = PriceConverter.parseInt(json['playback_seconds']);
    visibility = json['visibility'];
    password = json['password'];
    status = json['status'];
    accessPassword = json['access_password'];
    showDescriptionOnCoursePage = json['show_description_on_course_page'];
    quizType = json['quiz_type'];
    if (json['question_ids'] != null) {
      questionIds = json['question_ids'].cast<int>();
    }
    startTime = json['start_time'];
    endTime = json['end_time'];
    hasTimeLimit = json['has_time_limit'];
    timeLimitValue = PriceConverter.parseInt(json['time_limit_value']);
    timeLimitUnit = json['time_limit_unit'];
    onExpiry = json['on_expiry'];
    marksPerQuestion = PriceConverter.parseAmount(json['marks_per_question']);
    negativeMarksPerWrongAnswer = PriceConverter.parseAmount(json['negative_marks_per_wrong_answer']);
    passMark = PriceConverter.parseAmount(json['pass_mark']);
    attemptsAllowed = PriceConverter.parseInt(json['attempts_allowed']);
    resultVisibility = json['result_visibility'];
    layoutPages = PriceConverter.parseInt(json['layout_pages']);
    shuffleQuestions = json['shuffle_questions'];
    shuffleOptions = json['shuffle_options'];
    accessType = json['access_type'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['content_id'] = contentId;
    data['type'] = type;
    data['type_id'] = typeId;
    data['serial'] = serial;
    data['title'] = title;
    data['thumbnail_image'] = thumbnailImage;
    data['video_type'] = videoType;
    data['video_url'] = videoUrl;
    data['uploaded_video_path'] = uploadedVideoPath;
    if (attachments != null) {
      data['attachments'] = attachments!.map((v) => v.toJson()).toList();
    }
    data['document_file'] = documentFile;
    data['description'] = description;
    data['guidelines'] = guidelines;
    data['is_scheduled'] = isScheduled;
    data['scheduled_at'] = scheduledAt;
    data['playback_hours'] = playbackHours;
    data['playback_minutes'] = playbackMinutes;
    data['playback_seconds'] = playbackSeconds;
    data['visibility'] = visibility;
    data['password'] = password;
    data['status'] = status;
    data['access_password'] = accessPassword;
    data['show_description_on_course_page'] = showDescriptionOnCoursePage;
    data['quiz_type'] = quizType;
    if (questionIds != null) {
      data['question_ids'] = questionIds;
    }
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['has_time_limit'] = hasTimeLimit;
    data['time_limit_value'] = timeLimitValue;
    data['time_limit_unit'] = timeLimitUnit;
    data['on_expiry'] = onExpiry;
    data['marks_per_question'] = marksPerQuestion;
    data['negative_marks_per_wrong_answer'] = negativeMarksPerWrongAnswer;
    data['pass_mark'] = passMark;
    data['attempts_allowed'] = attemptsAllowed;
    data['result_visibility'] = resultVisibility;
    data['layout_pages'] = layoutPages;
    data['shuffle_questions'] = shuffleQuestions;
    data['shuffle_options'] = shuffleOptions;
    data['access_type'] = accessType;

    return data;
  }
}
class Attachments {
  String? name;
  String? path;
  String? url;
  String? mime;
  int? size;

  Attachments({this.name, this.path, this.url, this.mime, this.size});

  Attachments.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    path = json['path'];
    url = json['url'];
    mime = json['mime'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['path'] = path;
    data['url'] = url;
    data['mime'] = mime;
    data['size'] = size;
    return data;
  }
}




