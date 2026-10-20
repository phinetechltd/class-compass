class DuePaymentBody {
  String? userId;
  String? type;
  String? date;
  String? amount;
  String? totalPayable;
  String? note;

  DuePaymentBody(
      {this.userId,
        this.type,
        this.date,
        this.amount,
        this.totalPayable,
        this.note});

  DuePaymentBody.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    type = json['type'];
    date = json['date'];
    amount = json['amount'];
    totalPayable = json['total_payable'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['type'] = type;
    data['date'] = date;
    data['amount'] = amount;
    data['total_payable'] = totalPayable;
    data['note'] = note;
    return data;
  }
}
