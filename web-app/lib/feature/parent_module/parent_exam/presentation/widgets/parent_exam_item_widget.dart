import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_item_text_widget.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/parent_module/parent_exam/domain/model/parent_exam_model.dart';
import 'package:class_compass/feature/parent_module/parent_exam/presentation/screens/parent_exam_result_screen.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class ParentExamItemWidget extends StatelessWidget {
  final ParentExamItem? examItem;
  final int index;
  const ParentExamItemWidget({super.key, this.examItem, required this.index});

  @override
  Widget build(BuildContext context) {
    bool isDesktop = ResponsiveHelper.isDesktop(context);
    return isDesktop?
      Row(spacing: Dimensions.paddingSizeDefault, children: [
        NumberingWidget(index: index),
          Expanded(child: CustomItemTextWidget(text:"${examItem?.exam?.name}")),
        Expanded(child: CustomItemTextWidget(text:"${examItem?.meritType?.type}")),
        Expanded(child: CustomItemTextWidget(text:"${examItem?.meritType?.serial}")),
        Expanded(child: InkWell(onTap: ()=> Get.to(()=> ParentExamResultScreen(examId: examItem!.examId!)),
            child: CustomItemTextWidget(text:"view_result".tr))),
        ]):
    Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSeven),
        child: CustomContainer(
          onTap: ()=> Get.to(()=> ParentExamResultScreen(examId: examItem!.examId!)),
          showShadow: false, borderColor: Theme.of(context).hintColor.withAlpha(50), borderRadius: Dimensions.paddingSizeExtraSmall,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("${examItem?.exam?.name}", style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge),),
            Text("${examItem?.meritType?.type}", style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),),
            Text("${"position".tr}: ${examItem?.meritType?.serial}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
            Text("view_result".tr, style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
          ]),
        ));
  }
}