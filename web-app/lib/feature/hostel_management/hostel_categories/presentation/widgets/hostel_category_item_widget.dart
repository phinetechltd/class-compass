import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/widget/confirmation_dialog.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_item_text_widget.dart';
import 'package:class_compass/common/widget/edit_delete_section.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/hostel_management/hostel_categories/domain/model/hostel_category_model.dart';
import 'package:class_compass/feature/hostel_management/hostel_categories/logic/hostel_categories_controller.dart';
import 'package:class_compass/feature/hostel_management/hostel_categories/presentation/screens/add_new_hostel_category_screen.dart';
import 'package:class_compass/helper/price_converter.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';

class HostelCategoryItemWidget extends StatelessWidget {
  final HostelCategoryItem categoryItem;
  final int index;
  
  const HostelCategoryItemWidget({super.key, required this.categoryItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HostelCategoriesController>(
      builder: (categoryController) {
        return ResponsiveHelper.isDesktop(context) ? _buildDesktopView(context, categoryController) : _buildMobileView(context, categoryController);
      },
    );
  }

  Widget _buildDesktopView(BuildContext context, HostelCategoriesController categoryController) {
    return Row(spacing: Dimensions.paddingSizeSmall, children: [
      NumberingWidget(index: index),
      Expanded(child: CustomItemTextWidget(text: categoryItem.hostelName ?? '')),
      Expanded(child: CustomItemTextWidget(text: categoryItem.standard ?? '')),
      Expanded(child: CustomItemTextWidget(text: PriceConverter.convertPrice(context, categoryItem.hostelFee??0))),
      EditDeleteSection(horizontal: true,
          onEdit: () => Get.dialog(CustomDialogWidget(title: "hostel_category".tr,
              child: AddNewHostelCategoryScreen(categoryItem: categoryItem))),
          onDelete: () {
            Get.dialog(ConfirmationDialog(
              title: "hostel_category".tr,
                content: "hostel_category".tr,
                onTap: (){
              categoryController.deleteHostelCategory(categoryItem.id!);
            }));
          },
        ),
      ],
    );
  }

  Widget _buildMobileView(BuildContext context, HostelCategoriesController categoryController) {
    return CustomContainer(
      child: Row(children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CustomItemTextWidget(text: categoryItem.hostelName ?? ''),
              CustomItemTextWidget(text: categoryItem.standard ?? ''),
              CustomItemTextWidget(text: PriceConverter.convertPrice(context, categoryItem.hostelFee??0)),
          ])),

        EditDeleteSection(
          onEdit: () => Get.dialog(CustomDialogWidget(title: "hostel_category".tr,
              child: AddNewHostelCategoryScreen(categoryItem: categoryItem))),
          onDelete: () {
            Get.dialog(ConfirmationDialog(
                title: "hostel_category".tr,
                content: "hostel_category".tr,
                onTap: (){
                  categoryController.deleteHostelCategory(categoryItem.id!);
                }));
          },
        ),
        ],
      ),
    );
  }
}
