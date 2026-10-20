
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/hostel_management/hostel_meal_plan/domain/model/hostel_meal_plan_model.dart';
import 'package:class_compass/feature/hostel_management/hostel_meal_plan/logic/hostel_meal_plan_controller.dart';
import 'package:class_compass/feature/hostel_management/hostel_meal_plan/presentation/widgets/add_new_hostel_meal_plan_widget.dart';
import 'package:class_compass/feature/hostel_management/hostel_meal_plan/presentation/widgets/hostel_meal_plan_widget.dart';

class HostelMealPlanListWidget extends StatelessWidget {
  final ScrollController? scrollController;

  const HostelMealPlanListWidget({super.key, this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HostelMealPlanController>(
      initState: (val) {
        if(Get.find<HostelMealPlanController>().hostelMealPlanModel == null){
          Get.find<HostelMealPlanController>().getHostelMealPlan(1);
        }
      },
      builder: (hostelMealController) {
        final mealModel = hostelMealController.hostelMealPlanModel;
        final mealData = mealModel?.data;

        return GenericListSection<HostelMealPlanItem>(
          sectionTitle: "hostel_management".tr,
          pathItems: ["hostel_meal_plan".tr],
          addNewTitle: "add_new_meal_plan".tr,
          onAddNewTap: () => Get.dialog(CustomDialogWidget(
            title: "meal_plan".tr,
              child: const AddNewHostelMealPlanWidget())),
          headings: const ["meal", "student", ],
          scrollController: scrollController ?? ScrollController(),
          isLoading: mealData == null,
          totalSize:  mealData?.total??0,
          offset:  mealData?.currentPage??0,
          onPaginate: (offset) async => await hostelMealController.getHostelMealPlan(offset??1),

          items: mealData?.data ?? [],
          itemBuilder: (item, index) => HostelMealPlanItemWidget(mealPlanItem: item, index: index),
        );
      },
    );
  }
}
