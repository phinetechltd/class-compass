import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_checkbox.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_item_text_widget.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/sms/sent_sms/domain/model/absent_student_model.dart';
import 'package:class_compass/feature/sms/sent_sms/logic/sent_sms_controller.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';

class AbsentStudentItemWidget extends StatelessWidget {
  final AbsentStudentItem? userItem;
  final int index;
  const AbsentStudentItemWidget({super.key, this.userItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.isDesktop(context)?
    Row(spacing: Dimensions.paddingSizeSmall, children: [
     NumberingWidget(index: index),
      Expanded(child: CustomItemTextWidget(text: userItem?.name??'')),
      Expanded(child: CustomItemTextWidget(text: userItem?.phone??'')),

      CustomCheckbox(onChange: (){
        Get.find<SentSmsController>().toggleSelectedAbsentStudent(index);
      }, value: userItem?.selected ?? false,),
    ]):

    Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeSmall, Dimensions.paddingSizeDefault, 0),
      child: CustomContainer(borderRadius: 5, 
        child: Row( children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CustomItemTextWidget(text: userItem?.name??''),
              CustomItemTextWidget(text: userItem?.phone??''),

          ])),
          CustomCheckbox(onChange: (){
            Get.find<SentSmsController>().toggleSelectedAbsentStudent(index);
          }, value: userItem?.selected ?? false,),

        ])));
  }
}
