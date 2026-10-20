import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_divider.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/heading_menu_widget.dart';
import 'package:class_compass/common/widget/no_data_found.dart';
import 'package:class_compass/common/widget/section_header_with_path_widget.dart';
import 'package:class_compass/feature/academic_configuration/class/controller/class_controller.dart';
import 'package:class_compass/feature/academic_configuration/class/presentation/widgets/select_class_widget.dart';
import 'package:class_compass/feature/exam_management/exam/controller/exam_controller.dart';
import 'package:class_compass/feature/exam_management/exam/presentation/widgets/exam_selection_widget.dart';
import 'package:class_compass/feature/academic_configuration/group/controller/group_controller.dart';
import 'package:class_compass/feature/academic_configuration/group/presentation/widgets/select_group_widget.dart';
import 'package:class_compass/feature/routine_management/exam_routine/controller/exam_routine_controller.dart';
import 'package:class_compass/feature/routine_management/exam_routine/domain/model/exam_routine_body.dart';
import 'package:class_compass/feature/routine_management/exam_routine/presentation/widgets/exam_routine_item_widget.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';


class ExamRoutineWidget extends StatefulWidget {
  const ExamRoutineWidget({super.key});

  @override
  State<ExamRoutineWidget> createState() => _ExamRoutineWidgetState();
}

class _ExamRoutineWidgetState extends State<ExamRoutineWidget> {
 
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExamRoutineController>(
      builder: (examRoutineController) {
        final examRoutine = examRoutineController.examRoutineItemBodyList;
        return Column(children: [
            SectionHeaderWithPath(sectionTitle: "routine_management".tr,
              pathItems: ["exam_routine".tr],),
            Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
              child: CustomContainer(
                child: Column(children: [

                  Row(spacing: Dimensions.paddingSizeDefault,crossAxisAlignment: CrossAxisAlignment.end, children: [
                    const Expanded(child: ExamSelectionWidget()),
                    const Expanded(child: SelectClassWidget()),
                    const Expanded(child: SelectGroupWidget()),
                    SizedBox(width: 90, child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: examRoutineController.isLoading?
                          const Center(child: CircularProgressIndicator()):
                      CustomButton(onTap: (){
                        int? classId =  Get.find<ClassController>().selectedClassItem?.id;
                        int? examId = Get.find<ExamController>().selectedExamItem?.id;
                        int? groupId = Get.find<GroupController>().groupItem?.id;
                        if(classId == null){
                          showCustomSnackBar("select_class".tr);
                        }else if(examId == null){
                          showCustomSnackBar("select_exam".tr);
                        }else if(groupId == null){
                          showCustomSnackBar("select_group".tr);
                        }else {
                          examRoutineController.getExamRoutineList(classId, examId, groupId);
                        }
                      }, text: "search".tr),
                    )),

                  ],),

                  const SizedBox(height: Dimensions.paddingSizeDefault),

                if(ResponsiveHelper.isDesktop(context) && (examRoutine != null))
                  const HeadingMenu(headings: ["subject", "date", "start_time", "end_time", "room"], showActionOption: false),

                if(examRoutine != null)
                GetBuilder<ExamRoutineController>(builder: (examRoutineController) {

                  return (examRoutine.isNotEmpty)?
                  ListView.separated(
                    itemCount: examRoutine.length,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index){
                      return ExamRoutineItemWidget(examRoutineItem: examRoutine[index], index: index);
                      }, separatorBuilder: (BuildContext context, int index) {
                      return const CustomDivider();
                      },) :
                  Padding(padding: ThemeShadow.getPadding(), child: const Center(child: NoDataFound()),);
                }),

                  if(examRoutine != null)
                  Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                    child: Align(alignment: Alignment.centerRight,
                      child: SizedBox(width: 90, child: examRoutineController.isLoading?
                      const Center(child: CircularProgressIndicator()):
                      CustomButton(onTap: (){
                        int? classId =  Get.find<ClassController>().selectedClassItem?.id;
                        int? examId = Get.find<ExamController>().selectedExamItem?.id;
                        int? groupId = Get.find<GroupController>().groupItem?.id;
                        List<SubjectIds> subjectIds = [];
                        for(int i = 0; i < examRoutine.length; i++){
                          subjectIds.add(SubjectIds(
                            subjectId: int.parse(examRoutine[i].subjectId),
                            date: examRoutine[i].dateController.text,
                            startTime: examRoutine[i].startTimeController.text,
                            endTime: examRoutine[i].endTimeController.text,
                            room: examRoutine[i].roomController.text,
                          ));
                        }

                        if(classId == null){
                          showCustomSnackBar("select_class".tr);
                        }
                        else if(examId == null){
                          showCustomSnackBar("select_exam".tr);
                        }
                        else if(groupId == null){
                          showCustomSnackBar("select_group".tr);
                        }
                        else if(subjectIds.isEmpty){
                          showCustomSnackBar("add_at_least_one_routine".tr);
                        }
                        else{
                          ExamRoutineBody body = ExamRoutineBody(
                            classId: classId.toString(),
                            groupId: groupId.toString(),
                            examId: examId.toString(),
                            subjectIds: subjectIds,
                          );
                          examRoutineController.storeExamRoutine(body);

                        }
                      }, text: "Save".tr)),
                    ),
                  )
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
