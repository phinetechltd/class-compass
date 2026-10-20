import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_item_text_widget.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/library_management/book/domain/model/book_issue_report_model.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';

class BookIssueReportResultItemWidget extends StatelessWidget {
  final BookIssueReportResultItem? issueItem;
  final int index;
  const BookIssueReportResultItemWidget({super.key, this.issueItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.isDesktop(context)?
    Row(spacing: Dimensions.paddingSizeSmall, children: [
      NumberingWidget(index: index),
      Expanded(child: CustomItemTextWidget(text:'${issueItem?.code}')),
      Expanded(child: CustomItemTextWidget(text:'${issueItem?.bookName}')),
      Expanded(child: CustomItemTextWidget(text:'${issueItem?.type}')),
      Expanded(child: CustomItemTextWidget(text:'${issueItem?.libraryId}')),
      Expanded(child: CustomItemTextWidget(text:'${issueItem?.studentFirstName} ${issueItem?.studentLastName}')),
      Expanded(child: CustomItemTextWidget(text:'${issueItem?.issueDate}')),
      CustomItemTextWidget(text:issueItem?.status == "1"? "open".tr : "returned".tr),


    ]):
    CustomContainer(borderRadius: Dimensions.paddingSizeExtraSmall,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CustomItemTextWidget(text:'${issueItem?.bookName}'),
        CustomItemTextWidget(text:'${issueItem?.code}'),
        CustomItemTextWidget(text:'${issueItem?.type}'),
        CustomItemTextWidget(text:'${issueItem?.libraryId}'),
        CustomItemTextWidget(text:'${issueItem?.studentFirstName} ${issueItem?.studentLastName}'),
        CustomItemTextWidget(text:'${issueItem?.issueDate}'),
        CustomItemTextWidget(text:issueItem?.status == "1"? "open".tr : "returned".tr),
      ],),
    );
  }
}
