import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/staff_information/staff_attendance/controller/staff_attendance_controller.dart';
import 'package:class_compass/feature/staff_information/staff_attendance/domain/models/staff_attendance_report_model.dart';
import 'package:class_compass/feature/staff_information/staff_attendance/presentation/widgets/attendance_log_widget.dart';
import 'package:class_compass/util/dimensions.dart';

class StaffAttendanceReportListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const StaffAttendanceReportListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StaffAttendanceController>(builder: (attendanceController) {
        final attendanceReportModel = attendanceController.staffAttendanceReportModel;
        final reportData = attendanceReportModel?.data;

        if ((attendanceReportModel != null)) {
          return GenericListSection<StaffAttendanceReportItem>(
          showRouteSection: false,
          sectionTitle: "report".tr,
          headings: const ["name", "role","present", "absent", "leave"],
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
  final StaffAttendanceReportItem? attendanceItem;
  final int index;
  const AttendanceReportItemWidget({super.key, this.attendanceItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(spacing: Dimensions.paddingSizeSmall, children: [
      NumberingWidget(index: index),
      Expanded(child: Text(attendanceItem?.name??"")),
      Expanded(child: Text(attendanceItem?.role??"")),
      Expanded(child: Text(attendanceItem?.present.toString()??"")),
      Expanded(child: Text(attendanceItem?.absent.toString()??"")),
      Expanded(child: Text(attendanceItem?.onLeave.toString()??"")),
      IconButton(onPressed: (){
        Get.dialog(CustomDialogWidget(title: "logs".tr,
            child: AttendanceLogWidget(attendanceItem: attendanceItem)));
      },
          icon: Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Theme.of(context).hintColor))
    ]);
  }
}
