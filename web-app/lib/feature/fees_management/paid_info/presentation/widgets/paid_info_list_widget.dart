import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/common/controller/datepicker_controller.dart';
import 'package:class_compass/feature/academic_configuration/class/controller/class_controller.dart';
import 'package:class_compass/feature/fees_management/paid_info/controller/paid_info_controller.dart';
import 'package:class_compass/feature/fees_management/paid_info/domain/model/paid_report_model.dart';
import 'package:class_compass/feature/fees_management/paid_info/presentation/widgets/paid_info_search_widget.dart';
import 'package:class_compass/feature/fees_management/paid_info/presentation/widgets/paid_report_item_widget.dart';

class PaidReportListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const PaidReportListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaidInfoController>(builder: (paidInfoController) {
        final paidReportModel = paidInfoController.paidReportModel;
        final paidReportData = paidReportModel?.data;
        return GenericListSection<PaidReportInfo>(
          topWidget: const PaidInfoSearchWidget(),
          sectionTitle: "fees_management".tr,
          pathItems: ["paid_report".tr],
          scrollController: scrollController,
          isLoading:false,
          totalSize: paidReportData?.length ?? 0,
          offset: 1,
          onPaginate: (_) async {
            final dateCtrl = Get.find<DatePickerController>();
            await paidInfoController.getPaidFeeInfoList(
              Get.find<ClassController>().selectedClassItem!.id!,
                dateCtrl.formatedDate, dateCtrl.formatedEndDate);},
          headings: const ["roll", "name", "invoice", "total_payable", "total_paid"],
          items: paidReportData ?? [],
          itemBuilder: (item, index) => PaidReportItemWidget(paidReportInfo: item, index: index),
        );
      },
    );
  }
}
