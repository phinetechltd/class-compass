import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/feature/parent_module/parent_paid_info/controller/parent_paid_info_controller.dart';
import 'package:class_compass/feature/parent_module/parent_paid_info/presentation/widgets/parent_fees_overview_widget.dart';
import 'package:class_compass/feature/parent_module/parents/presentation/widget/dashboard_summary.dart';
import 'package:class_compass/feature/student_module/student_class_routine/logic/student_class_routine_controller.dart';
import 'package:class_compass/feature/student_module/student_profile/logic/student_profile_controller.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';


class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key});
  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}


class _StudentHomeScreenState extends State<StudentHomeScreen> {
  @override
  void initState() {
    Get.find<StudentProfileController>().getStudentProfileInfo();
    Get.find<StudentClassRoutineController>().getClassRoutineList();
    Get.find<ParentPaidInfoController>().getPaidFeeInfoList();
    Get.find<ParentPaidInfoController>().getUnPaidReport();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {FocusScope.of(context).unfocus();});
    return Scaffold(
      appBar: const CustomAppBar(showBakButton: false,
          centerTitle: false),
      body: CustomWebScrollView(
        slivers:  [


          SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.only(top:Dimensions.paddingSizeDefault,left: Dimensions.paddingSize, right: Dimensions.paddingSize),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeDefault, children: [
                Text("welcome_back".tr, style: textMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge),),
                Text("here_a_quick".tr, style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).hintColor),),

                const DashboardSummarySection(),

                const ParentFeesOverviewWidget(),
                const SizedBox(height: Dimensions.paddingSizeTiny)


              ])))
        ],),
    );
  }
}


