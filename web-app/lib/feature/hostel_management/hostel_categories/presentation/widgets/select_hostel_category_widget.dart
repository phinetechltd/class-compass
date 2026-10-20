import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_generic_dropdown.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/feature/hostel_management/hostel_categories/domain/model/hostel_category_model.dart';
import 'package:class_compass/feature/hostel_management/hostel_categories/logic/hostel_categories_controller.dart';

class SelectHostelCategoryWidget extends StatefulWidget {
  const SelectHostelCategoryWidget({super.key});

  @override
  State<SelectHostelCategoryWidget> createState() => _SelectHostelCategoryWidgetState();
}

class _SelectHostelCategoryWidgetState extends State<SelectHostelCategoryWidget> {
  @override
  void initState() {
    super.initState();
    if (Get.find<HostelCategoriesController>().hostelCategoryModel == null) {
      Get.find<HostelCategoriesController>().getHostelCategoriesList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const CustomTitle(title: "hostel_category"),
        GetBuilder<HostelCategoriesController>(builder: (categoryController) {
            return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
              child:  CustomGenericDropdown<HostelCategoryItem>(
                title: "select".tr,
                items: categoryController.hostelCategoryModel?.data?.data ?? [],
                selectedValue: categoryController.selectedCategoryItem,
                onChanged: (val) {
                  categoryController.setSelectedHostelCategory(val!);
                  },
                getLabel: (item) => item.standard ?? '',
              ),
            );
          }
        ),
      ],
    );
  }
}
