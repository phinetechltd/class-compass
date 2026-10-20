import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/section_header_with_path_widget.dart';
import 'package:class_compass/feature/academic_configuration/class/controller/class_controller.dart';
import 'package:class_compass/feature/academic_configuration/class/presentation/widgets/select_class_widget.dart';
import 'package:class_compass/feature/exam_management/exam_startup/presentation/widgets/select_section_widget.dart';
import 'package:class_compass/feature/routine_management/class_routine/logic/class_routine_controller.dart';
import 'package:class_compass/feature/routine_management/class_routine/presentation/widgets/add_new_class_routine_widget.dart';
import 'package:class_compass/feature/routine_management/class_routine/presentation/widgets/routine_list_widget.dart';
import 'package:class_compass/feature/routine_management/class_routine/presentation/widgets/week_days_list.dart';
import 'package:class_compass/feature/academic_configuration/section/controller/section_controller.dart';

import 'package:class_compass/util/dimensions.dart';


class ClassRoutineWidget extends StatefulWidget {
  const ClassRoutineWidget({super.key});

  @override
  State<ClassRoutineWidget> createState() => _ClassRoutineWidgetState();
}

class _ClassRoutineWidgetState extends State<ClassRoutineWidget> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClassRoutineController>(
        builder: (classRoutineController) {
          return Column(children: [
            SectionHeaderWithPath(sectionTitle: "routine_management".tr,
              pathItems: ["class_routine".tr],
            addNewTitle: "add_new_class_routine".tr,
              onAddNewTap: (){
              Get.dialog(CustomDialogWidget(title: "class_routine".tr,
                  child: const AddNewClassRoutineWidget()));
              },
            ),
              Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: CustomContainer(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                    Row(crossAxisAlignment: CrossAxisAlignment.end,
                      spacing: Dimensions.paddingSizeSmall,children: [

                      const Expanded(child: SelectClassWidget()),
                      const Expanded(child: SelectSectionWidget()),
                      SizedBox(width: 90, child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: CustomButton(onTap: (){
                          int? classId = Get.find<ClassController>().selectedClassItem?.id;
                          int? sectionId = Get.find<SectionController>().selectedSectionItem?.id;
                          if(classId == null){
                            showCustomSnackBar("select_class".tr);
                          }else if(sectionId == null){
                            showCustomSnackBar("select_section".tr);
                          }else{
                            classRoutineController.getClassRoutineList(classId, sectionId);
                          }
                        }, text: "search".tr),
                      )),

                    ],),

                    const WeekDaysList(),
                    const RoutineListWidget(),

                  ],
                  ),
                ),
              ),
            ],
          );
        }
    );
  }
}