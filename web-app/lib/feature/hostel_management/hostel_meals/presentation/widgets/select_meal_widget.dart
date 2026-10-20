import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/dropdown_with_search_widget.dart';
import 'package:class_compass/feature/hostel_management/hostel_meals/domain/model/hostel_meal_model.dart';
import 'package:class_compass/feature/hostel_management/hostel_meals/logic/hostel_meals_controller.dart';
import 'package:class_compass/feature/hostel_management/hostel_meals/presentation/widgets/hostel_meal_list_widget.dart';


class SelectMealWidget extends StatefulWidget {
  final String? title;
  const SelectMealWidget({super.key, this.title});

  @override
  State<SelectMealWidget> createState() => _SelectMealWidgetState();
}

class _SelectMealWidgetState extends State<SelectMealWidget> {

  final searchController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if(Get.find<HostelMealsController>().hostelMealModel == null){
      Get.find<HostelMealsController>().getHostelMeals(1);
    }
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<HostelMealsController>(builder: (signatureController) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(padding: const EdgeInsets.only(bottom: 8.0),
            child: Text("select_meal".tr, style: Theme.of(context).textTheme.titleSmall)),
          DropdownSearch<HostelMealItem>(
            sectionTitle: widget.title,
            selectedItem: signatureController.selectedMealItem,
            itemLabel: (item) => item.mealName ?? "",
            searchController: searchController,
            onSearch: (val) {
              signatureController.getHostelMeals(1);
            },
            listWidgetBuilder: () => HostelMealListWidget(fromSelection: true,
                scrollController: scrollController),
          ),
        ],
      );
    }
    );
  }
}
