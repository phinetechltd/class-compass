import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/controller/datepicker_controller.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/common/widget/date_selection_widget.dart';
import 'package:class_compass/feature/academic_configuration/class/controller/class_controller.dart';
import 'package:class_compass/feature/academic_configuration/class/presentation/widgets/select_class_widget.dart';
import 'package:class_compass/feature/academic_configuration/section/controller/section_controller.dart';
import 'package:class_compass/feature/academic_configuration/section/presentation/widgets/select_section_widget.dart';
import 'package:class_compass/feature/student_attendance_information/student_attendance/controller/student_attendance_controller.dart';
import 'package:class_compass/feature/student_attendance_information/student_attendance/domain/models/student_attendance_model.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';

class AttendanceReportSearchWidget extends StatefulWidget {
  final AttendanceItem? attendanceItem;
  const AttendanceReportSearchWidget({super.key, this.attendanceItem});

  @override
  State<AttendanceReportSearchWidget> createState() => _AttendanceReportSearchWidgetState();
}

class _AttendanceReportSearchWidgetState extends State<AttendanceReportSearchWidget> {

  TextEditingController greaterThanController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentAttendanceController>(builder: (attendanceController) {

          return Padding(padding: EdgeInsets.symmetric(horizontal: ResponsiveHelper.isDesktop(context)? Dimensions.paddingSizeDefault : 0 ),
            child: CustomContainer(child: Column(mainAxisSize: MainAxisSize.min, children: [

                 Row(spacing: Dimensions.paddingSizeDefault, children: [
                  const Expanded(child: SelectClassWidget()),
                  const Expanded(child: SelectSectionWidget()),
                  Expanded(child: CustomTextField(title: "% Greater-than (Optional)",
                  hintText: "0", controller: greaterThanController)),
                ]),

                Row(spacing: Dimensions.paddingSizeDefault, children: [
                   Expanded(child: DateSelectionWidget(title: "from_date".tr)),
                   Expanded(child: DateSelectionWidget(end: true, title: "to_date".tr)),

                  attendanceController.isLoading? const Center(child: CircularProgressIndicator()):
                  Padding(padding: const EdgeInsets.only(top: 35.0),
                    child: SizedBox(width: 120, height: 40, child: CustomButton(onTap: (){
                      int? classId = Get.find<ClassController>().selectedClassItem?.id;
                      int? sectionId = Get.find<SectionController>().selectedSectionItem?.id;
                      if(classId == null || sectionId == null){
                        showCustomSnackBar("select_class_and_section".tr);
                        return;
                      }else{
                        attendanceController.getStudentAttendanceReport(
                            classId: classId,
                            sectionId: sectionId,
                            percentage: greaterThanController.text,
                            fromDate: Get.find<DatePickerController>().formatedDate,
                            toDate: Get.find<DatePickerController>().formatedEndDate
                        );
                      }


                    }, text: "search".tr))),
                ]),

                const SizedBox(height: Dimensions.paddingSizeSmall),
              ],),
            ),
          );
        }
    );
  }
}
