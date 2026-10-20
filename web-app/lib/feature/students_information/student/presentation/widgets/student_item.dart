
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/widget/active_inactive_widget.dart';
import 'package:class_compass/common/widget/confirmation_dialog.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/common/widget/custom_item_text_widget.dart';
import 'package:class_compass/common/widget/edit_delete_popup_widget.dart';
import 'package:class_compass/common/widget/edit_delete_section.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/students_information/student/controller/student_controller.dart';
import 'package:class_compass/feature/students_information/student/domain/model/student_model.dart';
import 'package:class_compass/feature/students_information/student/presentation/screens/add_new_student_screen.dart';
import 'package:class_compass/feature/students_information/student/presentation/widgets/add_new_student_widget.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class StudentItemWidget extends StatelessWidget {
  final StudentItem? studentItem;
  final int index;
  const StudentItemWidget({super.key, this.studentItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 5),
      child: ResponsiveHelper.isDesktop(context)?
      Row(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeDefault,
          children: [
        NumberingWidget(index: index),

        ClipRRect(borderRadius: BorderRadius.circular(120),
            child:  CustomImage(width: 40, height: 40,
                image: "${AppConstants.imageBaseUrl}/users/${studentItem?.image}")
        ),

          Expanded(child: CustomItemTextWidget(text:studentItem?.roll??'')),
          Expanded(child: CustomItemTextWidget(text:studentItem?.registerNo??'')),
          Expanded(child: CustomItemTextWidget(text:"${studentItem?.firstName} ${studentItem?.lastName}")),
          Expanded(child: CustomItemTextWidget(text:studentItem?.phone??'N/A')),
          Expanded(child: CustomItemTextWidget(text:studentItem?.gender??'N/A')),
          Expanded(child: CustomItemTextWidget(text:studentItem?.informationSentToName??'N/A')),
        ActiveInActiveWidget(active: studentItem?.status == "1", onChanged: (val){
          Get.find<StudentController>().updateStudentStatus(studentItem!.id!, !val? "disable" :"enable");
        }),

      _buildPopupMenu(context, studentItem),
        ]):

      CustomContainer(child: Row(crossAxisAlignment: CrossAxisAlignment.start,
        spacing: Dimensions.paddingSizeSmall, children: [
          ClipRRect(borderRadius: BorderRadius.circular(120),
              child: const CustomImage(width: Dimensions.imageSizeBig,
                  height: Dimensions.imageSizeBig, image: "")),

          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("${studentItem?.name}",
              style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
            Text("${"roll".tr} : ${studentItem?.roll??''}", style: textRegular.copyWith(),),
            Text("${"phone".tr} : ${studentItem?.phone??''}", style: textRegular.copyWith(),),
            const SizedBox(height: Dimensions.paddingSizeExtraSmall),


          ])),

          EditDeleteSection(
              onDelete: () => Get.dialog(ConfirmationDialog(title: "student".tr, onTap: (){
          Get.find<StudentController>().deleteStudent(studentItem!.id!);
           })),
              onEdit: (){
            Get.to(()=> AddNewStudentScreen(studentItem: studentItem,));
          })

        ],
      )),
    );
  }
  Widget _buildPopupMenu(BuildContext context, StudentItem? studentItem) {
    return EditDeletePopupMenu(onDelete: () => Get.dialog(ConfirmationDialog(
      title: "student".tr,
        onTap: (){
      Get.find<StudentController>().deleteStudent(studentItem!.id!);
    })),
      onEdit: (){
      Get.dialog(CustomDialogWidget(title: "student".tr,width: 900,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: AddNewStudentWidget(studentItem: studentItem),
        ),
      ));},
    );
  }
}