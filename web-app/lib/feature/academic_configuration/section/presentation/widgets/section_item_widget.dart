import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/widget/custom_item_text_widget.dart';
import 'package:class_compass/common/widget/edit_delete_section.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/academic_configuration/section/controller/section_controller.dart';
import 'package:class_compass/feature/academic_configuration/section/domain/model/section_model.dart';
import 'package:class_compass/feature/academic_configuration/section/presentation/widgets/create_new_section_widget_web.dart';
import 'package:class_compass/util/dimensions.dart';

class SectionItemWidget extends StatelessWidget {
  final SectionItem? sectionItem;
  final int index;
  const SectionItemWidget({super.key, this.sectionItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(spacing: Dimensions.paddingSizeDefault, children: [
      NumberingWidget(index: index),
        Expanded(child: CustomItemTextWidget(text:"${sectionItem?.sectionName}")),
        Expanded(child: CustomItemTextWidget(text:"${sectionItem?.className}")),
        Expanded(child: CustomItemTextWidget(text:"${sectionItem?.groupName}")),
        EditDeleteSection(horizontal: true, onEdit: (){
          Get.dialog(CustomDialogWidget(title: "section".tr,
              child: CreateNewSectionWidgetForWeb(sectionItem: sectionItem)));
        },
          onDelete: (){
          Get.find<SectionController>().deleteSection(sectionItem!.id!);
        },)
      ]);
  }
}