import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/widget/confirmation_dialog.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/common/widget/custom_item_text_widget.dart';
import 'package:class_compass/common/widget/edit_delete_popup_widget.dart';
import 'package:class_compass/common/widget/edit_delete_section.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/academic_configuration/subject/controller/subject_controller.dart';
import 'package:class_compass/feature/academic_configuration/subject/domain/model/subject_model.dart';
import 'package:class_compass/feature/academic_configuration/subject/presentation/screens/add_new_subject_screen.dart';
import 'package:class_compass/feature/academic_configuration/subject/presentation/widgets/add_new_subject_widget.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';

class SubjectItemWidget extends StatelessWidget {
  final SubjectItem? subjectItem;
  final int index;
  const SubjectItemWidget({super.key, this.subjectItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.isDesktop(context)?
      Row(spacing: Dimensions.paddingSizeDefault,
        crossAxisAlignment: CrossAxisAlignment.start, children: [
        NumberingWidget(index: index),
        Expanded(child: CustomItemTextWidget(text: "${subjectItem?.subjectName}")),
        Expanded(child: CustomItemTextWidget(text: subjectItem?.subjectCode??'',)),
        Expanded(child: CustomItemTextWidget(text: subjectItem?.className??'',)),
        Expanded(child: CustomItemTextWidget(text: subjectItem?.fullMark??'N/A',)),
        Expanded(child: CustomItemTextWidget(text: subjectItem?.passMark??'N/A',)),
          EditDeletePopupMenu(onDelete: (){
          Get.dialog(ConfirmationDialog(title: "subject", content: "subject",
            onTap: (){
              Get.back();
              Get.find<SubjectController>().deleteSubject(subjectItem!.id!);
            },));

        }, onEdit: (){
          Get.dialog(CustomDialogWidget(title: "subject".tr,
              child: AddNewSubjectWidget(subjectItem: subjectItem,)));
        },)
      ],
      ):
      Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, 0),
        child: CustomContainer(child: Row(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(borderRadius: BorderRadius.circular(120),
                child: const CustomImage(width: Dimensions.imageSizeBig, height: Dimensions.imageSizeBig, image: "")),
            const SizedBox(width: Dimensions.paddingSizeSmall),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CustomItemTextWidget(text: "${subjectItem?.subjectName}"),
              CustomItemTextWidget(text: "${"code".tr} : ${subjectItem?.subjectCode??''}",),
              CustomItemTextWidget(text: "${"class".tr} : ${subjectItem?.className??''}",),
              CustomItemTextWidget(text: "${"full_mark".tr} : ${subjectItem?.fullMark??''}",),
              const SizedBox(height: Dimensions.paddingSizeExtraSmall),
              CustomItemTextWidget(text: "${"pass_mark".tr} : ${subjectItem?.passMark??''}",),
              const SizedBox(height: Dimensions.paddingSizeExtraSmall),

            ]),
            ),
            EditDeleteSection(onDelete: (){
              Get.dialog(ConfirmationDialog(title: "subject", content: "subject",
                onTap: (){
                  Get.back();
                  Get.find<SubjectController>().deleteSubject(subjectItem!.id!);
                },));

            }, onEdit: (){
              Get.to(()=> (child: AddNewSubjectScreen(subjectItem: subjectItem,)));
            },)

          ],
        )),
      );
  }
}