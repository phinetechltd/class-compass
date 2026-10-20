import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/sms/sent_sms/domain/model/sent_sms_report_model.dart';
import 'package:class_compass/feature/sms/sent_sms/logic/sent_sms_controller.dart';
import 'package:class_compass/feature/sms/sent_sms/presentation/widgets/search_sms_report_widget.dart';
import 'package:class_compass/feature/sms/sent_sms/presentation/widgets/sent_sms_report_item_widget.dart';

class SmsReportListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const SmsReportListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SentSmsController>(
      initState: (state) => Get.find<SentSmsController>().getSmsReport(1),
      builder: (controller) {
        final smsReportModel = controller.smsReportModel;
        final smsReport = smsReportModel?.data?.data ?? [];

        return GenericListSection<SmsReportItem>(
          sectionTitle: "sms_management".tr,
          topWidget: const SearchSmsReportWidget(),
          pathItems: ["report".tr],
          showAction: false,
          headings: const ["sms", "phone", "user_type"],
          scrollController: scrollController,
          isLoading: smsReportModel == null,
          totalSize:  smsReportModel?.data?.total??0,
          offset:  smsReportModel?.data?.currentPage??1,
          onPaginate: (offset) async => await controller.getSmsReport(offset??  1),
          items: smsReport,
          itemBuilder: (item, index) => SentSmsReportItemWidget(index: index, userItem: item),
        );
      },
    );
  }
}
