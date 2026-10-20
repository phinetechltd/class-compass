class HostelMealPlanBody {
  String? studentId;
  String? mealId;
  String? date;

  HostelMealPlanBody({this.studentId, this.mealId, this.date});

  HostelMealPlanBody.fromJson(Map<String, dynamic> json) {
    studentId = json['student_id'];
    mealId = json['meal_id'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['student_id'] = studentId;
    data['meal_id'] = mealId;
    data['date'] = date;
    return data;
  }
}
