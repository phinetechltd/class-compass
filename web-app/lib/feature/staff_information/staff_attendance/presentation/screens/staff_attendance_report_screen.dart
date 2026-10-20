import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/common/widget/section_header_with_path_widget.dart';
import 'package:class_compass/feature/staff_information/staff_attendance/presentation/widgets/staff_attendance_report_list_widget.dart';
import 'package:class_compass/feature/staff_information/staff_attendance/presentation/widgets/staff_attendance_report_search_widget.dart';

class StaffAttendanceReportScreen extends StatefulWidget {

  const StaffAttendanceReportScreen({super.key});

  @override
  State<StaffAttendanceReportScreen> createState() => _StaffAttendanceReportScreenState();
}

class _StaffAttendanceReportScreenState extends State<StaffAttendanceReportScreen> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "staff_attendance_report".tr),
      body: CustomWebScrollView(controller: scrollController, slivers:  [

        SliverToBoxAdapter(child: Column(children: [
          SectionHeaderWithPath(sectionTitle: "staff_information".tr,
              pathItems: ["staff_attendance_report".tr]),
          const StaffAttendanceReportSearchWidget(),
          StaffAttendanceReportListWidget(scrollController: scrollController)

        ]))
      ],),
    );
  }
}
