class WaiverConfigBody {
  List<int>? students;
  int? wavierId;
  String? waiverAmount;
  int? feeHeadId;

  WaiverConfigBody({this.students, this.wavierId, this.waiverAmount, this.feeHeadId});

  WaiverConfigBody.fromJson(Map<String, dynamic> json) {
    students = json['students'].cast<int>();
    wavierId = json['wavier_id'];
    waiverAmount = json['waiver_amount'];
    feeHeadId = json['fee_head_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['students'] = students;
    data['wavier_id'] = wavierId;
    data['waiver_amount'] = waiverAmount;
    data['fee_head_id'] = feeHeadId;
    return data;
  }
}
