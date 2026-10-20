import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/widget/confirmation_dialog.dart';
import 'package:class_compass/common/widget/custom_item_text_widget.dart';
import 'package:class_compass/common/widget/edit_delete_section.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/hostel_management/hostel_meal_entries/domain/model/hostel_meal_entry_model.dart';
import 'package:class_compass/feature/hostel_management/hostel_meal_entries/presentation/widgets/add_new_meal_entries_widget.dart';
import 'package:class_compass/feature/hostel_management/hostel_meals/logic/hostel_meals_controller.dart';
import 'package:class_compass/util/dimensions.dart';

class HostelMealEntriesItemWidget extends StatelessWidget {
  final HostelMealEntryItem mealEntryItem;
  final int index;

  const HostelMealEntriesItemWidget({super.key, required this.mealEntryItem, required this.index});

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

      Expanded(child: CustomItemTextWidget(text: mealEntryItem.meal?.mealName ?? '')),
      Expanded(child: CustomItemTextWidget(text: mealEntryItem.mealPrice ?? '')),
      Expanded(child: CustomItemTextWidget(text: mealEntryItem.student?.firstName ?? '')),

      EditDeleteSection(horizontal: true,
        onEdit: () => Get.dialog(CustomDialogWidget(title: "meal_entry".tr,
            child: AddNewHostelMealEntriesWidget(mealEntryItem: mealEntryItem))),
        onDelete: () => Get.dialog(ConfirmationDialog(
          title: "meal_entry".tr,
            onTap: (){
          mealController.deleteHostelMeals(mealEntryItem.id!);
        })),
      ),
    ],
    );
  }

}
