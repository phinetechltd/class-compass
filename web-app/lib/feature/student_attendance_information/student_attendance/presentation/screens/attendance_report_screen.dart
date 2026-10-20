import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/common/widget/section_header_with_path_widget.dart';
import 'package:class_compass/feature/student_attendance_information/student_attendance/presentation/widgets/attendance_report_list_widget.dart';
import 'package:class_compass/feature/student_attendance_information/student_attendance/presentation/widgets/attendance_report_search_widget.dart';

class AttendanceReportScreen extends StatefulWidget {

  const AttendanceReportScreen({super.key});

  @override
  State<AttendanceReportScreen> createState() => _AttendanceReportScreenState();
}

class _AttendanceReportScreenState extends State<AttendanceReportScreen> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "attendance_report".tr),
      body: CustomWebScrollView(controller: scrollController, slivers:  [

        SliverToBoxAdapter(child: Column(children: [
          SectionHeaderWithPath(sectionTitle: "student_attendance_information".tr,
              pathItems: ["attendance_report".tr]),
          const AttendanceReportSearchWidget(),
          AttendanceReportListWidget(scrollController: scrollController)

        ]))
      ],),
    );
  }
}
