import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/controller/datepicker_controller.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/date_selection_widget.dart';
import 'package:class_compass/common/widget/section_header_with_path_widget.dart';
import 'package:class_compass/feature/academic_configuration/class/controller/class_controller.dart';
import 'package:class_compass/feature/academic_configuration/class/presentation/widgets/select_class_widget.dart';
import 'package:class_compass/feature/academic_configuration/section/controller/section_controller.dart';
import 'package:class_compass/feature/academic_configuration/section/presentation/widgets/select_section_widget.dart';
import 'package:class_compass/feature/sms/sent_sms/logic/sent_sms_controller.dart';
import 'package:class_compass/feature/sms/sent_sms/presentation/widgets/absent_student_list_widget.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:responsive_grid/responsive_grid.dart';

class AbsentSmsScreen extends StatefulWidget {
  const AbsentSmsScreen({super.key});

  @override
  State<AbsentSmsScreen> createState() => _AbsentSmsScreenState();
}

class _AbsentSmsScreenState extends State<AbsentSmsScreen> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "absent_sms".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [
        SliverToBoxAdapter(child: GetBuilder<SentSmsController>(
          builder: (smsSendController) {
            return Column(children: [
              SectionHeaderWithPath(sectionTitle: "absent_sms".tr),
               CustomContainer(
                child: ResponsiveGridList(desiredItemWidth: 200,
                minSpacing: 10,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  const Expanded(child: SelectClassWidget()),
                  const Expanded(child: SelectSectionWidget()),
                  const Expanded(child: DateSelectionWidget()),
                  Column(children: [
                      const SizedBox(height: 29),
                      CustomButton(onTap: (){
                        int? classId = Get.find<ClassController>().selectedClassItem?.id;
                        int? sectionId = Get.find<SectionController>().selectedSectionItem?.id;
                        String date = Get.find<DatePickerController>().formatedDate;
                        if(classId == null){
                          showCustomSnackBar("select_class".tr);
                        }else if(sectionId == null){
                          showCustomSnackBar("select_section");
                        }else{
                          smsSendController.getAbsentStudentList(classId, sectionId, date);
                        }

                      }, text: "search".tr),
                    ],
                  ),
                ]),
              ),
              AbsentStudentListWidget(scrollController: scrollController,),

              Align(alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Row(mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      spacing: Dimensions.paddingSizeDefault, children: [
                    SizedBox(width: 100, child: CustomButton(onTap: (){
                      smsSendController.toggleAllAbsentStudent();
                    }, text: "select_all".tr)),
                    SizedBox(width: 100, child: CustomButton(onTap: (){
                      List<int> students = smsSendController.absentStudentModel?.data
                          ?.where((sms) => sms.selected == true)
                          .map((sms) => sms.studentId!)
                          .toList() ?? [];
                      if(students.isNotEmpty){
                        smsSendController.sendAbsentSms(students);
                      }else{
                        showCustomSnackBar("select_student".tr);
                      }
                    }, text: "send_sms".tr)),
                  ]),
                ),
              ),
            ]);
          }
        ))
      ]),
    );
  }
}
