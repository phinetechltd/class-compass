class MarksheetConfigBody {
  String? name;
  String? qrCode;
  int? signatureId;
  int? teacherSignatureId;
  int? status;

  MarksheetConfigBody(
      {this.name,
        this.qrCode,
        this.signatureId,
        this.teacherSignatureId,
        this.status});

  MarksheetConfigBody.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    qrCode = json['qr_code'];
    signatureId = json['signature_id'];
    teacherSignatureId = json['teacher_signature_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['qr_code'] = qrCode;
    data['signature_id'] = signatureId;
    data['teacher_signature_id'] = teacherSignatureId;
    data['status'] = status;
    return data;
  }
}
