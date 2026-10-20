class HostelMealBody {
  String? mealName;
  String? mealType;

  HostelMealBody({
    this.mealName,
    this.mealType,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['meal_name'] = mealName;
    data['meal_type'] = mealType;
    return data;
  }
}
