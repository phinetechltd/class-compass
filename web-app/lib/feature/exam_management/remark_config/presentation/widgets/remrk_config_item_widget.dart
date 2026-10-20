import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/widget/confirmation_dialog.dart';
import 'package:class_compass/common/widget/edit_delete_section.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/exam_management/remark_config/controller/re_mark_config_controller.dart';
import 'package:class_compass/feature/exam_management/remark_config/domain/model/remark_config_model.dart';
import 'package:class_compass/feature/exam_management/remark_config/presentation/widgets/create_new_remark_config_dialog.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class ReMarkConfigItemWidget extends StatelessWidget {
  final RemarkConfigItem? remarkConfigItem;
  final int index;
  const ReMarkConfigItemWidget({super.key, this.remarkConfigItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(spacing: Dimensions.paddingSizeDefault, children: [
      NumberingWidget(index: index),
        Expanded(child: Text("${remarkConfigItem?.remarkTitle}",maxLines: 1, overflow: TextOverflow.ellipsis,
            style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault))),
        Expanded(child: Text("${remarkConfigItem?.remarks}",maxLines: 2,overflow: TextOverflow.ellipsis,
            style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault))),
        EditDeleteSection(horizontal: true, onEdit: (){
          Get.dialog(CustomDialogWidget(title: "remark".tr,
              child: CreateNewReMarkConfigDialog(remarkConfigItem: remarkConfigItem)));
        },
          onDelete: (){
            Get.dialog(ConfirmationDialog(
              title: 'remark_config',
              content: 'remark_config',
              onTap: () {
                Get.find<ReMarkConfigController>().deleteReMarkConfig(remarkConfigItem!.id!);
              },));
        },)
      ],);
  }
}