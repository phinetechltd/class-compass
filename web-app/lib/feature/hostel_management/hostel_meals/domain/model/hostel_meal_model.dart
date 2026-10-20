

class HostelMealItem {
  int? id;
  String? mealName;
  String? mealType;

  HostelMealItem(
      {this.id,
        this.mealName,
        this.mealType,});

  HostelMealItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    mealName = json['meal_name'];
    mealType = json['meal_type'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;

    data['meal_name'] = mealName;
    data['meal_type'] = mealType;
    return data;
  }
}
