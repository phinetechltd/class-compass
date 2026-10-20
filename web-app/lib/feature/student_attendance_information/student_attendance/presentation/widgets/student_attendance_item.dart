import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_item_text_widget.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/student_attendance_information/student_attendance/controller/student_attendance_controller.dart';
import 'package:class_compass/feature/student_attendance_information/student_attendance/domain/models/student_for_attendance_model.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class StudentAttendanceItem extends StatelessWidget {
  final StudentItem? studentItem;
  final int index;
  const StudentAttendanceItem({super.key, this.studentItem, required this.index});

  @override
  Widget build(BuildContext context) {
    bool isDesktop = ResponsiveHelper.isDesktop(context);
      final studentAttendanceController = Get.find<StudentAttendanceController>();
    return Padding(padding: const EdgeInsets.symmetric(vertical: 5),
      child: isDesktop?
      Row(spacing: Dimensions.paddingSizeDefault, children: [
        NumberingWidget(index: index),
          Expanded(child: CustomItemTextWidget(text: studentItem?.name??'')),
        Expanded(child: CustomItemTextWidget(text:studentItem?.rollNo??'')),
        Expanded(child: CustomItemTextWidget(text:studentItem?.phone??'')),

        Expanded(
          child: InkWell(onTap: () => studentAttendanceController.updateAttendanceStatus(index,true),
              child: Row(children: [
                Icon(studentItem!.isPresent!? Icons.radio_button_checked_rounded :
                Icons.radio_button_off,
                  color: studentItem!.isPresent!? Theme.of(context).primaryColor :
                  Theme.of(context).hintColor,),

                const SizedBox(width: 5),
                Text("present".tr, style: textRegular.copyWith(),),],)),
        ),

        Expanded(
          child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: InkWell(onTap: ()=> studentAttendanceController.updateAttendanceStatus(
                index,false),
                child: Row(children: [
                  Icon(!studentItem!.isPresent!? Icons.radio_button_checked_rounded :
                  Icons.radio_button_off,
                    color: !studentItem!.isPresent!? Theme.of(context).primaryColor :
                    Theme.of(context).hintColor,),
                  const SizedBox(width: 5),
                  Text("absent".tr, style: textRegular.copyWith(),),],)),
          ),
        ),

        ],
      ):CustomContainer(color: studentItem!.isPresent!? Theme.of(context).cardColor : Theme.of(context).highlightColor,
          showShadow: studentItem!.isPresent!,
          borderRadius: 5,
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

              Text("${'name'.tr} : ${studentItem?.name??''}",
                style: textRegular.copyWith(),),
              Row(children: [
                Text("${'roll'.tr} : ${studentItem?.rollNo??''}",
                  style: textRegular.copyWith(),),
                const SizedBox(width: Dimensions.paddingSizeDefault,),

                GetBuilder<StudentAttendanceController>(builder: (studentAttendanceController) {
                  return Row(children: [
                    InkWell(onTap: () => studentAttendanceController.updateAttendanceStatus(index,true),
                        child: Row(children: [
                          Icon(studentItem!.isPresent!? Icons.radio_button_checked_rounded :
                          Icons.radio_button_off,
                            color: studentItem!.isPresent!? Theme.of(context).primaryColor :
                            Theme.of(context).hintColor,),

                          const SizedBox(width: 5),
                          Text("present".tr, style: textRegular.copyWith(),),],)),

                    Padding(padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: InkWell(onTap: ()=>studentAttendanceController.updateAttendanceStatus(
                          index,false),
                          child: Row(children: [
                            Icon(!studentItem!.isPresent!? Icons.radio_button_checked_rounded :
                            Icons.radio_button_off,
                              color: !studentItem!.isPresent!? Theme.of(context).primaryColor :
                              Theme.of(context).hintColor,),
                            const SizedBox(width: 5),
                            Text("absent".tr, style: textRegular.copyWith(),),],)),
                    ),
                  ]);
                }
                ),
              ],
              ),
            ]),
            ),
          ],
          )),
    );
  }
}