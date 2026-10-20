import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/widget/confirmation_dialog.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_item_text_widget.dart';
import 'package:class_compass/common/widget/edit_delete_section.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/cms_management/feedback/domain/model/feedback_model.dart';
import 'package:class_compass/feature/cms_management/feedback/logic/feedback_controller.dart';
import 'package:class_compass/feature/cms_management/feedback/presentation/widgets/create_new_feedback_widget.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';

class FeedbackItemWidget extends StatelessWidget {
  final FeedbackItem? feedbackItem;
  final int index;
  const FeedbackItemWidget({super.key, this.feedbackItem, required this.index});

  void _onEdit(BuildContext context) {
    Get.dialog(CustomDialogWidget(title: "feedback".tr,
        child: CreateNewFeedbackWidget(feedbackItem: feedbackItem,)));
  }

  void _onDelete() {
    Get.dialog(ConfirmationDialog(
        title: "feedback",
        content: "are_you_sure_to_delete_this_feedback".tr,
        onTap: (){
          Get.back();
          Get.find<FeedbackController>().deleteFeedback(feedbackItem?.id??0);
        }));
  }

  @override
  Widget build(BuildContext context) {
    final editDelete = EditDeleteSection(onEdit: () => _onEdit(context), onDelete: _onDelete, horizontal: ResponsiveHelper.isDesktop(context));
    return Padding(padding: const EdgeInsets.symmetric(vertical: 5),
      child: ResponsiveHelper.isDesktop(context)?
      Row(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeSmall, children: [
        NumberingWidget(index: index),
        Expanded(child: CustomItemTextWidget(text :feedbackItem?.name??'N/A',)),
        Expanded(child: CustomItemTextWidget(text: feedbackItem?.description??'')),
        editDelete
      ]):
      CustomContainer(child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CustomItemTextWidget(text:feedbackItem?.name??'N/A'),
          CustomItemTextWidget(text:feedbackItem?.description??''),
        ])),
        editDelete
      ])),
    );
  }
}
