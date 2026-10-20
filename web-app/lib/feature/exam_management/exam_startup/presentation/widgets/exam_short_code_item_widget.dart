import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_divider.dart';
import 'package:class_compass/feature/exam_management/exam_startup/controller/exam_startup_controller.dart';
import 'package:class_compass/feature/exam_management/exam_startup/domain/model/exam_short_code_model.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class ExamShortCodeItemWidget extends StatelessWidget {
  final ExamShortCodeItem? examShortCodeItem;
  final int index;
  const ExamShortCodeItemWidget({super.key, this.examShortCodeItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
        Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSeven),
          child: Row(children: [
              SizedBox(width: 15, height: 15, child: Checkbox(value: examShortCodeItem?.isSelected??false,
                  onChanged: (val){
                Get.find<ExamStartupController>().toggleSelection(index);
                  })),
              const SizedBox(width: Dimensions.paddingSizeSmall),
              Expanded(child: Text("${examShortCodeItem?.shortCodeTitle}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),)),
            const SizedBox(width: Dimensions.paddingSizeSmall),

            Expanded(child: Text("${examShortCodeItem?.totalMark}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),)),
            const SizedBox(width: Dimensions.paddingSizeSmall),

            Expanded(child: Text("${examShortCodeItem?.passMark}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),)),
            const SizedBox(width: Dimensions.paddingSizeSmall),

            Expanded(child: Text("${examShortCodeItem?.acceptPercent}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),)),
            const SizedBox(width: Dimensions.paddingSizeSmall),
            ],
          ),
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
          child: CustomDivider()),
      ],
    );
  }
}