import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/library_management/book/controller/book_controller.dart';
import 'package:class_compass/feature/library_management/book/domain/model/book_issue_report_model.dart';
import 'package:class_compass/feature/library_management/book/presentation/widgets/book_issue_report_result_item_widget.dart';
import 'package:class_compass/feature/library_management/book/presentation/widgets/book_issue_report_search_widget.dart';

class BookIssueReportListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const BookIssueReportListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    final TextEditingController idController = TextEditingController();
    return GetBuilder<BookController>(
      initState: (val) => Get.find<BookController>().getBookIssueReport(1),
      builder: (bookController) {
        final reportModel = bookController.bookIssueReportModel;
        final reportData = reportModel?.data;

        return GenericListSection<BookIssueReportResultItem>(
          sectionTitle: "library_management".tr,
          pathItems: ["book_issue_report".tr],
          showAction: false,
          scrollController: scrollController,
          topWidget: const BookIssueReportSearchWidget(),
          headings:  const ["code", "name", "type", "id", "name", "issue_date", "status"],
          isLoading: reportModel == null,
          totalSize: reportData?.issues?.total ?? 0,
          offset: reportData?.issues?.currentPage ?? 0,
          onPaginate: (offset) async => await bookController.getBookIssueReport(offset ?? 1,
            statusId: bookController.selectedTypeIndex.toString(),
            userId: idController.text.trim()),
          items: reportData?.issues?.data ?? [],
          itemBuilder: (item, index) => BookIssueReportResultItemWidget(issueItem: item, index: index),

        );
      },
    );
  }
}
