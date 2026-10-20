import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/reports_management/fees_reports/domain/model/fees_payment_info_model.dart';
import 'package:class_compass/feature/reports_management/fees_reports/logic/fees_reports_controller.dart';
import 'package:class_compass/feature/reports_management/fees_reports/presentation/widgets/item_widget/fees_payment_info_item_widget.dart';
import 'package:class_compass/feature/reports_management/fees_reports/presentation/widgets/select_year_and_month_widget.dart';

class FeesPaymentInfoReportListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const FeesPaymentInfoReportListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeesReportsController>(
      builder: (feesReportsController) {
        FeesPaymentInfoReportModel? feesPaymentInfoModel = feesReportsController.feesPaymentInfoModel;
        return GenericListSection<FeesPaymentInfoItem>(
          topWidget: SelectYearAndMonthWidget(onTap: (){
            Get.find<FeesReportsController>().getPaymentFeesInfo();
          }),
          showAction: false,
          sectionTitle: "fees_reports_management".tr,
          pathItems: ["payment_info".tr],
          headings: const ["student", "invoice_id", "total_payable", "total_paid", "total_due"],
          scrollController: scrollController,
          isLoading: feesPaymentInfoModel == null,
          totalSize: 0,
          offset: 1,
          onPaginate: (offset) async {},
          items: feesPaymentInfoModel?.data ?? [],
          itemBuilder: (item, index) => FeesPaymentInfoItemWidget(item: item, index: index),
        );
      },
    );
  }
}