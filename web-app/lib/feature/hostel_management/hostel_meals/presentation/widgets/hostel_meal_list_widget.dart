import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/hostel_management/hostel_meals/domain/model/hostel_meal_model.dart';
import 'package:class_compass/feature/hostel_management/hostel_meals/logic/hostel_meals_controller.dart';
import 'package:class_compass/feature/hostel_management/hostel_meals/presentation/widgets/add_new_meal_widget.dart';
import 'package:class_compass/feature/hostel_management/hostel_meals/presentation/widgets/hostel_meal_item_widget.dart';

class HostelMealListWidget extends StatelessWidget {
  final bool fromSelection;
  final ScrollController? scrollController;
  
  const HostelMealListWidget({super.key, this.scrollController, this.fromSelection = false});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HostelMealsController>(
      initState: (val) {
        if(Get.find<HostelMealsController>().hostelMealModel == null){
          Get.find<HostelMealsController>().getHostelMeals(1);
        }
      },
      builder: (hostelMealController) {
        final mealModel = hostelMealController.hostelMealModel;
        final mealData = mealModel?.data;
        
        return GenericListSection<HostelMealItem>(
          sectionTitle: "hostel_management".tr,
          pathItems: ["hostel_meal".tr],
          addNewTitle: "add_new_hostel_meal".tr,
          onAddNewTap: () => Get.dialog(CustomDialogWidget(
            title: "meal".tr,
              child: const AddNewMealWidget())),
          headings: const ["name", "type", ],
          scrollController: scrollController ?? ScrollController(),
          isLoading: mealData == null,
          totalSize:  mealData?.total??0,
          offset:  mealData?.currentPage??0,
          onPaginate: (offset) async => await hostelMealController.getHostelMeals(offset??1),
          
          items: mealData?.data ?? [],
          itemBuilder: (item, index) => InkWell(
           onTap: (){
             if(fromSelection){
                Get.back(result: item);
                Get.find<HostelMealsController>().setSelectedMeal(item);
             }
           },
              child: HostelMealItemWidget(mealItem: item, index: index)),
        );
      },
    );
  }
}
