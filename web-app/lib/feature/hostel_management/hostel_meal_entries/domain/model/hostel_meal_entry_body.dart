class HostelMealEntryBody {
  int? studentId;
  int? mealId;
  String? date;
  String? mealPrice;

  HostelMealEntryBody({this.studentId, this.mealId, this.date, this.mealPrice});

  HostelMealEntryBody.fromJson(Map<String, dynamic> json) {
    studentId = json['student_id'];
    mealId = json['meal_id'];
    date = json['date'];
    mealPrice = json['meal_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['student_id'] = studentId;
    data['meal_id'] = mealId;
    data['date'] = date;
    data['meal_price'] = mealPrice;
    return data;
  }
}
