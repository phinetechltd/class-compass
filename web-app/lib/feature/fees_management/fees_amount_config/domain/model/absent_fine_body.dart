class AbsentFineBody {
  String? classId;
  String? periodId;
  String? amount;
  String? sMethod;

  AbsentFineBody({this.classId, this.periodId, this.amount, this.sMethod});

  AbsentFineBody.fromJson(Map<String, dynamic> json) {
    classId = json['class_id'];
    periodId = json['period_id'];
    amount = json['amount'];
    sMethod = json['_method'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['class_id'] = classId;
    data['period_id'] = periodId;
    data['amount'] = amount;
    data['_method'] = sMethod;
    return data;
  }
}
