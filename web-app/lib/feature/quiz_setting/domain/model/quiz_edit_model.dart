class QuizEditModel {
  bool? status;
  String? message;
  Data? data;

  QuizEditModel({this.status, this.message, this.data});

  QuizEditModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  int? instituteId;
  String? instituteName;
  int? courseId;
  String? courseName;
  int? chapterId;
  String? chapterName;
  String? title;
  List<int>? questionIds;

  Data(
      {this.id,
        this.instituteId,
        this.instituteName,
        this.courseId,
        this.courseName,
        this.chapterId,
        this.chapterName,
        this.title,
        this.questionIds,
        });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instituteId = json['institute_id'];
    instituteName = json['institute_name'];
    courseId = json['course_id'];
    courseName = json['course_name'];
    chapterId = json['chapter_id'];
    chapterName = json['chapter_name'];
    title = json['title'];
    questionIds = (json['question_ids'] as List?)?.cast<int>() ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['institute_id'] = instituteId;
    data['institute_name'] = instituteName;
    data['course_id'] = courseId;
    data['course_name'] = courseName;
    data['chapter_id'] = chapterId;
    data['chapter_name'] = chapterName;
    data['title'] = title;
    data['question_ids'] = questionIds;
    return data;
  }
}

class Description {
  String? insert;

  Description({this.insert});

  Description.fromJson(Map<String, dynamic> json) {
    insert = json['insert'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['insert'] = insert;
    return data;
  }
}
