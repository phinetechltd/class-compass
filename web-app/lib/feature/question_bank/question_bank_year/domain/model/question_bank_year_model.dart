

class QuestionBankYearItem {
  int? id;
  String? year;

  QuestionBankYearItem({this.id, this.year});

  QuestionBankYearItem.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['year'] = year;
    return data;
  }
}

