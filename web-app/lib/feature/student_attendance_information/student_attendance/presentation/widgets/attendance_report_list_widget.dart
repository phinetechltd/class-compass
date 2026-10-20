import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/student_attendance_information/student_attendance/controller/student_attendance_controller.dart';
import 'package:class_compass/feature/student_attendance_information/student_attendance/domain/models/student_attendance_report_model.dart';
import 'package:class_compass/util/dimensions.dart';

class AttendanceReportListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const AttendanceReportListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentAttendanceController>(builder: (attendanceController) {
        final attendanceReportModel = attendanceController.studentAttendanceReportModel;
        final reportData = attendanceReportModel?.data;

        if ((attendanceReportModel != null)) {
          return GenericListSection<AttendanceReportItem>(
          showRouteSection: false,showAction: false,
          sectionTitle: "report".tr,
          headings: const ["name", "present", "absent", "attendance_ratio"],
          scrollController: scrollController,
          isLoading: false,
          totalSize:  0,
          offset: 0,
          onPaginate: (offset) async => {},
          items: reportData ?? [],
          itemBuilder: (item, index) => AttendanceReportItemWidget(index: index, attendanceItem: item),
        );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class AttendanceReportItemWidget extends StatelessWidget {
  final AttendanceReportItem? attendanceItem;
  final int index;
  const AttendanceReportItemWidget({super.key, this.attendanceItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(spacing: Dimensions.paddingSizeSmall, children: [
      NumberingWidget(index: index),
      Expanded(child: Text(attendanceItem?.studentName??"")),
      Expanded(child: Text(attendanceItem?.present.toString()??"")),
      Expanded(child: Text(attendanceItem?.absent.toString()??"")),
      Expanded(child: Text(attendanceItem?.attendanceRatio.toString()??"")),




    ]);
  }
}
