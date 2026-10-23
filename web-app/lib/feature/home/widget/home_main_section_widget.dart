import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/feature/authentication/logic/authentication_controller.dart';
import 'package:class_compass/feature/parent_module/parent_home/presentation/parent_web_home_screen.dart';
import 'package:class_compass/feature/profile/logic/profile_controller.dart';
import 'package:class_compass/feature/home/widget/saas_dashboard_widget.dart';
import 'package:class_compass/feature/report/presentation/screens/web_report_screen.dart';
import 'package:class_compass/feature/student_module/student_home/presentation/student_web_home_screen.dart';
import 'package:class_compass/util/app_constants.dart';


class HomeMainSectionWidget extends StatelessWidget {
  final ScrollController scrollController;
  const HomeMainSectionWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        builder: (profileController) {
          return GetBuilder<AuthenticationController>(
              builder: (authenticationController) {
                String? userType = profileController.profileModel?.data?.role;
                // Wait for the role: building the staff dashboard first fires requests a parent or
                // learner is not allowed to make.
                if (userType == null) {
                  return const Padding(padding: EdgeInsets.symmetric(vertical: 160), child: Center(child: CircularProgressIndicator()));
                }
                return Column(children: [

                  Divider(color: Theme.of(context).hintColor, height: 1, thickness: .25),

                  if(userType == AppConstants.parent)...[
                    const ParentWebHomeScreen()
                  ]else if(userType == AppConstants.studentType)...[
                    const StudentWebHomeScreen()
                  ]else if(userType == AppConstants.sassAdmin)...[
                    const SaasDashboardWidget()
                  ]
                  else...[
                    WebReportScreen(scrollController: scrollController),
                  ],
                ]);
              }
          );
        }
    );
  }
}
