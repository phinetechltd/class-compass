import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/hrm/payroll/controller/payroll_controller.dart';
import 'package:class_compass/feature/reports_management/fees_reports/domain/model/payment_ratio_model.dart';
import 'package:class_compass/feature/reports_management/fees_reports/logic/fees_reports_controller.dart';
import 'package:class_compass/feature/reports_management/fees_reports/presentation/widgets/item_widget/fees_payment_ratio_item_widget.dart';
import 'package:class_compass/feature/reports_management/fees_reports/presentation/widgets/select_year_and_month_widget.dart';

class FeesPaymentRatioListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const FeesPaymentRatioListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeesReportsController>(
      builder: (feesReportsController) {
        PaymentRatioModel? paymentRatioData = feesReportsController.paymentRatioModel;
        final List<PaymentRatioItem> paymentRatioItems = paymentRatioData?.data ?? [];

        return GenericListSection<PaymentRatioItem>(
          showAction: false,
          topWidget: SelectYearAndMonthWidget(noMonth: true, onTap: (){
            if(Get.find<PayrollController>().selectedYear != null) {
              feesReportsController.getPaymentRatioInfo(Get.find<PayrollController>().selectedYear!);
            }
          }),
          sectionTitle: "payment_ratio_info".tr,
          pathItems: ["payment_ratio".tr],
          headings: const ["class", "total_student", "paid_student", "unpaid_student", "paid_percentage", "unpaid_percentage"],
          scrollController: scrollController,
          isLoading: false,
          totalSize: 0,
          offset: 1,
          onPaginate: (offset) async {},
          items: paymentRatioItems,
          itemBuilder: (item, index) => FeesPaymentRatioItemWidget(item: item, index: index),
        );
      },
    );
  }
}