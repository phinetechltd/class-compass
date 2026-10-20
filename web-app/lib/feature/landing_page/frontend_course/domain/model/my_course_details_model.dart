import 'package:class_compass/helper/price_converter.dart';

class MyCourseDetailsModel {
  bool? status;
  String? message;
  Courses? data;

  MyCourseDetailsModel({this.status, this.message, this.data});

  MyCourseDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] is Map ? Courses.fromJson(json['data']) : null;
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

class Courses {
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
  double? courseRegularPrice;
  double? courseOfferPrice;
  int? courseRepeatCount;
  int? courseFakeEnrolledStudents;
  int? courseTotalClasses;
  int? courseTotalNotes;
  int? courseTotalExams;
  String? coursePaymentDuration;
  int? courseTotalCycles;
  int? courseIsInfinity;
  int? courseIsAutoGenerateInvoice;
  int? courseTotalView;
  int? courseTotalEnrolled;
  int? courseCreatedBy;
  List<CourseChapters>? courseChapters;
  List<ZoomMeetings>? zoomMeetings;
  List<CourseFaqs>? courseFaqs;

  Courses(
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
        this.courseTotalView,
        this.courseTotalEnrolled,
        this.courseCreatedBy,
        this.zoomMeetings,
        this.courseChapters,
        this.courseFaqs
      });

  Courses.fromJson(Map<String, dynamic> json) {
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
    courseRegularPrice = PriceConverter.parseAmount(json['course_regular_price']);
    courseOfferPrice = PriceConverter.parseAmount(json['course_offer_price']);
    courseRepeatCount = PriceConverter.parseInt(json['course_repeat_count']);
    courseFakeEnrolledStudents = PriceConverter.parseInt(json['course_fake_enrolled_students']);
    courseTotalClasses = PriceConverter.parseInt(json['course_total_classes']);
    courseTotalNotes = PriceConverter.parseInt(json['course_total_notes']);
    courseTotalExams = PriceConverter.parseInt(json['course_total_exams']);
    coursePaymentDuration = json['course_payment_duration'];
    courseTotalCycles = PriceConverter.parseInt(json['course_total_cycles']);
    courseIsInfinity = PriceConverter.parseInt(json['course_is_infinity']);
    courseIsAutoGenerateInvoice = PriceConverter.parseInt(json['course_is_auto_generate_invoice']);
    courseTotalView = PriceConverter.parseInt(json['course_total_view']);
    courseTotalEnrolled = PriceConverter.parseInt(json['course_total_enrolled']);
    courseCreatedBy = PriceConverter.parseInt(json['course_created_by']);
    if (json['zoom_meetings'] != null) {
      zoomMeetings = <ZoomMeetings>[];
      json['zoom_meetings'].forEach((v) {
        zoomMeetings!.add(ZoomMeetings.fromJson(v));
      });
    }
    if (json['course_chapters'] != null) {
      courseChapters = <CourseChapters>[];
      json['course_chapters'].forEach((v) {
        courseChapters!.add(CourseChapters.fromJson(v));
      });
    }
    if (json['course_faqs'] != null) {
      courseFaqs = <CourseFaqs>[];
      json['course_faqs'].forEach((v) {
        courseFaqs!.add(CourseFaqs.fromJson(v));
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
    data['course_total_view'] = courseTotalView;
    data['course_total_enrolled'] = courseTotalEnrolled;
    data['course_created_by'] = courseCreatedBy;
    if (zoomMeetings != null) {
      data['zoom_meetings'] =
          zoomMeetings!.map((v) => v.toJson()).toList();
    }
    if (courseChapters != null) {
      data['course_chapters'] =
          courseChapters!.map((v) => v.toJson()).toList();
    }
    if (courseFaqs != null) {
      data['course_faqs'] =
          courseFaqs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CourseFaqs {
  int? id;
  int? courseId;
  String? question;
  String? answer;

  CourseFaqs({this.id, this.courseId, this.question, this.answer});

  CourseFaqs.fromJson(Map<String, dynamic> json) {
    id = PriceConverter.parseInt(json['id']);
    courseId = PriceConverter.parseInt(json['course_id']);
    question = json['question'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['course_id'] = courseId;
    data['question'] = question;
    data['answer'] = answer;
    return data;
  }
}

class CourseChapters {
  int? chapterId;
  String? chapterTitle;
  String? chapterDescription;
  List<Contents>? contents;

  CourseChapters(
      {this.chapterId,
        this.chapterTitle,
        this.chapterDescription,
        this.contents});

  CourseChapters.fromJson(Map<String, dynamic> json) {
    chapterId = PriceConverter.parseInt(json['chapter_id']);
    chapterTitle = json['chapter_title'];
    chapterDescription = json['chapter_description'];
    if (json['contents'] != null) {
      contents = <Contents>[];
      json['contents'].forEach((v) {
        contents!.add(Contents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chapter_id'] = chapterId;
    data['chapter_title'] = chapterTitle;
    data['chapter_description'] = chapterDescription;
    if (contents != null) {
      data['contents'] = contents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Contents {
  int? contentId;
  String? type;
  int? typeId;
  int? serial;
  String? title;
  String? description;
  String? guidelines;
  bool? showDescriptionOnCoursePage;
  String? quizType;
  List<int>? questionIds;
  String? startTime;
  String? endTime;
  int? timeLimitValue;
  String? timeLimitUnit;
  String? onExpiry;
  double? marksPerQuestion;
  double? negativeMarksPerWrongAnswer;
  double? passMark;
  int? attemptsAllowed;
  bool? enableNegativeMarking;
  String? resultVisibility;
  int? layoutPages;
  bool? shuffleQuestions;
  bool? shuffleOptions;
  String? accessType;
  String? accessPassword;
  String? status;
  List<QuizAttempts>? quizAttempts;
  String? thumbnailImage;
  String? videoType;
  String? videoUrl;
  String? uploadedVideoPath;
  List<Attachments>? attachments;
  String? documentFile;
  int? isScheduled;
  String? scheduledAt;
  int? playbackHours;
  int? playbackMinutes;
  int? playbackSeconds;
  String? visibility;
  String? password;
  int? priority;
  int? createdBy;
  bool? isSelected;


  Contents(
      {this.contentId,
        this.type,
        this.typeId,
        this.serial,
        this.title,
        this.description,
        this.guidelines,
        this.showDescriptionOnCoursePage,
        this.quizType,
        this.questionIds,
        this.startTime,
        this.endTime,
        this.timeLimitValue,
        this.timeLimitUnit,
        this.onExpiry,
        this.marksPerQuestion,
        this.negativeMarksPerWrongAnswer,
        this.passMark,
        this.attemptsAllowed,
        this.enableNegativeMarking,
        this.resultVisibility,
        this.layoutPages,
        this.shuffleQuestions,
        this.shuffleOptions,
        this.accessType,
        this.accessPassword,
        this.status,
        this.quizAttempts,
        this.thumbnailImage,
        this.videoType,
        this.videoUrl,
        this.uploadedVideoPath,
        this.attachments,
        this.documentFile,
        this.isScheduled,
        this.scheduledAt,
        this.playbackHours,
        this.playbackMinutes,
        this.playbackSeconds,
        this.visibility,
        this.password,
        this.priority,
        this.createdBy,
        this.isSelected = false
      });

  Contents.fromJson(Map<String, dynamic> json) {
    contentId = PriceConverter.parseInt(json['content_id']);
  type = json['type'];
  typeId = PriceConverter.parseInt(json['type_id']);
  serial = PriceConverter.parseInt(json['serial']);
  title = json['title'];
  description = json['description'];
  guidelines = json['guidelines'];
  showDescriptionOnCoursePage = json['show_description_on_course_page'];
  quizType = json['quiz_type'];
  questionIds = (json['question_ids'] as List?)?.cast<int>() ?? [];
  startTime = json['start_time'];
  endTime = json['end_time'];
  timeLimitValue = PriceConverter.parseInt(json['time_limit_value']);
  timeLimitUnit = json['time_limit_unit'];
  onExpiry = json['on_expiry'];
  marksPerQuestion = PriceConverter.parseAmount(json['marks_per_question']);
  negativeMarksPerWrongAnswer = PriceConverter.parseAmount(json['negative_marks_per_wrong_answer']);
  passMark = PriceConverter.parseAmount(json['pass_mark']);
  attemptsAllowed = PriceConverter.parseInt(json['attempts_allowed']);
  enableNegativeMarking = json['enable_negative_marking'];
  resultVisibility = json['result_visibility'];
  layoutPages = PriceConverter.parseInt(json['layout_pages']);
  shuffleQuestions = json['shuffle_questions'];
  shuffleOptions = json['shuffle_options'];
  accessType = json['access_type'];
  accessPassword = json['access_password'];
  status = json['status'];
  if (json['quiz_attempts'] != null) {
    quizAttempts = <QuizAttempts>[];
    json['quiz_attempts'].forEach((v) {
      quizAttempts!.add(QuizAttempts.fromJson(v));
    });
  }
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
  isScheduled = PriceConverter.parseInt(json['is_scheduled']);
  scheduledAt = json['scheduled_at'];
  playbackHours = PriceConverter.parseInt(json['playback_hours']);
  playbackMinutes = PriceConverter.parseInt(json['playback_minutes']);
  playbackSeconds = PriceConverter.parseInt(json['playback_seconds']);
  visibility = json['visibility'];
  password = json['password'];
  priority = PriceConverter.parseInt(json['priority']);
  createdBy = PriceConverter.parseInt(json['created_by']);
    isSelected =  false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};data['content_id'] = contentId;
    data['type'] = type;
    data['type_id'] = typeId;
    data['serial'] = serial;
    data['title'] = title;
    data['description'] = description;
    data['guidelines'] = guidelines;
    data['show_description_on_course_page'] = showDescriptionOnCoursePage;
    data['quiz_type'] = quizType;
    data['question_ids'] = questionIds;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['time_limit_value'] = timeLimitValue;
    data['time_limit_unit'] = timeLimitUnit;
    data['on_expiry'] = onExpiry;
    data['marks_per_question'] = marksPerQuestion;
    data['negative_marks_per_wrong_answer'] = negativeMarksPerWrongAnswer;
    data['pass_mark'] = passMark;
    data['attempts_allowed'] = attemptsAllowed;
    data['enable_negative_marking'] = enableNegativeMarking;
    data['result_visibility'] = resultVisibility;
    data['layout_pages'] = layoutPages;
    data['shuffle_questions'] = shuffleQuestions;
    data['shuffle_options'] = shuffleOptions;
    data['access_type'] = accessType;
    data['access_password'] = accessPassword;
    data['status'] = status;
    if (quizAttempts != null) {
      data['quiz_attempts'] =
          quizAttempts!.map((v) => v.toJson()).toList();
    }
    data['thumbnail_image'] = thumbnailImage;
    data['video_type'] = videoType;
    data['video_url'] = videoUrl;
    data['uploaded_video_path'] = uploadedVideoPath;
    if (attachments != null) {
      data['attachments'] = attachments!.map((v) => v.toJson()).toList();
    }
    data['document_file'] = documentFile;
    data['is_scheduled'] = isScheduled;
    data['scheduled_at'] = scheduledAt;
    data['playback_hours'] = playbackHours;
    data['playback_minutes'] = playbackMinutes;
    data['playback_seconds'] = playbackSeconds;
    data['visibility'] = visibility;
    data['password'] = password;
    data['priority'] = priority;
    data['created_by'] = createdBy;
    data['is_selected'] = isSelected;
    return data;
  }
}

class QuizAttempts {
  int? attemptId;
  int? studentId;
  int? attemptScore;
  String? startedAt;
  String? submittedAt;
  String? attemptStatus;
  ResultSummary? resultSummary;

  QuizAttempts(
      {this.attemptId,
        this.studentId,
        this.attemptScore,
        this.startedAt,
        this.submittedAt,
        this.attemptStatus,
        this.resultSummary
        });

  QuizAttempts.fromJson(Map<String, dynamic> json) {
    attemptId = PriceConverter.parseInt(json['attempt_id']);
    studentId = PriceConverter.parseInt(json['student_id']);
    attemptScore = PriceConverter.parseInt(json['attempt_score']);
    startedAt = json['started_at'];
    submittedAt = json['submitted_at'];
    attemptStatus = json['attempt_status'];
    resultSummary = json['result_summary'] is Map ? ResultSummary.fromJson(json['result_summary'])
        : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['attempt_id'] = attemptId;
    data['student_id'] = studentId;
    data['attempt_score'] = attemptScore;
    data['started_at'] = startedAt;
    data['submitted_at'] = submittedAt;
    data['attempt_status'] = attemptStatus;
    if (resultSummary != null) {
      data['result_summary'] = resultSummary!.toJson();
    }

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
    size = PriceConverter.parseInt(json['size']);
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


class ResultSummary {
  int? resultId;
  int? quizAttemptId;
  double? score;
  double? negativeMarks;
  String? gradeDisplay;
  int? positionRank;
  int? totalQuestion;
  int? correctQuestion;
  int? wrongQuestion;
  int? skippedQuestion;
  String? isPassed;

  ResultSummary(
      {this.resultId,
        this.quizAttemptId,
        this.score,
        this.negativeMarks,
        this.gradeDisplay,
        this.positionRank,
        this.totalQuestion,
        this.correctQuestion,
        this.wrongQuestion,
        this.skippedQuestion,
        this.isPassed});

  ResultSummary.fromJson(Map<String, dynamic> json) {
    resultId = PriceConverter.parseInt(json['result_id']);
    quizAttemptId = PriceConverter.parseInt(json['quiz_attempt_id']);
    score = PriceConverter.parseAmount(json['score']);
    negativeMarks =PriceConverter.parseAmount( json['negative_marks']);
    gradeDisplay = json['grade_display'];
    positionRank = PriceConverter.parseInt(json['position_rank']);
    totalQuestion = PriceConverter.parseInt(json['total_question']);
    correctQuestion = PriceConverter.parseInt(json['correct_question']);
    wrongQuestion = PriceConverter.parseInt(json['wrong_question']);
    skippedQuestion = PriceConverter.parseInt(json['skipped_question']);
    isPassed = json['is_passed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result_id'] = resultId;
    data['quiz_attempt_id'] = quizAttemptId;
    data['score'] = score;
    data['negative_marks'] = negativeMarks;
    data['grade_display'] = gradeDisplay;
    data['position_rank'] = positionRank;
    data['total_question'] = totalQuestion;
    data['correct_question'] = correctQuestion;
    data['wrong_question'] = wrongQuestion;
    data['skipped_question'] = skippedQuestion;
    data['is_passed'] = isPassed;
    return data;
  }
}

class ZoomMeetings {
  int? meetingId;
  String? topic;
  String? startTime;
  int? duration;
  String? password;
  String? joinUrl;

  ZoomMeetings(
      {this.meetingId,
        this.topic,
        this.startTime,
        this.duration,
        this.password,
        this.joinUrl});

  ZoomMeetings.fromJson(Map<String, dynamic> json) {
    meetingId = PriceConverter.parseInt(json['meeting_id']);
    topic = json['topic'];
    startTime = json['start_time'];
    duration = PriceConverter.parseInt(json['duration']);
    password = json['password'];
    joinUrl = json['join_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['meeting_id'] = meetingId;
    data['topic'] = topic;
    data['start_time'] = startTime;
    data['duration'] = duration;
    data['password'] = password;
    data['join_url'] = joinUrl;
    return data;
  }
}
