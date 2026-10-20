
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/confirmation_dialog.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/common/widget/edit_delete_popup_widget.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/students_information/student/controller/student_controller.dart';
import 'package:class_compass/feature/students_information/student/domain/model/student_model.dart';
import 'package:class_compass/feature/students_information/student/presentation/widgets/add_new_student_widget.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class AllStudentItemWidget extends StatelessWidget {
  final StudentItem? studentItem;
  final int index;
  const AllStudentItemWidget({super.key, this.studentItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.isDesktop(context)?
    Row(spacing: Dimensions.paddingSizeSmall, children: [
       NumberingWidget(index: index),
        SizedBox(width: 50, child: Center(child: ClipRRect(borderRadius: BorderRadius.circular(120),
            child: CustomImage(width: 25, height: 25, image: "${AppConstants.baseUrl}/storage/users/${studentItem?.image}" )),)),
        Expanded(child: Text(studentItem?.roll??'', style: textRegular.copyWith(),)),
        Expanded(child: Text("${studentItem?.firstName} ${studentItem?.lastName}", maxLines: 1,overflow: TextOverflow.ellipsis,
          style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),)),
        Expanded(child: Text(studentItem?.phone??'', style: textRegular.copyWith(),)),
        Expanded( child: Text(studentItem?.gender??'', style: textRegular.copyWith(),)),
        Expanded(child:  Text(studentItem?.sectionName??'N/A', style: textRegular.copyWith())),
        Expanded(child: Text(studentItem?.className??'N/A', style: textRegular.copyWith(),)),
        Expanded(child: Text(studentItem?.informationSentToName??'',maxLines: 1,overflow: TextOverflow.ellipsis, style: textRegular.copyWith(),)),
      EditDeletePopupMenu(onEdit: (){
        Get.dialog(Dialog(
          child: AddNewStudentWidget(studentItem: studentItem),
        ));
      }, onDelete: (){
        Get.dialog(ConfirmationDialog(title: "student".tr,
            onTap: (){
          Get.find<StudentController>().deleteStudent(studentItem!.id!);
        }));
      },
      )
      ]):

    CustomContainer(child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ClipRRect(borderRadius: BorderRadius.circular(120),
            child: const CustomImage(width: Dimensions.imageSizeBig, height: Dimensions.imageSizeBig, image: "")),
        const SizedBox(width: Dimensions.paddingSizeSmall),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("${studentItem?.name}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
          Text("${"roll".tr} : ${studentItem?.roll??''}", style: textRegular.copyWith(),),
          Text("${"reg_no".tr} : ${studentItem?.registerNo??''}", style: textRegular.copyWith(),),
          Text("${"phone".tr} : ${studentItem?.phone??''}", style: textRegular.copyWith(),),
          Text("${"class".tr} : ${studentItem?.className??''}", style: textRegular.copyWith(),),
          Text("${"section".tr} : ${studentItem?.sectionName??''}", style: textRegular.copyWith(),),
          Text("${"guardian".tr} : ${studentItem?.informationSentToName??''}", style: textRegular.copyWith(),),

        ])),
      EditDeletePopupMenu(onEdit: (){
        Get.dialog(Dialog(
          child: AddNewStudentWidget(studentItem: studentItem),
        ));
      }, onDelete: (){
        Get.dialog(ConfirmationDialog(title: "student".tr,
            onTap: (){
              Get.find<StudentController>().deleteStudent(studentItem!.id!);
            }));
      },
      )
      ],
    ));
  }
}