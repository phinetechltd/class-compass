import 'package:class_compass/helper/price_converter.dart';

class QuizResultModel {
  bool? status;
  String? message;
  Data? data;

  QuizResultModel({this.status, this.message, this.data});

  QuizResultModel.fromJson(Map<String, dynamic> json) {
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
  QuizInfo? quizInfo;
  AnswerBreakdown? answerBreakdown;
  MarksSummary? marksSummary;
  RankingPositions? rankingPositions;
  List<Questions>? questions;

  Data(
      {this.quizInfo,
        this.answerBreakdown,
        this.marksSummary,
        this.rankingPositions,
        this.questions});

  Data.fromJson(Map<String, dynamic> json) {
    quizInfo = json['quiz_info'] is Map ? QuizInfo.fromJson(json['quiz_info']) : null;
    answerBreakdown = json['answer_breakdown'] is Map ? AnswerBreakdown.fromJson(json['answer_breakdown']) : null;
    marksSummary = json['marks_summary'] is Map ? MarksSummary.fromJson(json['marks_summary']) : null;
    rankingPositions = json['ranking_positions'] is Map ? RankingPositions.fromJson(json['ranking_positions']) : null;
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(Questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (quizInfo != null) {
      data['quiz_info'] = quizInfo!.toJson();
    }
    if (answerBreakdown != null) {
      data['answer_breakdown'] = answerBreakdown!.toJson();
    }
    if (marksSummary != null) {
      data['marks_summary'] = marksSummary!.toJson();
    }
    if (rankingPositions != null) {
      data['ranking_positions'] = rankingPositions!.toJson();
    }
    if (questions != null) {
      data['questions'] = questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QuizInfo {
  int? quizId;
  String? quizTitle;
  int? quizTotalQuestions;
  int? quizTimeLimitValue;
  String? quizTimeLimitUnit;
  int? courseId;
  String? courseTitle;
  int? chapterId;
  String? chapterTitle;
  String? description;
  String? type;

  QuizInfo(
      {this.quizId,
        this.quizTitle,
        this.quizTotalQuestions,
        this.quizTimeLimitValue,
        this.quizTimeLimitUnit,
        this.courseId,
        this.courseTitle,
        this.chapterId,
        this.chapterTitle,
        this.description,
        this.type});

  QuizInfo.fromJson(Map<String, dynamic> json) {
    quizId = json['quiz_id'];
    quizTitle = json['quiz_title'];
    quizTotalQuestions = json['quiz_total_questions'];
    quizTimeLimitValue = json['quiz_time_limit_value'];
    quizTimeLimitUnit = json['quiz_time_limit_unit'];
    courseId = json['course_id'];
    courseTitle = json['course_title'];
    chapterId = json['chapter_id'];
    chapterTitle = json['chapter_title'];
    description = json['description'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['quiz_id'] = quizId;
    data['quiz_title'] = quizTitle;
    data['quiz_total_questions'] = quizTotalQuestions;
    data['quiz_time_limit_value'] = quizTimeLimitValue;
    data['quiz_time_limit_unit'] = quizTimeLimitUnit;
    data['course_id'] = courseId;
    data['course_title'] = courseTitle;
    data['chapter_id'] = chapterId;
    data['chapter_title'] = chapterTitle;
    data['description'] = description;
    data['type'] = type;
    return data;
  }
}


class AnswerBreakdown {
  int? totalQuestions;
  int? correctAnswers;
  int? wrongAnswers;
  int? unansweredQuestions;

  AnswerBreakdown(
      {this.totalQuestions,
        this.correctAnswers,
        this.wrongAnswers,
        this.unansweredQuestions});

  AnswerBreakdown.fromJson(Map<String, dynamic> json) {
    totalQuestions = json['total_questions'];
    correctAnswers = json['correct_answers'];
    wrongAnswers = json['wrong_answers'];
    unansweredQuestions = json['unanswered_questions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_questions'] = totalQuestions;
    data['correct_answers'] = correctAnswers;
    data['wrong_answers'] = wrongAnswers;
    data['unanswered_questions'] = unansweredQuestions;
    return data;
  }
}

class MarksSummary {
  double? marksFromCorrectAnswers;
  double? negativeMarks;
  double? totalObtainedMarks;
  double? highestMarksInQuiz;
  double? fullMarks;

  MarksSummary(
      {this.marksFromCorrectAnswers,
        this.negativeMarks,
        this.totalObtainedMarks,
        this.highestMarksInQuiz,
        this.fullMarks});

  MarksSummary.fromJson(Map<String, dynamic> json) {
    marksFromCorrectAnswers = PriceConverter.parseAmount(json['marks_from_correct_answers']);
    negativeMarks = PriceConverter.parseAmount(json['negative_marks']);
    totalObtainedMarks = PriceConverter.parseAmount(json['total_obtained_marks']);
    highestMarksInQuiz = PriceConverter.parseAmount(json['highest_marks_in_quiz']);
    fullMarks = PriceConverter.parseAmount(json['full_marks']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['marks_from_correct_answers'] = marksFromCorrectAnswers;
    data['negative_marks'] = negativeMarks;
    data['total_obtained_marks'] = totalObtainedMarks;
    data['highest_marks_in_quiz'] = highestMarksInQuiz;
    data['full_marks'] = fullMarks;
    return data;
  }
}

class RankingPositions {
  int? position;

  RankingPositions({this.position});

  RankingPositions.fromJson(Map<String, dynamic> json) {
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['position'] = position;
    return data;
  }
}

class Questions {
  int? questionId;
  String? questionText;
  String? questionType;
  List<String>? questionOptions;
  List<String>? userAnswer;
  List<String>? correctAnswer;
  String? isCorrect;
  int? marksAwarded;
  String? explanation;
  bool? isSelected;

  Questions(
      {this.questionId,
        this.questionText,
        this.questionType,
        this.questionOptions,
        this.userAnswer,
        this.correctAnswer,
        this.isCorrect,
        this.marksAwarded,
        this.explanation,
        this.isSelected = false
      });

  Questions.fromJson(Map<String, dynamic> json) {
    questionId = json['question_id'];
    questionText = json['question_text'];
    questionType = json['question_type'];
    questionOptions = json['question_options'].cast<String>();
    userAnswer = json['user_answer'].cast<String>();
    correctAnswer = json['correct_answer'].cast<String>();
    isCorrect = json['is_correct'];
    marksAwarded = json['marks_awarded'];
    explanation = json['explanation'];
    isSelected = json['isSelected'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question_id'] = questionId;
    data['question_text'] = questionText;
    data['question_type'] = questionType;
    data['question_options'] = questionOptions;
    data['user_answer'] = userAnswer;
    data['correct_answer'] = correctAnswer;
    data['is_correct'] = isCorrect;
    data['marks_awarded'] = marksAwarded;
    data['explanation'] = explanation;
    data['isSelected'] = isSelected;
    return data;
  }
}
