import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/feature/parent_module/parent_paid_info/controller/parent_paid_info_controller.dart';
import 'package:class_compass/feature/parent_module/parent_class_routine/logic/parent_class_routine_controller.dart';
import 'package:class_compass/feature/parent_module/parent_profile/logic/parent_profile_controller.dart';
import 'package:class_compass/feature/parent_module/parent_class_routine/presentation/widgets/parent_routine_list_widget.dart';
import 'package:class_compass/feature/parent_module/parent_paid_info/presentation/widgets/parent_fees_overview_widget.dart';
import 'package:class_compass/feature/parent_module/parents/presentation/widget/dashboard_summary.dart';
import 'package:class_compass/feature/home/widget/quick_access_widget.dart';
import 'package:class_compass/feature/student_module/student_profile/domain/model/student_profile_model.dart';
import 'package:class_compass/feature/student_module/student_profile/logic/student_profile_controller.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class StudentWebHomeScreen extends StatefulWidget {
  const StudentWebHomeScreen({super.key});

  @override
  State<StudentWebHomeScreen> createState() => _StudentWebHomeScreenState();
}

class _StudentWebHomeScreenState extends State<StudentWebHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentProfileController>(
      initState: (val){
        // A refresh skips the login screen, so load the learner's own data here.
        if (Get.find<StudentProfileController>().profileModel == null) {
          Get.find<StudentProfileController>().getStudentProfileInfo();
        }
        Get.find<ParentProfileController>().getDashboardData();
        Get.find<ParentClassRoutineController>().getClassRoutineList();
        Get.find<ParentPaidInfoController>().getPaidFeeInfoList();
        Get.find<ParentPaidInfoController>().getUnPaidReport();
      },
      builder: (profileController) {
       StudentProfileModel ? profileModel = profileController.profileModel;
        return Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("${"welcome_back".tr} ${profileModel?.data?.name??'N/A'}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge),),
            Text("here_a_quick".tr, style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).hintColor),),

            const SizedBox(height: Dimensions.paddingSizeDefault),
            const QuickAccessWidget(),
            const SizedBox(height: Dimensions.paddingSizeDefault),

            const DashboardSummarySection(),
            const SizedBox(height: Dimensions.paddingSizeDefault),

            const ParentFeesOverviewWidget(),

            const SizedBox(height: Dimensions.paddingSizeDefault),
            const ParentRoutineListWidget(),


          ]),
        );
      }
    );
  }
}
