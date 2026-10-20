import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/widget/confirmation_dialog.dart';
import 'package:class_compass/common/widget/custom_item_text_widget.dart';
import 'package:class_compass/common/widget/edit_delete_section.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/hostel_management/hostel_meal_plan/domain/model/hostel_meal_plan_model.dart';
import 'package:class_compass/feature/hostel_management/hostel_meal_plan/presentation/widgets/add_new_hostel_meal_plan_widget.dart';
import 'package:class_compass/feature/hostel_management/hostel_meals/logic/hostel_meals_controller.dart';
import 'package:class_compass/util/dimensions.dart';

class HostelMealPlanItemWidget extends StatelessWidget {
  final HostelMealPlanItem mealPlanItem;
  final int index;

  const HostelMealPlanItemWidget({super.key, required this.mealPlanItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HostelMealsController>(builder: (mealController) {
      return  _buildDesktopView(context, mealController);
    },
    );
  }

  Widget _buildDesktopView(BuildContext context, HostelMealsController mealController) {
    return Row(spacing: Dimensions.paddingSizeDefault, children: [
      NumberingWidget(index: index),
      Expanded(child: CustomItemTextWidget(text: mealPlanItem.meal?.mealName ?? '')),
      Expanded(child: CustomItemTextWidget(text: mealPlanItem.student?.firstName ?? '')),

      EditDeleteSection(horizontal: true,
        onEdit: () => Get.dialog(CustomDialogWidget(
          title: "meal_plan".tr,
            child: AddNewHostelMealPlanWidget(mealPlanItem: mealPlanItem))),
        onDelete: () => Get.dialog(ConfirmationDialog(
          title: "meal_plan".tr,
            onTap: (){
          mealController.deleteHostelMeals(mealPlanItem.id!);
        })),
      ),
    ],
    );
  }

}
