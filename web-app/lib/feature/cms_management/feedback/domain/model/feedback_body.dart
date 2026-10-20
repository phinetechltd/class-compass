class FeedbackBody {
  String? name;
  String? description;
  String? method;

  FeedbackBody(
      {this.name, this.description, this.method});

  FeedbackBody.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    method = json['_method'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['_method'] = method;
    return data;
  }
}
