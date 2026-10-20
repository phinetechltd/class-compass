import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/widget/custom_item_text_widget.dart';
import 'package:class_compass/common/widget/edit_delete_section.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/hostel_management/hostel_meals/domain/model/hostel_meal_model.dart';
import 'package:class_compass/feature/hostel_management/hostel_meals/logic/hostel_meals_controller.dart';
import 'package:class_compass/feature/hostel_management/hostel_meals/presentation/widgets/add_new_meal_widget.dart';
import 'package:class_compass/util/dimensions.dart';

class HostelMealItemWidget extends StatelessWidget {
  final HostelMealItem mealItem;
  final int index;
  
  const HostelMealItemWidget({super.key, required this.mealItem, required this.index});

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
      Expanded(child: CustomItemTextWidget(text: mealItem.mealName ?? '')),
      Expanded(child: CustomItemTextWidget(text: mealItem.mealType ?? '')),

        EditDeleteSection(horizontal: true,
          onEdit: () => Get.dialog(CustomDialogWidget(
            title: "meal".tr,
              child: AddNewMealWidget(item: mealItem))),
          onDelete: () => mealController.deleteHostelMeals(mealItem.id!),
        ),
      ],
    );
  }

}
