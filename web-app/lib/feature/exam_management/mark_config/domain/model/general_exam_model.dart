import 'package:class_compass/feature/exam_management/exam/domain/model/exam_model.dart';

class GeneralExamModel {
  bool? status;
  String? message;
  GeneralExamItem? data;

  GeneralExamModel({this.status, this.message, this.data});

  GeneralExamModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] is Map ? GeneralExamItem.fromJson(json['data']) : null;
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

class GeneralExamItem {
  List<Subjects>? subjects;
  List<ClassExams>? classExams;
  List<ExamCodes>? examCodes;
  List<MarkConfig>? markConfig;


  GeneralExamItem(
      {
        this.subjects,
        this.classExams,
        this.examCodes,
        this.markConfig
      });

  GeneralExamItem.fromJson(Map<String, dynamic> json) {
    if (json['subjects'] != null) {
      subjects = <Subjects>[];
      json['subjects'].forEach((v) {
        subjects!.add(Subjects.fromJson(v));
      });
    }
    if (json['classExams'] != null) {
      classExams = <ClassExams>[];
      json['classExams'].forEach((v) {
        classExams!.add(ClassExams.fromJson(v));
      });
    }
    if (json['examCodes'] != null) {
      examCodes = <ExamCodes>[];
      json['examCodes'].forEach((v) {
        examCodes!.add(ExamCodes.fromJson(v));
      });
    }
    if (json['markConfig'] != null) {
      markConfig = <MarkConfig>[];
      json['markConfig'].forEach((v) {
        markConfig!.add(MarkConfig.fromJson(v));
      });
      }
    }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (subjects != null) {
      data['subjects'] = subjects!.map((v) => v.toJson()).toList();
    }
    if (classExams != null) {
      data['classExams'] = classExams!.map((v) => v.toJson()).toList();
    }
    if (examCodes != null) {
      data['examCodes'] = examCodes!.map((v) => v.toJson()).toList();
    }

    if (markConfig != null) {
      data['markConfig'] = markConfig!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Subjects {
  int? id;
  String? subjectName;
  bool? isSelected;


  Subjects({this.id,  this.subjectName, this.isSelected});

  Subjects.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subjectName = json['subject_name'];
    isSelected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['subject_name'] = subjectName;
    data['isSelected'] = isSelected;
    return data;
  }
}

class ClassExams {
  int? id;
  Exam? exam;
  ClassItem? classItem;
  MeritType? meritType;
  bool? selected;


  ClassExams(
      {this.id,
        this.exam,
        this.classItem,
        this.meritType,
        this.selected
      });

  ClassExams.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    exam = json['exam'] is Map ? Exam.fromJson(json['exam']) : null;
    classItem = json['class'] is Map ? ClassItem.fromJson(json['class'])
        : null;
    meritType = json['merit_type'] is Map ? MeritType.fromJson(json['merit_type'])
        : null;
    selected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (exam != null) {
      data['exam'] = exam!.toJson();
    }
    if (classItem != null) {
      data['class'] = classItem!.toJson();
    }
    if (meritType != null) {
      data['merit_type'] = meritType!.toJson();
    }
    data['selected'] = selected;
    return data;
  }
}

class Exam {
  int? id;
  String? name;
  String? examCode;

  Exam({this.id,  this.name, this.examCode});

  Exam.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    examCode = json['exam_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['exam_code'] = examCode;
    return data;
  }
}

class ClassItem {
  int? id;
  String? className;

  ClassItem({this.id, this.className});

  ClassItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    className = json['class_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['class_name'] = className;
    return data;
  }
}

class MeritType {
  int? id;
  String? type;
  String? serial;

  MeritType({this.id, this.type, this.serial});

  MeritType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'].toString();
    serial = json['serial'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['serial'] = serial;
    return data;
  }
}

class ExamCodes {
  int? id;
  String? shortCodeTitle;
  String? shortCodeNote;
  String? totalMark;
  String? acceptPercent;
  String? passMark;
  ClassItem? classItem;
  ShortCode? shortCode;

  ExamCodes(
      {this.id,
        this.shortCodeTitle,
        this.shortCodeNote,
        this.totalMark,
        this.acceptPercent,
        this.passMark,
        this.classItem,
        this.shortCode});

