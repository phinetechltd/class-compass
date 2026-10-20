

class QuestionBankClassItem {
  int? id;
  String? name;


  QuestionBankClassItem(
      {this.id,
        this.name});

  QuestionBankClassItem.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json['id']?.toString() ?? '');
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

