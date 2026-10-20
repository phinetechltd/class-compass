import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/academic_configuration/class/controller/class_controller.dart';
import 'package:class_compass/feature/academic_configuration/class/presentation/widgets/select_class_widget.dart';
import 'package:class_compass/feature/academic_configuration/period/controller/period_controller.dart';
import 'package:class_compass/feature/academic_configuration/period/presentation/widgets/select_period_section.dart';
import 'package:class_compass/feature/academic_configuration/section/controller/section_controller.dart';
import 'package:class_compass/feature/academic_configuration/section/presentation/widgets/select_section_widget.dart';
import 'package:class_compass/feature/hrm/payroll/controller/payroll_controller.dart';
import 'package:class_compass/feature/reports_management/fees_reports/presentation/widgets/select_year_and_month_widget.dart';
import 'package:class_compass/feature/student_attendance_information/student_attendance/controller/student_attendance_controller.dart';
import 'package:class_compass/feature/student_attendance_information/student_attendance/domain/models/student_attendance_model.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';

class MonthlyAttendanceReportSearchWidget extends StatefulWidget {
  final AttendanceItem? attendanceItem;
  const MonthlyAttendanceReportSearchWidget({super.key, this.attendanceItem});

  @override
  State<MonthlyAttendanceReportSearchWidget> createState() => _MonthlyAttendanceReportSearchWidgetState();
}

class _MonthlyAttendanceReportSearchWidgetState extends State<MonthlyAttendanceReportSearchWidget> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentAttendanceController>(builder: (attendanceController) {

          return Padding(padding: EdgeInsets.symmetric(
              horizontal: ResponsiveHelper.isDesktop(context)?
          Dimensions.paddingSizeDefault : 0 ),
            child: CustomContainer(child: Column(mainAxisSize: MainAxisSize.min, children: [

                 const Row(spacing: Dimensions.paddingSizeDefault, children: [
                  Expanded(child: SelectClassWidget()),
                  Expanded(child: SelectSectionWidget()),
                  Expanded(child: SelectPeriodWidget()),

                ]),

                SelectYearAndMonthWidget(padding: 0,
                 onTap: (){
                   int? classId = Get.find<ClassController>().selectedClassItem?.id;
                   int? sectionId = Get.find<SectionController>().selectedSectionItem?.id;
                  int? period = Get.find<PeriodController>().selectedPeriodItem?.id;
                  String? month = Get.find<PayrollController>().selectedMonth;
                  String? year = Get.find<PayrollController>().selectedYear;
                   if(classId == null || sectionId == null){
                     showCustomSnackBar("select_class_and_section".tr);
                   }else if(period == null){
                      showCustomSnackBar("select_period".tr);
                   }else if(month == null){
                     showCustomSnackBar("select_month".tr);
                   }else if(year == null){
                     showCustomSnackBar("select_year".tr);
                   }
                   else{
                     String monthIndex = (Get.find<PayrollController>()
                         .monthList.indexOf(month) + 1)
                         .toString().padLeft(2, '0');

                     attendanceController.getStudentMonthlyAttendanceReport(
                       classId: classId,
                       sectionId: sectionId,
                       period: period,
                       month: monthIndex,
                       year: year,
                     );
                   }
                 },
                ),
              ],),
            ),
          );
        }
    );
  }
}
