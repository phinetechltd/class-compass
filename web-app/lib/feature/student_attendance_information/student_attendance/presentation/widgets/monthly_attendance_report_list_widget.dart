import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_divider.dart';
import 'package:class_compass/common/widget/custom_item_text_widget.dart';
import 'package:class_compass/feature/student_attendance_information/student_attendance/controller/student_attendance_controller.dart';
import 'package:class_compass/feature/student_attendance_information/student_attendance/presentation/widgets/monthly_attendance_report_header_section.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class MonthlyAttendanceReportListWidget extends StatelessWidget {
  const MonthlyAttendanceReportListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentAttendanceController>(builder: (reportController) {
      final item = reportController.monthlyStudentAttendanceReportModel?.data;

      if (item == null || item.report == null || item.report!.isEmpty) {
        return const SizedBox();
      }

      return Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: CustomContainer(
          showShadow: false,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  MonthlyAttendanceReportHeaderSection(item: item),
                  const CustomDivider(),

                  // Student rows
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: item.report!.map((report) {
                      return Padding(padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [

                          SizedBox(width: 280,
                            child: Row(spacing: Dimensions.paddingSizeSmall, children: [
                              CustomItemTextWidget(text: "${report.studentId ?? 0}"),
                              SizedBox(width: 100,
                                child: CustomItemTextWidget(text: report.studentName ?? '')),
                              CustomItemTextWidget(text: "${report.roll ?? 0}"),
                              Expanded(child: CustomItemTextWidget(text: "${report.studentPhone ?? 0}")),
                            ])),


                          Row(children: report.attendance?.map((att) {
                            return Row(
                              children: [
                                SizedBox(width: 30,
                                  child: Center(child: Text(att.status ?? '',
                                    style: textBold.copyWith(color: att.status?.toLowerCase() == 'p'
                                        ? Colors.green : Colors.red)),
                                      ),
                                    ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 2),
                                    child: Container(
                                      width: 1,
                                      height: 20,
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                              ],
                            );
                              }).toList() ??
                                  [],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}