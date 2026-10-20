import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/fees_management/paid_info/controller/paid_info_controller.dart';
import 'package:class_compass/feature/fees_management/paid_info/domain/model/un_paid_report_model.dart';
import 'package:class_compass/feature/reports_management/fees_reports/presentation/widgets/un_paid_report_item_widget.dart';

class UnPaidReportListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const UnPaidReportListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaidInfoController>(
      builder: (paidInfoController) {
        final unPaidReportModel = paidInfoController.unPaidReportModel;
        final unPaidData = unPaidReportModel?.data?.studentData ?? [];
        return GenericListSection<UnpaidStudentData>(
          sectionTitle: "fees_management".tr,
          pathItems: ["unpaid_report".tr],
          scrollController: scrollController,
          isLoading: unPaidReportModel == null,
          totalSize: 0,
          showAction: false,
          offset: 1,
          headings: const ["roll", "name", "due_details", "total_paid",],
          items: unPaidData,
          itemBuilder: (item, index) => UnPaidReportItemWidget(unPaidReportItem: item, index: index),
          onPaginate: (int? offset) async {  },
        );
      },
    );
  }
}
