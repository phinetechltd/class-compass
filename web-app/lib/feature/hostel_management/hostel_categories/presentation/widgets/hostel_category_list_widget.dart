import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/hostel_management/hostel_categories/domain/model/hostel_category_model.dart';
import 'package:class_compass/feature/hostel_management/hostel_categories/logic/hostel_categories_controller.dart';
import 'package:class_compass/feature/hostel_management/hostel_categories/presentation/screens/add_new_hostel_category_screen.dart';
import 'package:class_compass/feature/hostel_management/hostel_categories/presentation/widgets/hostel_category_item_widget.dart';

class HostelCategoryListWidget extends StatelessWidget {
  final ScrollController? scrollController;
  
  const HostelCategoryListWidget({super.key, this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HostelCategoriesController>(
      initState: (val) => Get.find<HostelCategoriesController>().getHostelCategoriesList(),
      builder: (categoryController) {
        final categoryModel = categoryController.hostelCategoryModel;
        final categoryData = categoryModel?.data;
        
        return GenericListSection<HostelCategoryItem>(
          sectionTitle: "hostel_management".tr,
          pathItems: ["hostel_categories".tr],
          addNewTitle: "add_new_hostel_category".tr,
          onAddNewTap: () => Get.dialog(CustomDialogWidget(title: "hostel_category".tr,
              child: const AddNewHostelCategoryScreen())),
          headings: const ["hostel", "standard", "hostel_fee"],
          
          scrollController: scrollController ?? ScrollController(),
          isLoading: categoryModel == null,
          totalSize: categoryData?.total ?? 0,
          offset: categoryData?.currentPage ?? 0,
          onPaginate: (offset) async => await categoryController.getHostelCategoriesList(page: offset ?? 1),
          
          items: categoryData?.data ?? [],
          itemBuilder: (item, index) => HostelCategoryItemWidget(
            categoryItem: item, 
            index: index
          ),
        );
      },
    );
  }
}
