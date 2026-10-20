import 'package:class_compass/helper/price_converter.dart';

class QuizSubmitResponseModel {
  bool? status;
  String? message;
  Data? data;

  QuizSubmitResponseModel({this.status, this.message, this.data});

  QuizSubmitResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? message;
  int? quizId;
  String? resultVisibility;
  int? attemptId;
  double? totalScore;
  double? negativeMarks;
  int? correctAnswers;
  int? incorrectAnswers;
  int? skippedQuestions;
  int? questionCount;
  double? passMark;
  String? isPassed;
  int? position;

  Data(
      {this.message,
        this.quizId,
        this.resultVisibility,
        this.attemptId,
        this.totalScore,
        this.negativeMarks,
        this.correctAnswers,
        this.incorrectAnswers,
        this.skippedQuestions,
        this.questionCount,
        this.passMark,
        this.isPassed,
        this.position});

  Data.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    quizId = json['quiz_id'];
    resultVisibility = json['result_visibility'];
    attemptId = json['attempt_id'];
    totalScore = PriceConverter.parseAmount(json['total_score']);
    negativeMarks = PriceConverter.parseAmount(json['negative_marks']);
    correctAnswers = json['correct_answers'];
    incorrectAnswers = json['incorrect_answers'];
    skippedQuestions = json['skipped_questions'];
    questionCount = json['question_count'];
    passMark = PriceConverter.parseAmount(json['pass_mark']);
    isPassed = json['is_passed'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['quiz_id'] = quizId;
    data['result_visibility'] = resultVisibility;
    data['attempt_id'] = attemptId;
    data['total_score'] = totalScore;
    data['negative_marks'] = negativeMarks;
    data['correct_answers'] = correctAnswers;
    data['incorrect_answers'] = incorrectAnswers;
    data['skipped_questions'] = skippedQuestions;
    data['question_count'] = questionCount;
    data['pass_mark'] = passMark;
    data['is_passed'] = isPassed;
    data['position'] = position;
    return data;
  }
}
