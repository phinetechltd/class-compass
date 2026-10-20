import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_divider.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/feature/students_information/student/domain/model/student_model.dart';
import 'package:class_compass/feature/students_information/student_migration/controller/student_migration_controller.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class StudentItemForMigration extends StatelessWidget {
  final StudentItem? studentItem;
  final int index;
  final bool isAll;
  const StudentItemForMigration({super.key, this.studentItem, required this.index, this.isAll = false});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentMigrationController>(
      builder: (studentController) {
        return Padding(padding: const EdgeInsets.symmetric(vertical: 5),
          child: ResponsiveHelper.isDesktop(context)?
          Column(children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start, spacing:  Dimensions.paddingSizeDefault , children: [
                    SizedBox(width : 20, height: 20,
                      child: Checkbox(value: studentItem?.isSelected, onChanged: (val){
                        studentController.updateSelection(index);
                      }),
                    ),
                    SizedBox(width: 50, child: Text(studentItem?.roll??'',
                      style: textRegular.copyWith(),)),
                    ClipRRect(borderRadius: BorderRadius.circular(120),
                        child: CustomImage(width: 25, height: 25,
                            image: "${AppConstants.imageBaseUrl}/users/${studentItem?.user?.image??''}")),
                    Expanded(child: Text("${studentItem?.firstName} ${studentItem?.lastName}",
                      style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),)),
                    Expanded(child: Text(studentItem?.phone??'', style: textRegular.copyWith(),)),
                    SizedBox(width: 50, child: Text(studentItem?.gender??'',
                      style: textRegular.copyWith(),)),
                    Expanded(child: CustomTextField(hintText: "new_roll".tr,
                        controller: studentItem?.newRollController??TextEditingController())),


                  ]),
              const Padding(padding: EdgeInsets.symmetric(vertical:Dimensions.paddingSizeSmall),
                  child: CustomDivider()),
            ],
          ):

          CustomContainer(child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ClipRRect(borderRadius: BorderRadius.circular(120),
                child: CustomImage(width: Dimensions.imageSizeBig,
                    height: Dimensions.imageSizeBig,
                    image: "${AppConstants.imageBaseUrl}/users/${studentItem?.user?.image??''}")),
            const SizedBox(width: Dimensions.paddingSizeSmall),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("${studentItem?.firstName} ${studentItem?.lastName}",
                style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
              Text("${"roll".tr} : ${studentItem?.roll??''}", style: textRegular.copyWith(),),
              Text("${"phone".tr} : ${studentItem?.phone??''}", style: textRegular.copyWith(),),
              const SizedBox(height: Dimensions.paddingSizeExtraSmall),
            ])),
          ],
          )),
        );
      }
    );
  }
}