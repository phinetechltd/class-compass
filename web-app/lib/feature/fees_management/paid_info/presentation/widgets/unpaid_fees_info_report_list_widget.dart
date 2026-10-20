import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/fees_management/paid_info/controller/paid_info_controller.dart';
import 'package:class_compass/feature/fees_management/paid_info/domain/model/un_paid_report_model.dart';
import 'package:class_compass/feature/fees_management/paid_info/presentation/widgets/unpaid_fees_info_item_widget.dart';
import 'package:class_compass/feature/fees_management/paid_info/presentation/widgets/unpaid_search_widget.dart';

class UnpaidFeesInfoReportListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const UnpaidFeesInfoReportListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaidInfoController>(builder: (unPaidController) {
      UnPaidReportModel? model = unPaidController.unPaidReportModel;
        return GenericListSection<UnpaidStudentData>(
          topWidget: const UnpaidSearchWidget(),
          sectionTitle: "fees_management".tr,
          pathItems: ["unpaid_info".tr],
          headings: const ["name", "roll", "total_due"],
          scrollController: scrollController,
          isLoading: false,
          totalSize: 0,
          offset: 1,
          onPaginate: (offset) async {},
          items: model?.data?.studentData ?? [],
          itemBuilder: (item, index) => UnpaidFeesInfoItemWidget(item: item, index: index),
        );
      },
    );
  }
}