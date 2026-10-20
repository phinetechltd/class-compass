import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_item_text_widget.dart';
import 'package:class_compass/common/widget/edit_delete_section.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/routine_management/syllabus/controller/syllabus_controller.dart';
import 'package:class_compass/feature/routine_management/syllabus/domain/models/syllabus_model.dart';
import 'package:class_compass/feature/routine_management/syllabus/presentation/screens/create_new_syllabus_screen.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';

class SyllabusItemWidget extends StatelessWidget {
  final SyllabusItem? syllabusItem;
  final int index;
  const SyllabusItemWidget({super.key, this.syllabusItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(spacing: Dimensions.paddingSizeSmall, children: [
      NumberingWidget(index: index),
       CustomContainer(verticalPadding: 0,horizontalPadding: 0,borderRadius: 3,
         onTap: ()=> AppConstants.openUrl("${AppConstants.baseUrl}/uploads/files/syllabus/${syllabusItem?.file}"),
        width: 30, height: 30,child: const Icon(Icons.file_download),),
      Expanded(child: CustomItemTextWidget(text: syllabusItem?.title??'')),
      Expanded(child: CustomItemTextWidget(text: syllabusItem?.description??'')),
        EditDeleteSection(horizontal: true, onEdit: (){
          Get.to(()=> CreateNewSyllabusScreen(syllabusItem: syllabusItem));
        },
          onDelete: (){
          Get.find<SyllabusController>().deleteDepartment(syllabusItem!.id!);
        },)
      ],
    );
  }
}