class QuizSubmitBody {
  int? quizId;
  int? attemptId;
  List<Answers>? answers;

  QuizSubmitBody({this.quizId, this.attemptId, this.answers});

  QuizSubmitBody.fromJson(Map<String, dynamic> json) {
    quizId = json['quiz_id'];
    attemptId = json['attempt_id'];
    if (json['answers'] != null) {
      answers = <Answers>[];
      json['answers'].forEach((v) {
        answers!.add(Answers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['quiz_id'] = quizId;
    data['attempt_id'] = attemptId;
    if (answers != null) {
      data['answers'] = answers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Answers {
  int? questionId;
  List<String>? selectedOptions;

  Answers({this.questionId, this.selectedOptions});

  Answers.fromJson(Map<String, dynamic> json) {
    questionId = json['question_id'];
    selectedOptions = json['selected_options'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question_id'] = questionId;
    data['selected_options'] = selectedOptions;
    return data;
  }
}
