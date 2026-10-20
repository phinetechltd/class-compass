import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/cms_management/why_choose_us/domain/model/why_choose_us_model.dart';
import 'package:class_compass/feature/cms_management/why_choose_us/logic/why_choose_us_controller.dart';
import 'package:class_compass/feature/cms_management/why_choose_us/presentation/widgets/create_new_why_choose_us_widget.dart';
import 'package:class_compass/feature/cms_management/why_choose_us/presentation/widgets/why_choose_us_item_widget.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';

class WhyChooseUsListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const WhyChooseUsListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WhyChooseUsController>(
      initState: (val) => Get.find<WhyChooseUsController>().getWhyChooseUs(1),
      builder: (whyChooseUsController) {
        final whyChooseUsModel = whyChooseUsController.whyChooseUsModel;
        final whyChooseUsData = whyChooseUsModel?.data;

        return GenericListSection<WhyChooseUsItem>(
          sectionTitle: "cms_management".tr,
          pathItems: ["why_choose_us".tr],
          addNewTitle: "add_new_why_choose_us".tr,
          onAddNewTap: () => Get.dialog(Dialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: SizedBox(width: ResponsiveHelper.isDesktop(context) ? 600 : Get.width,
              child: const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: CreateNewWhyChooseUsWidget())))),
          headings: const ["image", "title", "description",],

          scrollController: scrollController,
          isLoading: whyChooseUsModel == null,
          totalSize: whyChooseUsData?.total ?? 0,
          offset: whyChooseUsData?.currentPage ?? 1,
          onPaginate: (offset) async => await whyChooseUsController.getWhyChooseUs(offset ?? 1),
          items: whyChooseUsData?.data ?? [],
          itemBuilder: (item, index) => WhyChooseUsItemWidget(whyChooseUsItem: item, index: index),
        );
      },
    );
  }
}