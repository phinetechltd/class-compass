import 'package:flutter/material.dart';
import 'package:class_compass/common/widget/custom_item_text_widget.dart';
import 'package:class_compass/feature/student_attendance_information/student_attendance/domain/models/monthly_student_attendance_report_model.dart';
import 'package:class_compass/helper/day_name_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class MonthlyAttendanceReportHeaderSection extends StatelessWidget {
  final MonthlyAttendanceItem? item;
  const MonthlyAttendanceReportHeaderSection({super.key, this.item});

  @override
  Widget build(BuildContext context) {
    final attendanceList = item?.report?.first.attendance ?? [];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Fixed columns header
        const SizedBox(
          width: 280,
          child: Row(
            spacing: Dimensions.paddingSizeSmall,
            children: [
              CustomItemTextWidget(text: "ID"),
              SizedBox(width: 100, child: CustomItemTextWidget(text: "Name")),
              CustomItemTextWidget(text: "Roll"),
              CustomItemTextWidget(text: "Phone"),
            ],
          ),
        ),

        // Attendance date headers
        Row(
          children: attendanceList.asMap().entries.map((entry) {
            final index = entry.key;
            final attendance = entry.value;

            return Row(
              children: [
                SizedBox(
                  width: 30,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        (index + 1).toString().padLeft(2, '0'),
                        style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                      ),
                      Text(
                        getDayNameFromDate(attendance.date ?? ''),
                        style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                      ),
                    ],
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
          }).toList(),
        ),
      ],
    );
  }
}