import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/widget/confirmation_dialog.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_item_text_widget.dart';
import 'package:class_compass/common/widget/edit_delete_section.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/library_management/book_category/controller/book_category_controller.dart';
import 'package:class_compass/feature/library_management/book_category/domain/model/book_category_model.dart';
import 'package:class_compass/feature/library_management/book_category/presentation/screens/create_new_book_category_dialog.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';

class BookCategoryItemWidget extends StatelessWidget {
  final BookCategoryItem? bookCategoryItem;
  final int index;

  const BookCategoryItemWidget({super.key, required this.bookCategoryItem, required this.index});

  @override
  Widget build(BuildContext context) {
    if (ResponsiveHelper.isDesktop(context)) {
      return Row(spacing: Dimensions.paddingSizeDefault, children: [
        NumberingWidget(index: index),
        Expanded(child: CustomItemTextWidget(text: bookCategoryItem?.categoryName ?? '')),
        EditDeleteSection(horizontal: true, onDelete: () => _onDelete(context), onEdit: () => _onEdit()),
        ]);
    } else {
      return Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
        child: CustomContainer(borderRadius: Dimensions.paddingSizeExtraSmall,
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(child: CustomItemTextWidget(text: bookCategoryItem?.categoryName ?? '')),
              EditDeleteSection(horizontal: true, onDelete: () => _onDelete(context), onEdit: () => _onEdit()),
            ])),
      );
    }
  }

  void _onDelete(BuildContext context) {
    Get.dialog(ConfirmationDialog(
        title: "book_category".tr, onTap: () {
          Get.back();
          if (bookCategoryItem?.id != null) {
            Get.find<BookCategoryController>().deleteBookCategory(bookCategoryItem!.id!);
          }
        },
      ),
    );
  }

  void _onEdit() {
    Get.dialog(CustomDialogWidget(title: "category".tr,
      child: CreateNewBookCategoryScreen(
          bookCategoryItem: bookCategoryItem,
        ),
    ),
    );
  }
}
