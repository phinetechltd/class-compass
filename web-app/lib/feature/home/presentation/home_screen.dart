import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/feature/profile/logic/profile_controller.dart';
import 'package:class_compass/feature/home/widget/saas_dashboard_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/app_bar_widget.dart';
import 'package:class_compass/common/widget/body_widget.dart';
import 'package:class_compass/feature/academic_configuration/session/controller/session_controller.dart';
import 'package:class_compass/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:class_compass/feature/dashboard/controller/dashboard_controller.dart';
import 'package:class_compass/feature/home/widget/branch_session_selection_widget.dart';
import 'package:class_compass/feature/home/widget/home_main_section_widget.dart';
import 'package:class_compass/feature/report/logic/dashboard_report_controller.dart';
import 'package:class_compass/feature/student_attendance_information/student_attendance/controller/student_attendance_controller.dart';
import 'package:class_compass/helper/app_color_helper.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {

  Future<void> loadData() async{
    if(Get.find<SessionController>().sessionModel == null){
      Get.find<SessionController>().getSessionList(1);
    }
    if(Get.find<DashboardReportController>().dashboardReportModel == null){
      Get.find<DashboardReportController>().getDashboardData();
    }
    if(Get.find<SystemSettingsController>().generalSettingModel == null){
      Get.find<SystemSettingsController>().getGeneralSetting();
    }
  }


  @override
  void initState() {
    loadData();
    super.initState();
  }
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    if (Get.find<ProfileController>().userType() == AppConstants.sassAdmin) {
      return const Scaffold(body: SafeArea(child: SingleChildScrollView(child: SaasDashboardWidget())));
    }
    return Scaffold(backgroundColor: systemPrimaryColor(),
      body:  RefreshIndicator(onRefresh: () async => loadData(),
        child: BodyWidget(appBar:  const AppBarWidget(showBackButton: false,
            actionWidget: BranchSessionSelectionWidget()),

          body: CustomWebScrollView(controller: Get.find<DashboardController>().scrollController, slivers: [
             SliverToBoxAdapter(child: HomeMainSectionWidget(scrollController: scrollController,),)
          ],),
        ),
      ),
      floatingActionButton: FloatingActionButton(shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(123)),
          onPressed: (){
        Get.find<StudentAttendanceController>().scanQrCode();
          },backgroundColor: systemPrimaryColor(),
          child: const Icon(Icons.qr_code, color: Colors.white)),
    );
  }
}


