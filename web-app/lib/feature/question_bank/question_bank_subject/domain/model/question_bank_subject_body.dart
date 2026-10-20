class QuestionBankSubjectBody {
  String? name;
  int? classId;
  int? categoryId;
  int? groupId;
  String? method;

  QuestionBankSubjectBody({this.name, this.classId, this.categoryId, this.groupId, this.method});

  QuestionBankSubjectBody.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    categoryId = json['question_category_id'];
    classId = json['class_id'];
    groupId = json['group_id'];
    method = json['_method'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['question_category_id'] = categoryId;
    data['class_id'] = classId;
    data['group_id'] = groupId;
    data['_method'] = method;
    return data;
  }
}
