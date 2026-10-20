import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/feature/administrator/notice/presentation/widgets/notice_list_widget.dart';
import 'package:class_compass/feature/administrator/notice/presentation/widgets/user_log_widget.dart';
import 'package:class_compass/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:class_compass/feature/profile/logic/profile_controller.dart';
import 'package:class_compass/feature/report/logic/dashboard_report_controller.dart';
import 'package:class_compass/feature/report/presentation/widgets/account_summery.dart';
import 'package:class_compass/feature/report/presentation/widgets/attendance_summery_report_widget.dart';
import 'package:class_compass/feature/report/presentation/widgets/dashboard_heading_section_widget.dart';
import 'package:class_compass/feature/report/presentation/widgets/fees_collection_overview_summery_widget.dart';
import 'package:class_compass/feature/report/presentation/widgets/student_ratio_chart.dart';
import 'package:class_compass/feature/report/presentation/widgets/summery_number_widget.dart';
import 'package:class_compass/feature/academic_configuration/session/controller/session_controller.dart';
import 'package:class_compass/helper/permission_helper.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';

class WebReportScreen extends StatefulWidget {
  final ScrollController scrollController;
  const WebReportScreen({super.key, required this.scrollController});

  @override
  State<WebReportScreen> createState() => _WebReportScreenState();
}

class _WebReportScreenState extends State<WebReportScreen> {
  @override
  void initState() {
    if(Get.find<SessionController>().sessionModel == null){
      Get.find<SessionController>().getSessionList(1);
    }
    if(Get.find<DashboardReportController>().dashboardReportModel == null){
      Get.find<DashboardReportController>().getDashboardData();
    }
    if(Get.find<SystemSettingsController>().generalSettingModel == null){
      Get.find<SystemSettingsController>().getGeneralSetting();
    }

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Column(crossAxisAlignment: CrossAxisAlignment.start,children: [

      const Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
        child: DashboardHeadingSectionWidget(),
      ),
      const Padding(
        padding: EdgeInsets.symmetric( horizontal: Dimensions.paddingSizeDefault),
        child: SummeryNumberWidget(),
      ),
       ResponsiveHelper.isDesktop(context)?
      const Row(spacing: Dimensions.paddingSizeDefault, children: [
        Expanded(child: Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: CustomContainer(child: AttendanceSummaryReportWidget()))),

        Padding(padding: EdgeInsets.fromLTRB(0, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault),
          child: CustomContainer(child: StudentRatioChartWidget())),
      ],):const Column(spacing: Dimensions.paddingSizeDefault, children: [
         Padding(padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
             child: CustomContainer(child: AttendanceSummaryReportWidget())),

         Padding(padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
             child: CustomContainer(child: StudentRatioChartWidget())),
       ],),

      if(PermissionHelper.hasPermission("fees_management.startup"))
      const Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
        child: CustomContainer(child: FeesCollectionOverviewWidget()),
      ),
      if(Get.find<ProfileController>().hasPermission("accounting_report.income_statement"))
      const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: CustomContainer(child: DashboardAccountChartWidget())),

      // const DashboardCalenderSection(),



      const SizedBox(height: Dimensions.paddingSizeDefault,),
      NoticeListWidget(scrollController: widget.scrollController, dashBoardScreen: true),

     const SizedBox(height: Dimensions.paddingSizeDefault),
     UserLogListWidget(dashBoardScreen: true,
         scrollController: widget.scrollController),
    ],);
  }
}
