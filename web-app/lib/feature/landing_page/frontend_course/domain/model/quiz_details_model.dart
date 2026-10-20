import 'package:class_compass/helper/price_converter.dart';

class QuizDetailsModel {
  bool? status;
  String? message;
  Data? data;

  QuizDetailsModel({this.status, this.message, this.data});

  QuizDetailsModel.fromJson(Map<String, dynamic> json) {
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
  Quiz? quiz;
  List<Questions>? questions;

  Data({this.quiz, this.questions});

  Data.fromJson(Map<String, dynamic> json) {
    quiz = json['quiz'] is Map ? Quiz.fromJson(json['quiz']) : null;
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(Questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (quiz != null) {
      data['quiz'] = quiz!.toJson();
    }
    if (questions != null) {
      data['questions'] = questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Quiz {
  int? id;
  int? instituteId;
  int? courseId;
  int? chapterId;
  int? createdBy;
  int? priority;
  String? title;
  String? description;
  String? guidelines;
  bool? showDescriptionOnCoursePage;
  String? type;
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
  bool? enableNegativeMarking;
  String? resultVisibility;
  int? layoutPages;
  bool? shuffleQuestions;
  bool? shuffleOptions;
  String? accessType;
  String? accessPassword;
  String? status;
  String? createdAt;
  String? updatedAt;

  Quiz(
      {this.id,
        this.instituteId,
        this.courseId,
        this.chapterId,
        this.createdBy,
        this.priority,
        this.title,
        this.description,
        this.guidelines,
        this.showDescriptionOnCoursePage,
        this.type,
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
        this.enableNegativeMarking,
        this.resultVisibility,
        this.layoutPages,
        this.shuffleQuestions,
        this.shuffleOptions,
        this.accessType,
        this.accessPassword,
        this.status,
        this.createdAt,
        this.updatedAt});

  Quiz.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instituteId = json['institute_id'];
    courseId = json['course_id'];
    chapterId = json['chapter_id'];
    createdBy = json['created_by'];
    priority = json['priority'];
    title = json['title'];
    description = json['description'];
    guidelines = json['guidelines'];
    showDescriptionOnCoursePage = json['show_description_on_course_page'];
    type = json['type'];
    (json['question_ids'] as List?)?.cast<int>();
    startTime = json['start_time'];
    endTime = json['end_time'];
    hasTimeLimit = json['has_time_limit'];
    timeLimitValue = json['time_limit_value'];
    timeLimitUnit = json['time_limit_unit'];
    onExpiry = json['on_expiry'];
    marksPerQuestion = PriceConverter.parseAmount(json['marks_per_question']);
    negativeMarksPerWrongAnswer = PriceConverter.parseAmount(json['negative_marks_per_wrong_answer']);
    passMark = PriceConverter.parseAmount(json['pass_mark']);
    attemptsAllowed = PriceConverter.parseInt(json['attempts_allowed']);
    enableNegativeMarking = json['enable_negative_marking'];
    resultVisibility = json['result_visibility'];
    layoutPages = json['layout_pages'];
    shuffleQuestions = json['shuffle_questions'];
    shuffleOptions = json['shuffle_options'];
    accessType = json['access_type'];
    accessPassword = json['access_password'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['institute_id'] = instituteId;
    data['course_id'] = courseId;
    data['chapter_id'] = chapterId;
    data['created_by'] = createdBy;
    data['priority'] = priority;
    data['title'] = title;
    data['description'] = description;
    data['guidelines'] = guidelines;
    data['show_description_on_course_page'] = showDescriptionOnCoursePage;
    data['type'] = type;
    data['question_ids'] = questionIds;
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
    data['enable_negative_marking'] = enableNegativeMarking;
    data['result_visibility'] = resultVisibility;
    data['layout_pages'] = layoutPages;
    data['shuffle_questions'] = shuffleQuestions;
    data['shuffle_options'] = shuffleOptions;
    data['access_type'] = accessType;
    data['access_password'] = accessPassword;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Questions {
  int? id;
  String? type;
  String? question;
  List<Options>? options;
  List<String>? correctAnswer;
  String? explanation;
  bool isSelected = false;

  Questions({this.id, this.type, this.question, this.options,  this.correctAnswer, this.explanation, this.isSelected = false});

  Questions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    question = json['question'];
    if (json['options'] != null) {
      options = (json['options'] as List).map((e) => e is String ? Options(option: e) : Options.fromJson(e)).toList();
    }
    correctAnswer = json['correct_answer'] != null ? List<String>.from(json['correct_answer']) : null;
    explanation = json['explanation'];
    isSelected = json['isSelected'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['question'] = question;
    data['options'] = options?.map((e) => e.toJson()).toList();
    data['correct_answer'] = correctAnswer;
    data['explanation'] = explanation;
    data['isSelected'] = isSelected;
    return data;
  }
}

class Options {
  String? option;
  bool isSelected;
  bool isCorrect;

  Options({this.option, this.isCorrect = false, this.isSelected = false});

  factory Options.fromJson(Map<String, dynamic> json) {
    return Options(
      option: json['option'] ?? json['text'],
      isCorrect: json['is_correct'],
      isSelected: json['isSelected'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'option': option,
      'isSelected': isSelected,
      'is_correct': isCorrect,
    };
  }
}