  ExamCodes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shortCodeTitle = json['short_code_title'];
    shortCodeNote = json['short_code_note'];
    totalMark = json['total_mark'].toString();
    acceptPercent = json['accept_percent'].toString();
    passMark = json['pass_mark'].toString();
    classItem = json['class'] is Map ? ClassItem.fromJson(json['class'])
        : null;
    shortCode = json['short_code'] is Map ? ShortCode.fromJson(json['short_code'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['short_code_title'] = shortCodeTitle;
    data['short_code_note'] = shortCodeNote;
    data['total_mark'] = totalMark;
    data['accept_percent'] = acceptPercent;
    data['pass_mark'] = passMark;
    if (classItem != null) {
      data['class'] = classItem!.toJson();
    }
    if (shortCode != null) {
      data['short_code'] = shortCode!.toJson();
    }
    return data;
  }
}

class ShortCode {
  int? id;
  String? gradeName;
  String? gradeNumber;
  String? gradePoint;
  String? gradeRange;
  String? numberHigh;
  String? numberLow;
  String? pointHigh;
  String? pointLow;
  String? priority;

  ShortCode(
      {this.id,
        this.gradeName,
        this.gradeNumber,
        this.gradePoint,
        this.gradeRange,
        this.numberHigh,
        this.numberLow,
        this.pointHigh,
        this.pointLow,
        this.priority});

  ShortCode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gradeName = json['grade_name'];
    gradeNumber = json['grade_number'].toString();
    gradePoint = json['grade_point'].toString();
    gradeRange = json['grade_range'].toString();
    numberHigh = json['number_high'].toString();
    numberLow = json['number_low'].toString();
    pointHigh = json['point_high'].toString();
    pointLow = json['point_low'].toString();
    priority = json['priority'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['grade_name'] = gradeName;
    data['grade_number'] = gradeNumber;
    data['grade_point'] = gradePoint;
    data['grade_range'] = gradeRange;
    data['number_high'] = numberHigh;
    data['number_low'] = numberLow;
    data['point_high'] = pointHigh;
    data['point_low'] = pointLow;
    data['priority'] = priority;
    return data;
  }
}

class MarkConfig {
  int? id;
  ClassItem? classItem;
  Group? group;
  Subject? subject;
  ExamItem? exam;
  List<MarkConfigExamCodes>? markConfigExamCodes;

  MarkConfig({
    this.id,
    this.classItem,
    this.group,
    this.subject,
    this.exam,
    this.markConfigExamCodes,
  });

  MarkConfig.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    classItem = json['class'] is Map ? ClassItem.fromJson(json['class']) : null;
    group = json['group'] is Map ? Group.fromJson(json['group']) : null;
    subject = json['subject'] is Map ? Subject.fromJson(json['subject']) : null;
    exam = json['exam'] is Map ? ExamItem.fromJson(json['exam']) : null;
    if (json['mark_config_exam_codes'] != null) {
      markConfigExamCodes = (json['mark_config_exam_codes'] as List)
          .map((v) => MarkConfigExamCodes.fromJson(v))
          .toList();
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (classItem != null) data['class'] = classItem!.toJson();
    if (group != null) data['group'] = group!.toJson();
    if (subject != null) data['subject'] = subject!.toJson();
    if (markConfigExamCodes != null) {
      data['mark_config_exam_codes'] =
          markConfigExamCodes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class Group {
  int? id;
  String? groupName;
  Group({this.id, this.groupName});

  Group.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupName = json['group_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['group_name'] = groupName;
    return data;
  }
}

class Subject {
  int? id;
  String? subjectName;

  Subject({this.id, this.subjectName});

  Subject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subjectName = json['subject_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['subject_name'] = subjectName;
    return data;
  }
}

class MarkConfigExamCodes {
  int? id;
  String? title;
  String? totalMarks;
  String? passMark;
  String? acceptance;

  MarkConfigExamCodes({this.id, this.title, this.totalMarks, this.passMark, this.acceptance});

  MarkConfigExamCodes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    totalMarks = json['total_marks'].toString();
    passMark = json['pass_mark'].toString();
    acceptance = json['acceptance'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['total_marks'] = totalMarks;
    data['pass_mark'] = passMark;
    data['acceptance'] = acceptance;
    return data;
  }
}
