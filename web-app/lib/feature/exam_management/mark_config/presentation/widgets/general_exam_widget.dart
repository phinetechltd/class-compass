import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_checkbox.dart';
import 'package:class_compass/feature/exam_management/mark_config/presentation/widgets/general_exam_code_list_widget.dart';
import 'package:class_compass/feature/exam_management/mark_config/controller/mark_config_controller.dart';
import 'package:class_compass/feature/exam_management/mark_config/domain/model/general_exam_model.dart';
import 'package:class_compass/feature/exam_management/mark_config/presentation/widgets/general_exam_list_search_widget.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';

class GeneralExamWidget extends StatefulWidget {
  final ScrollController scrollController;
  const GeneralExamWidget({super.key, required this.scrollController});

  @override
  State<GeneralExamWidget> createState() => _GeneralExamWidgetState();
}

class _GeneralExamWidgetState extends State<GeneralExamWidget> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MarkConfigController>(builder: (markConfigController) {
      GeneralExamModel? generalExamModel = markConfigController.generalExamModel;
      List<Subjects>? subjects = generalExamModel?.data?.subjects;
      List<ClassExams>? classExams = generalExamModel?.data?.classExams;
      List<ExamCodes>? examCodes = generalExamModel?.data?.examCodes;

          return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            child: Column(children: [

              if(ResponsiveHelper.isDesktop(context))...[
                const GeneralExamListSearchWidget(),

                Row(spacing: Dimensions.paddingSizeDefault,crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if(subjects != null && subjects.isNotEmpty)
                    Expanded(flex: 2,child: Column(
                      children: [
                        CustomCheckbox(value: markConfigController.selectedAllExam,
                          title: "subject".tr,onChange: (){
                            markConfigController.toggleAllSubject();
                          },),
                        ListView.builder(
                          shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: subjects.length,
                            itemBuilder: (_, index){
                          return CustomCheckbox(value: subjects[index].isSelected == true,
                            title: subjects[index].subjectName??'',onChange: (){
                            markConfigController.toggleSubject(index);
                            },);
                        }),
                      ],
                    )),


                    if(generalExamModel != null && examCodes != null && examCodes.isNotEmpty)
                    Expanded(flex: 8, child: ExamCodeListWidget(scrollController: scrollController,)),

                    if(classExams != null && classExams.isNotEmpty)
                    Expanded(flex: 2,child: Column(
                      children: [
                        CustomCheckbox(value: markConfigController.selectedAllExam,
                          title: "exam".tr,onChange: (){
                            markConfigController.toggleAllExam();
                          },),

                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: classExams.length,
                            itemBuilder: (_, index){
                              return CustomCheckbox(value: classExams[index].selected == true,
                                title: "${classExams[index].exam?.name}",onChange: (){
                                markConfigController.toggleExam(index);
                                },);
                            }),
                      ],
                    )),


                  ],
                ),

              ],


            ],),
          );
        }
    );
  }
}
