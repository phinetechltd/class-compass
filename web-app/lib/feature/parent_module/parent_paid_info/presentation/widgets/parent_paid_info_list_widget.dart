import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/parent_module/parent_paid_info/controller/parent_paid_info_controller.dart';
import 'package:class_compass/feature/parent_module/parent_paid_info/domain/model/parent_paid_report_model.dart';
import 'package:class_compass/feature/parent_module/parent_paid_info/presentation/widgets/parent_paid_report_item_widget.dart';

class ParentPaidReportListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const ParentPaidReportListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ParentPaidInfoController>(
      initState: (val) => Get.find<ParentPaidInfoController>().getPaidFeeInfoList(),
      builder: (paidInfoController) {
        final ParentPaidReportModel? paidReportModel = paidInfoController.paidReportModel;
        final collectionHistory = paidReportModel?.data?.collectionHistory ?? [];

        return GenericListSection<CollectionHistory>(
          sectionTitle: "fees".tr,
          pathItems: ["paid_report".tr],
          showAction: false,
          headings: const ["invoice_id", "date","title","previous_due", "fine" ,"waiver", "paid", ],

          scrollController: scrollController,

          isLoading: paidReportModel == null,
          totalSize: 0,
          offset: 1,
          onPaginate: (offset) async {
            await paidInfoController.getPaidFeeInfoList();
          },
          items: collectionHistory,
          itemBuilder: (item, index) => ParentPaidReportItemWidget(paidReportInfo: item, index: index),
        );
      },
    );
  }
}
