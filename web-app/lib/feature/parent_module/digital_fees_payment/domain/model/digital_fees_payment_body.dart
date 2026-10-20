class StudentParentDigitalFeesPaymentBody {
  String? paymentMethod;
  int? amount;
  String? name;
  String? phone;
  String? email;

  StudentParentDigitalFeesPaymentBody(
      {this.paymentMethod, this.amount, this.name, this.phone, this.email});

  StudentParentDigitalFeesPaymentBody.fromJson(Map<String, dynamic> json) {
    paymentMethod = json['payment_method'];
    amount = json['amount'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['payment_method'] = paymentMethod;
    data['amount'] = amount;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    return data;
  }
}
