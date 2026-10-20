class QuizSettingBody {
  int? courseId;
  int? chapterId;
  String? title;
  String? description;
  String? guidelines;
  bool? showDescriptionOnCoursePage;
  String? type;
  String? startTime;
  String? endTime;
  bool? hasTimeLimit;
  String? timeLimitValue;
  String? timeLimitUnit;
  String? onExpiry;
  String? marksPerQuestion;
  String? negativeMarksPerWrongAnswer;
  String? passMark;
  String? attemptsAllowed;
  bool? enableNegativeMarking;
  String? resultVisibility;
  String? layoutPages;
  bool? shuffleQuestions;
  bool? shuffleOptions;
  String? accessType;
  String? accessPassword;
  String? sMethod;

  QuizSettingBody(
      {this.courseId,
        this.chapterId,
        this.title,
        this.description,
        this.guidelines,
        this.showDescriptionOnCoursePage,
        this.type,
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
        this.sMethod
      });

  QuizSettingBody.fromJson(Map<String, dynamic> json) {
    courseId = json['course_id'];
    chapterId = json['chapter_id'];
    title = json['title'];
    description = json['description'];
    guidelines = json['guidelines'];
    showDescriptionOnCoursePage = json['show_description_on_course_page'];
    type = json['type'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    hasTimeLimit = json['has_time_limit'];
    timeLimitValue = json['time_limit_value'];
    timeLimitUnit = json['time_limit_unit'];
    onExpiry = json['on_expiry'];
    marksPerQuestion = json['marks_per_question'];
    negativeMarksPerWrongAnswer = json['negative_marks_per_wrong_answer'];
    passMark = json['pass_mark'];
    attemptsAllowed = json['attempts_allowed'];
    enableNegativeMarking = json['enable_negative_marking'];
    resultVisibility = json['result_visibility'];
    layoutPages = json['layout_pages'];
    shuffleQuestions = json['shuffle_questions'];
    shuffleOptions = json['shuffle_options'];
    accessType = json['access_type'];
    accessPassword = json['access_password'];
    sMethod = json['_method'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    void put(String key, dynamic value) {
      if (value == null) return;
      if (value is String && value.toLowerCase() == 'null') return;
      data[key] = value;
    }


    put('course_id', courseId);
    put('chapter_id', chapterId);
    put('title', title);
    put('description', description);
    put('guidelines', guidelines);
    put('show_description_on_course_page', showDescriptionOnCoursePage);
    put('type', type);
    data['start_time'] = (startTime is String && startTime?.toLowerCase() == 'null') ? null : startTime;
    data['end_time'] = (endTime is String && endTime?.toLowerCase() == 'null') ? null : endTime;
    put('has_time_limit', hasTimeLimit);
    put('time_limit_value', timeLimitValue);
    put('time_limit_unit', timeLimitUnit);
    put('on_expiry', onExpiry);
    put('marks_per_question', marksPerQuestion);
    put('negative_marks_per_wrong_answer', negativeMarksPerWrongAnswer);
    put('pass_mark', passMark);
    put('attempts_allowed', attemptsAllowed);
    put('enable_negative_marking', enableNegativeMarking);
    put('result_visibility', resultVisibility);
    put('layout_pages', layoutPages);
    put('shuffle_questions', shuffleQuestions);
    put('shuffle_options', shuffleOptions);
    put('access_type', accessType);
    put('access_password', accessPassword);
    put('_method', sMethod);

    return data;
  }

}
