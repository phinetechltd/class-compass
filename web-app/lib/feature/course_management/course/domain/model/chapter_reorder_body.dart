class ChapterReorderBody {
  int? courseId;
  List<Chapters>? chapters;

  ChapterReorderBody({this.courseId, this.chapters});

  ChapterReorderBody.fromJson(Map<String, dynamic> json) {
    courseId = json['course_id'];
    if (json['chapters'] != null) {
      chapters = <Chapters>[];
      json['chapters'].forEach((v) {
        chapters!.add(Chapters.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['course_id'] = courseId;
    if (chapters != null) {
      data['chapters'] = chapters!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Chapters {
  int? chapterId;
  int? priority;

  Chapters({this.chapterId, this.priority});

  Chapters.fromJson(Map<String, dynamic> json) {
    chapterId = json['chapter_id'];
    priority = json['priority'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chapter_id'] = chapterId;
    data['priority'] = priority;
    return data;
  }
}
