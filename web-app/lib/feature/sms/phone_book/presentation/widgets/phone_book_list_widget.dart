import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/sms/phone_book/controller/phone_book_controller.dart';
import 'package:class_compass/feature/sms/phone_book/domain/models/phone_book_model.dart';
import 'package:class_compass/feature/sms/phone_book/presentation/widgets/phone_book_item_widget.dart';
import 'package:class_compass/feature/sms/phone_book/presentation/screens/create_new_phone_book_screen.dart';

class PhoneBookListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const PhoneBookListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PhoneBookController>(
      initState: (state) => Get.find<PhoneBookController>().getPhoneBookList(),
      builder: (controller) {
        final phoneBookModel = controller.phoneBookModel;
        final phoneBookData = phoneBookModel?.data;
        return GenericListSection<PhoneBookItem>(
          sectionTitle: "sms_management".tr,
          pathItems: ["phone_book".tr],
          addNewTitle: "add_new_phone_book".tr,
          onAddNewTap: () => Get.dialog(CustomDialogWidget(title: "phone_book".tr,
              child: const CreateNewPhoneBookScreen())),
          headings: const ["name", "phone", "category"],
          scrollController: scrollController,
          isLoading: phoneBookModel == null,
          totalSize: 0,
          offset: 0,
          onPaginate: (offset) async => await controller.getPhoneBookList(),
          items: phoneBookData ?? [],
          itemBuilder: (item, index) => PhoneBookItemWidget(index: index, phoneBookItem: item),
        );
      },
    );
  }
}
