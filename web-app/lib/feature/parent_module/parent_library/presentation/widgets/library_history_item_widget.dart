import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_item_text_widget.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/library_management/book/domain/model/book_issue_model.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class LibraryHistoryItemWidget extends StatelessWidget {
  final BookIssueItem? bookIssueItem;
  final int index;
  const LibraryHistoryItemWidget({super.key, this.bookIssueItem, required this.index});

  @override
  Widget build(BuildContext context) {
    bool isDesktop = ResponsiveHelper.isDesktop(context);
    return isDesktop?
    Row(spacing: Dimensions.paddingSizeDefault, children: [
      NumberingWidget(index: index),
      Expanded(child: CustomItemTextWidget(text:"${bookIssueItem?.bookName}")),
      Expanded(child: CustomItemTextWidget(text:bookIssueItem?.issueDate??'')),
      Expanded(child: CustomItemTextWidget(text:bookIssueItem?.dueDate??'')),
      Expanded(child: CustomItemTextWidget(text:bookIssueItem?.returnDate??'not_returned_yet'.tr)),
    ]):

    Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: Dimensions.paddingSizeSmall),
      child: Container(decoration: BoxDecoration(color: index%2==1? const Color(0xFFDDFDE9): const Color(0xFFFDF6DC)),
        child: Padding(padding: const EdgeInsets.all(8),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("${bookIssueItem?.bookName}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
            Text("${"issued".tr}: ${bookIssueItem?.issueDate??''}", style: textRegular.copyWith()),
            Text("${"due_date".tr}: ${bookIssueItem?.dueDate??''}", style: textRegular.copyWith()),
            Text("${"returned".tr}: ${bookIssueItem?.returnDate??'not_returned_yet'.tr}", style: textRegular.copyWith()),
          ]))),
    );
  }
}