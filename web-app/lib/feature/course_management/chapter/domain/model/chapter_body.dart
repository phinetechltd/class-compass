
class ChapterBody {
  String? courseId;
  String? title;
  String? description;
  String? sMethod;

  ChapterBody({this.courseId, this.title, this.description, this.sMethod});

  ChapterBody.fromJson(Map<String, dynamic> json) {
    courseId = json['course_id'];
    title = json['title'];
    description = json['description'];
    sMethod = json['_method'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['course_id'] = courseId?? '';
    data['title'] = title?? '';
    data['description'] = description?? '';
    data['_method'] = sMethod?? '';
    return data;
  }
}
