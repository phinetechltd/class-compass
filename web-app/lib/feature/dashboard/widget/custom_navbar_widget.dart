

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/custom_navbar/circle_nav_bar.dart';
import 'package:class_compass/feature/dashboard/controller/dashboard_controller.dart';
import 'package:class_compass/feature/dashboard/model/navigation_model.dart';
import 'package:class_compass/feature/profile/logic/profile_controller.dart';
import 'package:class_compass/helper/app_color_helper.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class CustomNavbarWidget extends StatelessWidget {
  const CustomNavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (menuController) {
        return GetBuilder<ProfileController>(
          builder: (profileController) {
            String? userType = profileController.profileModel?.data?.role;

            List<NavigationModel> item = [];
            if(userType?.toLowerCase() == AppConstants.parent.toLowerCase()) {
              item = menuController.parentsItem;
            }else if(userType?.toLowerCase() == AppConstants.studentType.toLowerCase()) {
              item = menuController.studentsItem;
            } else {
              item = menuController.item;
            }
            return CircleNavBar(activeIndex: menuController.currentTab,
              onTap: (index) {
                menuController.setTabIndex(index);
              },
              height: 75,
              circleWidth: 60,
              color: Theme.of(context).cardColor,
              circleColor: systemPrimaryColor(),
              shadowColor: Colors.black26,
              circleShadowColor: Colors.black38,
              elevation: 10,
              activeIcons: [
                for (var i in item)
                  Image.asset(i.activeIcon, height: 20, color: Colors.white),
              ],


              inactiveIcons: [
                for (var i in item)
                  Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Image.asset(i.inactiveIcon, height: 28, color: Theme.of(context).hintColor,),
                      const SizedBox(height: 4),
                      Text(i.name, style: textRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall)),
                    ]),
              ],

              activeLevelsStyle: textMedium.copyWith(color: systemPrimaryColor(), fontSize: Dimensions.fontSizeSmall),
              inactiveLevelsStyle: textRegular.copyWith(color: Colors.grey, fontSize: Dimensions.fontSizeSmall),
            );
          }
        );
      }
    );
  }
}
