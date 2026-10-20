import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:class_compass/feature/authentication/logic/authentication_controller.dart';
import 'package:class_compass/feature/profile/logic/profile_controller.dart';
import 'package:class_compass/feature/sidebar/controller/side_menu_bar_controller.dart';
import 'package:class_compass/helper/app_color_helper.dart';
import 'package:class_compass/helper/route_helper.dart';
import 'package:class_compass/util/images.dart';
import 'package:class_compass/util/styles.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  void initState() {
    super.initState();
    if(Get.find<ProfileController>().profileModel == null){
      Get.find<ProfileController>().getProfileInfo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Get.find<SystemSettingsController>().sidebarColor,
      appBar: CustomAppBar(title: "more".tr, showBakButton: false),
      body: GetBuilder<SideMenuBarController>(
        builder: (controller) {
          return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

            Expanded(child: SingleChildScrollView(child: Column(
              children: [
                ...controller.sideMenuItems,
              ]))),

            ListTile(leading: SizedBox(width: 30, child: Image.asset(Images.logout,
              color: systemPrimaryColor(),)),
              title: Text("logout".tr, style: textRegular.copyWith(color: Get.find<SystemSettingsController>().sidebarTextColor)),
              onTap: (){
              Get.find<AuthenticationController>().clearSharedData();
              Get.offAllNamed(RouteHelper.getSignInRoute());

              },
            ),

          ]);
        }
      ),
    );
  }
}


