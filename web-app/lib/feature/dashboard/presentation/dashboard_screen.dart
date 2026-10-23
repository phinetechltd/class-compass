

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/animated_custom_dialog.dart';
import 'package:class_compass/common/widget/confirmation_dialog_widget.dart';
import 'package:class_compass/feature/authentication/logic/authentication_controller.dart';
import 'package:class_compass/feature/dashboard/controller/dashboard_controller.dart';
import 'package:class_compass/feature/dashboard/model/navigation_model.dart';
import 'package:class_compass/feature/dashboard/widget/custom_navbar_widget.dart';
import 'package:class_compass/feature/home/presentation/web_hom_screen.dart';
import 'package:class_compass/feature/profile/logic/profile_controller.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/images.dart';



class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  // FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
  final PageStorageBucket bucket = PageStorageBucket();


  @override
  void initState() {
    Get.find<DashboardController>().setTabIndex(0);
    if(Get.find<ProfileController>().profileModel == null) {
      Get.find<ProfileController>().getProfileInfo();
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return PopScope(canPop: false,
      onPopInvokedWithResult: (didPop, dynamic) async {
        _onWillPop(context);
        return;
      },
      child: GetBuilder<DashboardController>(builder: (menuController) {
        return GetBuilder<AuthenticationController>(
          builder: (authController) {
            return GetBuilder<ProfileController>(
              builder: (profileController) {
                String? userType = profileController.profileModel?.data?.role;
                if (userType == null && !ResponsiveHelper.isDesktop(context)) {
                  return const Scaffold(body: Center(child: CircularProgressIndicator()));
                }

                final List<NavigationModel> item = menuController.itemsFor(userType, profileController.profileModel?.data?.permissions ?? const []);
                return Scaffold(resizeToAvoidBottomInset: false,
                  body: ResponsiveHelper.isDesktop(context)? const WebHomScreen() : PageStorage(bucket: bucket, child: item[menuController.currentTab.clamp(0, item.length - 1)].screen),

                  bottomNavigationBar: ResponsiveHelper.isDesktop(context)? const SizedBox() :
                  const CustomNavbarWidget(),

                );
              }
            );
          }
        );
      }),
    );
  }


}
Future<bool> _onWillPop(BuildContext context) async {
  showAnimatedDialog(context,  ConfirmationDialogWidget(icon: Images.logo,
    title: 'exit_app'.tr,
    description: 'do_you_want_to_exit_the_app'.tr, onYesPressed: (){
      SystemNavigator.pop();
    },),isFlip: true);
  return true;
}


