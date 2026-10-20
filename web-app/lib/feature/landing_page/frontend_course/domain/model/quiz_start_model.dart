class QuizStartModel {
  String? message;
  int? attemptId;
  String? startedAt;
  String? expiresAt;

  QuizStartModel(
      {this.message, this.attemptId, this.startedAt, this.expiresAt});

  QuizStartModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    attemptId = json['attempt_id'];
    startedAt = json['started_at'];
    expiresAt = json['expires_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['attempt_id'] = attemptId;
    data['started_at'] = startedAt;
    data['expires_at'] = expiresAt;
    return data;
  }
}
