import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/feature/administrator/notice/presentation/widgets/notice_list_widget.dart';
import 'package:class_compass/feature/administrator/notice/presentation/widgets/user_log_widget.dart';
import 'package:class_compass/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:class_compass/feature/home/widget/quick_access_widget.dart';
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
import 'package:class_compass/util/styles.dart';

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
    final bool isDesktop = ResponsiveHelper.isDesktop(context);
    const double hPad = 20;

    return Container(
      color: AppColors.backgroundColor,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

        const Padding(
          padding: EdgeInsets.fromLTRB(hPad, hPad, hPad, 0),
          child: DashboardHeadingSectionWidget(),
        ),
        const SizedBox(height: 16),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: hPad),
          child: SummeryNumberWidget(),
        ),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: hPad),
          child: QuickAccessWidget(),
        ),
        const SizedBox(height: 20),

        if (isDesktop)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: hPad),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(flex: 3,
                child: CustomContainer(
                  borderRadius: AppBorderRadius.xl,
                  horizontalPadding: 0, verticalPadding: 0,
                  child: AttendanceSummaryReportWidget(),
                ),
              ),
              SizedBox(width: 16),
              Expanded(flex: 2,
                child: CustomContainer(
                  borderRadius: AppBorderRadius.xl,
                  horizontalPadding: 0, verticalPadding: 0,
                  child: StudentRatioChartWidget(),
                ),
              ),
            ]),
          )
        else
          const Column(children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: hPad),
              child: CustomContainer(
                borderRadius: AppBorderRadius.xl,
                horizontalPadding: 0, verticalPadding: 0,
                child: AttendanceSummaryReportWidget(),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: hPad),
              child: CustomContainer(
                borderRadius: AppBorderRadius.xl,
                horizontalPadding: 0, verticalPadding: 0,
                child: StudentRatioChartWidget(),
              ),
            ),
          ]),

        if (PermissionHelper.hasPermission("fees_management.startup")) ...[
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: hPad),
            child: CustomContainer(
              borderRadius: AppBorderRadius.xl,
              horizontalPadding: 0, verticalPadding: 0,
              child: FeesCollectionOverviewWidget(),
            ),
          ),
        ],

        if (Get.find<ProfileController>().hasPermission("accounting_report.income_statement")) ...[
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: hPad),
            child: CustomContainer(
              borderRadius: AppBorderRadius.xl,
              horizontalPadding: 0, verticalPadding: 0,
              child: DashboardAccountChartWidget(),
            ),
          ),
        ],

        // const DashboardCalenderSection(),

        const SizedBox(height: 28),
        NoticeListWidget(scrollController: widget.scrollController, dashBoardScreen: true),

        const SizedBox(height: Dimensions.paddingSizeDefault),
        UserLogListWidget(dashBoardScreen: true,
            scrollController: widget.scrollController),

        const SizedBox(height: 24),
      ]),
    );
  }
}
