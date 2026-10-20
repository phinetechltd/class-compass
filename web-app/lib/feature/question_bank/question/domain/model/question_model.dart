

import 'package:class_compass/feature/question_bank/question_bank_chapter/domain/model/question_bank_chapter_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_class/domain/model/question_bank_class_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_group/domain/model/question_bank_group_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_level/domain/model/question_bank_level_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_sources/domain/model/question_bank_sources_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_sub_sources/domain/model/question_bank_sub_sources_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_subject/domain/model/question_bank_subject_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_topics/domain/model/question_bank_topics_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_types/domain/model/question_bank_types_model.dart';
import 'package:class_compass/feature/question_bank/question_category/domain/model/question_category_model.dart';
import 'package:class_compass/helper/price_converter.dart';

class QuestionModel {
  bool? status;
  String? message;
  Data? data;

  QuestionModel({this.status, this.message, this.data,});

  QuestionModel.fromJson(Map<String, dynamic> json) {
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
  List<QuestionItem>? data;
  int? total;

  Data(
      {this.currentPage,
        this.data,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = PriceConverter.parseInt(json['current_page']);
    if (json['data'] != null) {
      data = <QuestionItem>[];
      json['data'].forEach((v) {
        data!.add(QuestionItem.fromJson(v));
      });
    }
    total = PriceConverter.parseInt(json['total']);
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

class QuestionItem {
  int? id;
  int? questionBankClassId;
  int? questionBankGroupId;
  int? questionBankSubjectId;
  int? questionBankChapterId;
  int? questionCategoryId;
  String? type;
  String? questionName;
  String? question;
  List<String>? options;
  List<String>? correctAnswer;
  String? explanation;
  double? marks;
  double? negativeMarks;
  String? negativeMarksType;
  String? imageFile;
  String? price;
  List<QuestionYear>? questionYear;
  String? language;
  String? status;
  String? createdAt;
  QuestionCategoryItem? questionCategory;
  QuestionBankClassItem? classItem;
  List<Session>? session;
  QuestionBankGroupItem? group;
  QuestionBankSubjectItem? subject;
  QuestionBankChapterItem? chapter;
  List<QuestionBankTypesItem>? types;
  List<QuestionBankLevelItem>? levels;
  List<QuestionBankTopicsItem>? topics;
  List<QuestionBankSourcesItem>? sources;
  List<QuestionBankSubSourceItem>? subSources;
  List<Tags>? tags;
  bool? isSelected = false;
  bool? selectForQuiz= false;

  QuestionItem(
      {this.id,
        this.questionBankClassId,
        this.questionBankGroupId,
        this.questionBankSubjectId,
        this.questionBankChapterId,
        this.questionCategoryId,
        this.type,
        this.questionName,
        this.question,
        this.options,
        this.correctAnswer,
        this.explanation,
        this.marks,
        this.negativeMarks,
        this.negativeMarksType,
        this.imageFile,
        this.price,
        this.questionYear,
        this.language,
        this.status,
        this.createdAt,
        this.questionCategory,
        this.classItem,
        this.session,
        this.group,
        this.subject,
        this.chapter,
        this.types,
        this.levels,
        this.topics,
        this.sources,
        this.subSources,
        this.tags,
        this.isSelected,
        this.selectForQuiz,
      });

  QuestionItem.fromJson(Map<String, dynamic> json) {
    id = PriceConverter.parseInt(json['id']);
    questionBankClassId = PriceConverter.parseInt(json['question_bank_class_id']);
    questionBankGroupId = PriceConverter.parseInt(json['question_bank_group_id']);
    questionBankSubjectId = PriceConverter.parseInt(json['question_bank_subject_id']);
    questionBankChapterId = PriceConverter.parseInt(json['question_bank_chapter_id']);
    questionCategoryId = PriceConverter.parseInt(json['question_category_id']);
    type = json['type'];
    questionName = json['question_name'];
    question = json['question'];
    options = (json['options'] as List?)?.whereType<String>().toList() ?? [];
    correctAnswer = (json['correct_answer'] as List?)
        ?.map((e) => e.toString())
        .toList() ?? [];

    explanation = json['explanation'];
    marks = PriceConverter.parseAmount(json['marks']);
    negativeMarks = PriceConverter.parseAmount(json['negative_marks']);
    negativeMarksType = json['negative_marks_type'];
    imageFile = json['image_file'];
    price = json['price'];
    if (json['question_year'] != null) {
      questionYear = <QuestionYear>[];
      json['question_year'].forEach((v) {
        questionYear!.add(QuestionYear.fromJson(v));
      });
    }
    language = json['language'];
    status = json['status'].toString();
    createdAt = json['created_at'];
    questionCategory = json['question_category'] is Map ? QuestionCategoryItem.fromJson(json['question_category'])
        : null;
    classItem = json['class'] is Map ? QuestionBankClassItem.fromJson(json['class'])
        : null;
    if (json['session'] != null) {
      session = <Session>[];
      json['session'].forEach((v) {
        session!.add(Session.fromJson(v));
      });
    }
    group = json['group'] is Map ? QuestionBankGroupItem.fromJson(json['group'])
        : null;
    subject = json['subject'] is Map ? QuestionBankSubjectItem.fromJson(json['subject'])
        : null;
    chapter =
    json['chapter'] is Map ? QuestionBankChapterItem.fromJson(json['chapter']) : null;
    if (json['types'] != null) {
      types = <QuestionBankTypesItem>[];
      json['types'].forEach((v) {
        types!.add(QuestionBankTypesItem.fromJson(v));
      });
    }
    if (json['levels'] != null) {
      levels = <QuestionBankLevelItem>[];
      json['levels'].forEach((v) {
        levels!.add(QuestionBankLevelItem.fromJson(v));
      });
    }
    if (json['topics'] != null) {
      topics = <QuestionBankTopicsItem>[];
      json['topics'].forEach((v) {
        topics!.add(QuestionBankTopicsItem.fromJson(v));
      });
    }
    if (json['sources'] != null) {
      sources = <QuestionBankSourcesItem>[];
      json['sources'].forEach((v) {
        sources!.add(QuestionBankSourcesItem.fromJson(v));
      });
    }
    if (json['sub_sources'] != null) {
      subSources = <QuestionBankSubSourceItem>[];
      json['sub_sources'].forEach((v) {
        subSources!.add(QuestionBankSubSourceItem.fromJson(v));
      });
    }
    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) {
        tags!.add(Tags.fromJson(v));
      });
    }
    isSelected = json['is_selected'];
    selectForQuiz = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['question_bank_class_id'] = questionBankClassId;
    data['question_bank_group_id'] = questionBankGroupId;
    data['question_bank_subject_id'] = questionBankSubjectId;
    data['question_bank_chapter_id'] = questionBankChapterId;
    data['question_category_id'] = questionCategoryId;
    data['type'] = type;
    data['question_name'] = questionName;
    data['question'] = question;
    data['options'] = options;
    data['correct_answer'] = correctAnswer?.map((e) => e.toString()).toList();
    data['explanation'] = explanation;
    data['marks'] = marks;
    data['negative_marks'] = negativeMarks;
    data['negative_marks_type'] = negativeMarksType;
    data['image_file'] = imageFile;
    data['price'] = price;
    if (questionYear != null) {
      data['question_year'] =
          questionYear!.map((v) => v.toJson()).toList();
    }
    data['language'] = language;
    data['status'] = status;
    data['created_at'] = createdAt;
    if (questionCategory != null) {
      data['question_category'] = questionCategory!.toJson();
    }
    if (classItem != null) {
      data['class'] = classItem!.toJson();
    }
    if (session != null) {
      data['session'] = session!.map((v) => v.toJson()).toList();
    }
    if (group != null) {
      data['group'] = group!.toJson();
    }
    if (subject != null) {
      data['subject'] = subject!.toJson();
    }
    if (chapter != null) {
      data['chapter'] = chapter!.toJson();
    }
    if (types != null) {
      data['types'] = types!.map((v) => v.toJson()).toList();
    }
    if (levels != null) {
      data['levels'] = levels!.map((v) => v.toJson()).toList();
    }
    if (topics != null) {
      data['topics'] = topics!.map((v) => v.toJson()).toList();
    }
    if (sources != null) {
      data['sources'] = sources!.map((v) => v.toJson()).toList();
    }
    if (subSources != null) {
      data['sub_sources'] = subSources!.map((v) => v.toJson()).toList();
    }
    if (tags != null) {
      data['tags'] = tags!.map((v) => v.toJson()).toList();
    }
    data['is_selected'] = isSelected;
    data['select_for_quiz'] = selectForQuiz;
    return data;
  }
}

class QuestionYear {
  String? desc;
  String? year;
  String? board;

  QuestionYear({this.desc, this.year, this.board});

  QuestionYear.fromJson(Map<String, dynamic> json) {
    desc = json['desc'].toString();
    year = json['year'].toString();
    board = json['board'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['desc'] = desc;
    data['year'] = year;
    data['board'] = board;
    return data;
  }
}



class Session {
  int? id;
  String? name;
  int? status;

  Session(
      {this.id,
        this.name,
        this.status,});

  Session.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    return data;
  }
}


class Tags {
  int? id;
  String? tagName;

  Tags(
      {this.id,
        this.tagName});

  Tags.fromJson(Map<String, dynamic> json) {
    id = PriceConverter.parseInt(json['id']);
    tagName = json['tag_name'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tag_name'] = tagName;
    return data;
  }
}



