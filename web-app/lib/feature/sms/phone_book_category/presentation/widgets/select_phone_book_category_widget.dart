import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/feature/sms/phone_book_category/controller/phone_book_category_controller.dart';
import 'package:class_compass/feature/sms/phone_book_category/presentation/widgets/phone_book_category_dropdown.dart';

class SelectPhoneBookCategoryWidget extends StatefulWidget {
  const SelectPhoneBookCategoryWidget({super.key});
  @override
  State<SelectPhoneBookCategoryWidget> createState() => _SelectPhoneBookCategoryWidgetState();
}

class _SelectPhoneBookCategoryWidgetState extends State<SelectPhoneBookCategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const CustomTitle(title: "category"),
      GetBuilder<PhoneBookCategoryController>(
          initState: (state) {
            if(Get.find<PhoneBookCategoryController>().selectedPhoneBookCategoryItem == null){
              Get.find<PhoneBookCategoryController>().getPhoneBookCategoryList();
            }
          },

          builder: (phoneBookCategoryController) {
            return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: PhoneBookCategoryDropdown(width: Get.width, title: "select".tr,
                items: phoneBookCategoryController.phoneBookCategoryModel?.data??[],
                selectedValue: phoneBookCategoryController.selectedPhoneBookCategoryItem,
                onChanged: (val){
                  phoneBookCategoryController.selectPhoneBookCategory(val!);
                },
              ),);
          }
      ),
    ],);
  }
}
