class FundTransferBody {
  String? transactionDate;
  String? type;
  int? fundId;
  int? fundToId;
  String? amount;
  String? description;

  FundTransferBody(
      {this.transactionDate,
        this.type,
        this.fundId,
        this.fundToId,
        this.amount,
        this.description});

  FundTransferBody.fromJson(Map<String, dynamic> json) {
    transactionDate = json['transaction_date'];
    type = json['type'];
    fundId = json['fund_id'];
    fundToId = json['fund_to_id'];
    amount = json['amount'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['transaction_date'] = transactionDate;
    data['type'] = type;
    data['fund_id'] = fundId;
    data['fund_to_id'] = fundToId;
    data['amount'] = amount;
    data['description'] = description;
    return data;
  }
}
