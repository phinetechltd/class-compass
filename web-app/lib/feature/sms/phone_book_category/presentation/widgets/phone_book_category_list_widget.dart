import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/sms/phone_book_category/controller/phone_book_category_controller.dart';
import 'package:class_compass/feature/sms/phone_book_category/domain/models/phone_book_category_model.dart';
import 'package:class_compass/feature/sms/phone_book_category/presentation/widgets/phone_book_category_item_widget.dart';
import 'package:class_compass/feature/sms/phone_book_category/presentation/screens/create_new_phone_book_category_screen.dart';

class PhoneBookCategoryListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const PhoneBookCategoryListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PhoneBookCategoryController>(
      initState: (state) => Get.find<PhoneBookCategoryController>().getPhoneBookCategoryList(),
      builder: (controller) {
        final categoryModel = controller.phoneBookCategoryModel;
        final categoryData = categoryModel?.data;

        return GenericListSection<PhoneBookCategoryItem>(
          sectionTitle: "sms_management".tr,
          pathItems: ["phone_book".tr],
          addNewTitle: "add_new_category".tr,
          onAddNewTap: () => Get.dialog(CustomDialogWidget(title: "category".tr,
              child: const CreateNewPhoneBookCategoryScreen())),
          headings: const ["name", "description" ],

          scrollController: scrollController,
          isLoading: categoryModel == null,
          totalSize:  0,
          offset:  0,
          onPaginate: (offset) async => await controller.getPhoneBookCategoryList(),

          items: categoryData ?? [],
          itemBuilder: (item, index) => PhoneBookCategoryItemWidget(index: index, phoneBookCategoryItem: item),
        );
      },
    );
  }
}
