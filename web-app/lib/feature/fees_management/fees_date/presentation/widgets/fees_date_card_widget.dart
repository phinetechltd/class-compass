import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/widget/confirmation_dialog.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_item_text_widget.dart';
import 'package:class_compass/common/widget/edit_delete_popup_widget.dart';
import 'package:class_compass/common/widget/edit_delete_section.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/fees_management/fees_date/controller/fees_date_controller.dart';
import 'package:class_compass/feature/fees_management/fees_date/domain/model/fees_date_model.dart';
import 'package:class_compass/feature/fees_management/fees_date/presentation/widgets/edit_date_config_widget.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class FeesDateCardWidget extends StatelessWidget {
  final FeesDateItem? feesDateItem;
  final int index;
  const FeesDateCardWidget({super.key, this.feesDateItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.isDesktop(context)?
    Row(spacing: Dimensions.paddingSizeDefault, children: [
      NumberingWidget(index: index),
      Expanded(child: CustomItemTextWidget(text:feesDateItem?.feeSubHeadName??'', )),
      Expanded(child: CustomItemTextWidget(text:"${feesDateItem?.payableDateStart}", )),
      Expanded(child: CustomItemTextWidget(text:"${feesDateItem?.payableDateEnd}", )),

      EditDeletePopupMenu(
        onDelete: ()=> Get.dialog(ConfirmationDialog(
          title: "date_config".tr, content: "date_config".tr,
            onTap: (){
            Get.find<FeesDateController>().deleteFeesDate(feesDateItem!.id!);
            })),
          onEdit: ()=> Get.dialog(CustomDialogWidget(title: "date_config".tr,
              child: EditDateConfigWidget(item: feesDateItem))))

    ],):

    Padding(padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: CustomContainer(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(feesDateItem?.feeSubHeadName??'', style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),),
                Row(children: [
                  Expanded(child: Text("${feesDateItem?.payableDateEnd}", style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),)),
                  const SizedBox(width: Dimensions.paddingSizeSmall),
                  Expanded(child: Text("${feesDateItem?.payableDateStart}", style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),)),
                ],)
              ],
            )),

          EditDeleteSection(
              onDelete: ()=> Get.dialog(ConfirmationDialog(
                  title: "date_config".tr, content: "date_config".tr,
                  onTap: (){
                    Get.find<FeesDateController>().deleteFeesDate(feesDateItem!.id!);
                  })),
              onEdit: ()=> Get.dialog(CustomDialogWidget(title: "date_config".tr,
                  child: EditDateConfigWidget(item: feesDateItem))))

          ],
        ),

      ],),),
    );
  }
}
