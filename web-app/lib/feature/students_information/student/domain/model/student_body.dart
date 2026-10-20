class StudentBody {
  String? firstName;
  String? lastName;
  String? qrCode;
  String? fatherName;
  String? motherName;
  String? classId;
  String? group;
  String? sectionId;
  String? gender;
  String? registerNo;
  String? roll;
  String? bloodGroup;
  String? religion;
  String? address;
  String? email;
  String? phone;
  String? password;
  String? passwordConfirmation;
  String? informationSentToName;
  String? informationSentToRelation;
  String? informationSentToPhone;
  String? informationSentToAddress;
  String? informationSentToEmail;
  String? method;

  StudentBody(
      {this.firstName,
        this.lastName,
        this.qrCode,
        this.fatherName,
        this.motherName,
        this.classId,
        this.group,
        this.sectionId,
        this.gender,
        this.registerNo,
        this.roll,
        this.bloodGroup,
        this.religion,
        this.address,
        this.email,
        this.phone,
        this.password,
        this.passwordConfirmation,
        this.informationSentToName,
        this.informationSentToRelation,
        this.informationSentToPhone,
        this.informationSentToAddress,
        this.informationSentToEmail,
        this.method
      });

  StudentBody.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    qrCode = json['qr_code'];
    fatherName = json['father_name'];
    motherName = json['mother_name'];
    classId = json['class_id'];
    group = json['group'];
    sectionId = json['section_id'];
    gender = json['gender'];
    registerNo = json['registration_no'];
    roll = json['roll'];
    bloodGroup = json['blood_group'];
    religion = json['religion'];
    address = json['address'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    passwordConfirmation = json['password_confirmation'];
    informationSentToName = json['information_sent_to_name'];
    informationSentToRelation = json['information_sent_to_relation'];
    informationSentToPhone = json['information_sent_to_phone'];
    informationSentToAddress = json['information_sent_to_address'];
    informationSentToEmail = json['information_sent_to_email'];
    method = json['_method'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['first_name'] = firstName??'';
    data['last_name'] = lastName??'';
    data['qr_code'] = qrCode??'';
    data['father_name'] = fatherName??'';
    data['mother_name'] = motherName??'';
    data['class_id'] = classId??'';
    data['group'] = group??'';
    data['section_id'] = sectionId??'';
    data['gender'] = gender??'';
    data['registration_no'] = registerNo??'';
    data['roll'] = roll??'';
    data['blood_group'] = bloodGroup??'';
    data['religion'] = religion??'';
    data['address'] = address??'';
    data['email'] = email??'';
    data['phone'] = phone??'';
    data['password'] = password??'';
    data['password_confirmation'] = passwordConfirmation??'';
    data['information_sent_to_name'] = informationSentToName??'';
    data['information_sent_to_relation'] = informationSentToRelation??'';
    data['information_sent_to_phone'] = informationSentToPhone??'';
    data['information_sent_to_address'] = informationSentToAddress??'';
    data['information_sent_to_email'] = informationSentToEmail??'';
    data['_method'] = method??'';
    return data;
  }
}
