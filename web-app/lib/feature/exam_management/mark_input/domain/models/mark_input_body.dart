class MarkInputBody {
  int? classId;
  int? groupId;
  int? subjectId;
  int? examId;
  List<Marks>? marks;

  MarkInputBody({this.classId, this.groupId, this.subjectId, this.examId, this.marks});

  MarkInputBody.fromJson(Map<String, dynamic> json) {
    classId = json['class_id'];
    groupId = json['group_id'];
    subjectId = json['subject_id'];
    examId = json['exam_id'];
    if (json['marks'] != null) {
      marks = <Marks>[];
      json['marks'].forEach((v) {
        marks!.add(Marks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['class_id'] = classId;
    data['group_id'] = groupId;
    data['subject_id'] = subjectId;
    data['exam_id'] = examId;
    if (marks != null) {
      data['marks'] = marks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Marks {
  int? studentId;
  String? mark1;
  String? mark2;
  String? mark3;
  String? mark4;
  String? mark5;
  String? mark6;

  Marks(
      {this.studentId,
        this.mark1,
        this.mark2,
        this.mark3,
        this.mark4,
        this.mark5,
        this.mark6});

  Marks.fromJson(Map<String, dynamic> json) {
    studentId = json['student_id'];
    mark1 = json['mark_1'];
    mark2 = json['mark_2'];
    mark3 = json['mark_3'];
    mark4 = json['mark_4'];
    mark5 = json['mark_5'];
    mark6 = json['mark_6'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['student_id'] = studentId;
    data['mark_1'] = mark1;
    data['mark_2'] = mark2;
    data['mark_3'] = mark3;
    data['mark_4'] = mark4;
    data['mark_5'] = mark5;
    data['mark_6'] = mark6;
    return data;
  }
}
