import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/edit_delete_section.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/sms/phone_book_category/controller/phone_book_category_controller.dart';
import 'package:class_compass/feature/sms/phone_book_category/domain/models/phone_book_category_model.dart';
import 'package:class_compass/feature/sms/phone_book_category/presentation/screens/create_new_phone_book_category_screen.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class PhoneBookCategoryItemWidget extends StatelessWidget {
  final PhoneBookCategoryItem? phoneBookCategoryItem;
  final int index;
  const PhoneBookCategoryItemWidget({super.key, this.phoneBookCategoryItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.isDesktop(context)?
    Row(spacing: Dimensions.paddingSizeSmall, children: [
      NumberingWidget(index: index),
      Expanded(child: Text("${phoneBookCategoryItem?.name}",
          style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault))),
      Expanded(child: Text("${phoneBookCategoryItem?.description}",
          style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault))),
      EditDeleteSection(horizontal: true, onEdit: (){
        Get.dialog(CustomDialogWidget(title: "category".tr,
            child: CreateNewPhoneBookCategoryScreen(phoneBookCategoryItem: phoneBookCategoryItem)));
      },
        onDelete: (){
          Get.find<PhoneBookCategoryController>().deletePhoneBookCategory(phoneBookCategoryItem!.id!);
        },)
    ],):
    CustomContainer(borderRadius: Dimensions.paddingSizeExtraSmall, child: Row(children: [
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${phoneBookCategoryItem?.name}",
                style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault)),
            Text("${phoneBookCategoryItem?.description}",
                style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault)),
          ],
        )),
        EditDeleteSection(horizontal: true, onEdit: (){
          Get.dialog(CustomDialogWidget(title: "category".tr,
              child: CreateNewPhoneBookCategoryScreen(phoneBookCategoryItem: phoneBookCategoryItem)));
        },
          onDelete: (){
          Get.find<PhoneBookCategoryController>().deletePhoneBookCategory(phoneBookCategoryItem!.id!);
        },)
      ],
    ));
  }
}