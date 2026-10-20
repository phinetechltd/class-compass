import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/common/widget/section_header_with_path_widget.dart';
import 'package:class_compass/feature/student_attendance_information/student_attendance/presentation/widgets/monthly_attendance_report_list_widget.dart';
import 'package:class_compass/feature/student_attendance_information/student_attendance/presentation/widgets/monthly_attendance_report_search_widget.dart';

class MonthlyAttendanceReportScreen extends StatefulWidget {

  const MonthlyAttendanceReportScreen({super.key});

  @override
  State<MonthlyAttendanceReportScreen> createState() => _MonthlyAttendanceReportScreenState();
}

class _MonthlyAttendanceReportScreenState extends State<MonthlyAttendanceReportScreen> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "attendance_report".tr),
      body: CustomWebScrollView(controller: scrollController, slivers:  [

        SliverToBoxAdapter(child: Column(children: [
          SectionHeaderWithPath(sectionTitle: "student_attendance_information".tr,
              pathItems: ["monthly_attendance_report".tr]),
          const MonthlyAttendanceReportSearchWidget(),
          const MonthlyAttendanceReportListWidget()

        ]))
      ],),
    );
  }
}
