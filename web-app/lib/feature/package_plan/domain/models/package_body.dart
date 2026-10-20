class PackageBody {
  String? name;
  String? description;
  int? studentLimit;
  int? branchLimit;
  String? price;
  String? durationDays;
  bool? isCustom;
  bool? isFree;
  String? method;
  String? status;

  PackageBody(
      {this.name,
        this.description,
        this.studentLimit,
        this.branchLimit,
        this.price,
        this.durationDays,
        this.isCustom,
        this.isFree,
        this.method,
        this.status
      });

  PackageBody.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    studentLimit = json['student_limit'];
    branchLimit = json['branch_limit'];
    price = json['price'];
    durationDays = json['duration_days'];
    isCustom = json['is_custom'];
    isFree = json['is_free'];
    method = json['_method'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['student_limit'] = studentLimit;
    data['branch_limit'] = branchLimit;
    data['price'] = price;
    data['duration_days'] = durationDays;
    data['is_custom'] = isCustom;
    data['is_free'] = isFree;
    data['status'] = status;
    data['_method'] = method;
    return data;
  }
}
