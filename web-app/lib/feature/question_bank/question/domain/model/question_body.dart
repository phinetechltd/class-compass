class QuestionBody {
  int? questionBankClassId;
  int? questionBankGroupId;
  int? questionBankSubjectId;
  int? questionBankChapterId;
  int? questionCategoryId;
  String? question;
  String? questionName;
  String? type;
  List<String>? options;
  List<String>? correctAnswer;
  String? explanation;
  List<QuestionYearBody>? questionYear;
  List<int>? types;
  List<int>? levels;
  List<int>? topics;
  List<int>? sources;
  List<int>? subSources;
  List<int>? tags;
  List<int>? session;
  String? sMethod;

  QuestionBody(
      {this.questionBankClassId,
        this.questionBankGroupId,
        this.questionBankSubjectId,
        this.questionBankChapterId,
        this.questionCategoryId,
        this.question,
        this.questionName,
        this.type,
        this.options,
        this.correctAnswer,
        this.explanation,
        this.questionYear,
        this.types,
        this.levels,
        this.topics,
        this.sources,
        this.subSources,
        this.tags,
        this.session,
        this.sMethod
      });

  QuestionBody.fromJson(Map<String, dynamic> json) {
    questionBankClassId = json['question_bank_class_id'];
    questionBankGroupId = json['question_bank_group_id'];
    questionBankSubjectId = json['question_bank_subject_id'];
    questionBankChapterId = json['question_bank_chapter_id'];
    questionCategoryId = json['question_category_id'];
    question = json['question'];
    questionName = json['question_name'];
    type = json['type'];
    options = json['options'].cast<String>();
    correctAnswer = json['correct_answer'].cast<String>();
    explanation = json['explanation'];
    if (json['question_year'] != null) {
      questionYear = <QuestionYearBody>[];
      json['question_year'].forEach((v) {
        questionYear!.add(QuestionYearBody.fromJson(v));
      });
    }
    types = json['types'].cast<int>();
    levels = json['levels'].cast<int>();
    topics = json['topics'].cast<int>();
    sources = json['sources'].cast<int>();
    subSources = json['sub_sources'].cast<int>();
    tags = json['tags'].cast<int>();
    session = json['session'].cast<int>();
    sMethod = json['_method'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question_bank_class_id'] = questionBankClassId;
    data['question_bank_group_id'] = questionBankGroupId;
    data['question_bank_subject_id'] = questionBankSubjectId;
    data['question_bank_chapter_id'] = questionBankChapterId;
    data['question_category_id'] = questionCategoryId;
    data['question'] = question;
    data['question_name'] = questionName;
    data['type'] = type;
    data['options'] = options;
    data['correct_answer'] = correctAnswer;
    data['explanation'] = explanation;
    if (questionYear != null) {
      data['question_year'] =
          questionYear!.map((v) => v.toJson()).toList();
    }
    data['types'] = types;
    data['levels'] = levels;
    data['topics'] = topics;
    data['sources'] = sources;
    data['sub_sources'] = subSources;
    data['tags'] = tags;
    data['session'] = session;
    data['_method'] = sMethod;
    return data;
  }
}

class QuestionYearBody {
  String? year;
  List<Board>? board;

  QuestionYearBody({this.year, this.board});

  QuestionYearBody.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    if (json['board'] != null) {
      board = <Board>[];
      json['board'].forEach((v) {
        board!.add(Board.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['year'] = year;
    if (board != null) {
      data['board'] = board!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Board {
  String? board;
  String? desc;

  Board({this.board, this.desc});

  Board.fromJson(Map<String, dynamic> json) {
    board = json['board'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['board'] = board;
    data['desc'] = desc;
    return data;
  }
}
