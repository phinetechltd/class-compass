import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_generic_dropdown.dart';
import 'package:class_compass/feature/library_management/book_category/controller/book_category_controller.dart';
import 'package:class_compass/feature/library_management/book_category/domain/model/book_category_model.dart';
import 'package:class_compass/util/styles.dart';



class SelectBookCategoryWidget extends StatelessWidget {
  const SelectBookCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
       Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text("book_category".tr, style: textRegular,)),
      GetBuilder<BookCategoryController>(initState: (state) {
        if (Get.find<BookCategoryController>().bookCategoryModel == null){
          Get.find<BookCategoryController>().getBookCategoriesList(page: 1, perPage: 100);
        }
        },
        builder: (bookCategoryController) {
          final bookCategoryModel = bookCategoryController.bookCategoryModel;
          List<BookCategoryItem> category = bookCategoryModel?.data?.data ?? [];

          return CustomGenericDropdown<BookCategoryItem>(
            title: "select",
            items: category,
            selectedValue: bookCategoryController.selectedBookCategoryItem,
            onChanged: (val) {
              bookCategoryController.setSelectBookCategory(val!);
            },
            getLabel: (item) => item.categoryName ?? '',
          );
        },
      ),
    ],
    );
  }
}
