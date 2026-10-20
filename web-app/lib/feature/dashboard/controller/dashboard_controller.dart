
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/model/popup_menu_model.dart';
import 'package:class_compass/feature/administrator/notice/presentation/screens/notice_screen.dart';
import 'package:class_compass/feature/dashboard/model/navigation_model.dart';
import 'package:class_compass/feature/fees_management/presentation/fees_managment_screen.dart';
import 'package:class_compass/feature/home/presentation/home_screen.dart';
import 'package:class_compass/feature/parent_module/parent_class_routine/presentation/screens/parent_class_routine_screen.dart';
import 'package:class_compass/feature/parent_module/parent_home/presentation/parent_home_screen.dart';
import 'package:class_compass/feature/parent_module/parent_paid_info/presentation/screens/parent_fees_screen.dart';
import 'package:class_compass/feature/sidebar/presentation/more_screen.dart';
import 'package:class_compass/feature/student_module/student_class_routine/presentation/screens/student_class_routine_screen.dart';
import 'package:class_compass/feature/student_module/student_home/presentation/student_home_screen.dart';
import 'package:class_compass/feature/students_information/student/presentation/screens/add_new_student_screen.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/images.dart';

class DashboardController extends GetxController implements GetxService{
  int _currentTab = 0;
  int get currentTab => _currentTab;

  void resetNavBar() {
    _currentTab = 0;
  }

  void setTabIndex(int index) {

    // if(index == 3 && Get.find<ProfileController>().profileModel?.data?.role?.toLowerCase() == AppConstants.parent.toLowerCase() && ResponsiveHelper.isMobile(Get.context!)){
    //   Get.bottomSheet(const DashboardMenuDialog(), isScrollControlled: true);
    // }else if(index == 4){
    //   Get.bottomSheet(const DashboardMenuDialog(), isScrollControlled: true);
    // }
    // else {
    //
    // }
    _currentTab = index;
    if(!ResponsiveHelper.isDesktop(Get.context!)) {
      update();
    }
  }


  final ScrollController scrollController = ScrollController();

  final List<NavigationModel> item = [
    NavigationModel(name: 'dashboard'.tr, activeIcon: Images.homeActive, inactiveIcon: Images.home, screen: const HomeScreen()),
    NavigationModel(name: 'fees'.tr, activeIcon: Images.fees, inactiveIcon: Images.fees, screen: const FeesManagementScreen()),
    NavigationModel(name: 'student'.tr, activeIcon: Images.add, inactiveIcon: Images.add, screen: const AddNewStudentScreen()),
    NavigationModel(name: 'notice'.tr, activeIcon: Images.notice, inactiveIcon: Images.notice, screen: const NoticeScreen()),
    NavigationModel(name: 'menu'.tr, activeIcon: Images.menuIcon, inactiveIcon: Images.menuIcon, screen: const MoreScreen()),

  ];

  final List<NavigationModel> parentsItem = [
    NavigationModel(name: 'dashboard'.tr, activeIcon: Images.homeRouteIcon, inactiveIcon: Images.homeRouteIcon, screen: const ParentHomeScreen()),
    NavigationModel(name: 'routine'.tr, activeIcon: Images.routine, inactiveIcon: Images.routine, screen: const ParentClassRoutineScreen()),
    NavigationModel(name: 'fees'.tr, activeIcon: Images.fees, inactiveIcon: Images.fees, screen: const ParentFeesScreen()),
    NavigationModel(name: 'menu'.tr, activeIcon: Images.menuIcon, inactiveIcon: Images.menuIcon, screen: const MoreScreen()),
  ];

  final List<NavigationModel> studentsItem = [
    NavigationModel(name: 'dashboard'.tr, activeIcon: Images.homeRouteIcon, inactiveIcon: Images.homeRouteIcon, screen: const StudentHomeScreen()),
    NavigationModel(name: 'routine'.tr, activeIcon: Images.routine, inactiveIcon: Images.routine, screen: const StudentClassRoutineScreen()),
    NavigationModel(name: 'fees'.tr, activeIcon: Images.fees, inactiveIcon: Images.fees, screen: const ParentFeesScreen()),
    NavigationModel(name: 'menu'.tr, activeIcon: Images.menuIcon, inactiveIcon: Images.menuIcon, screen: const MoreScreen()),
  ];

  List<PopupMenuModel> getPopupMenuList({bool subscription = false,
    bool approve = false, bool editDelete = false,
    bool sendSms = false, bool language = false,
    bool course = false, bool institute = false}) {
    if(editDelete){
      return [
        PopupMenuModel(title: "edit".tr, icon: Icons.edit),
        PopupMenuModel(title: "delete".tr, icon: Icons.delete_forever),
      ];

    }else if(approve){
      return [
        PopupMenuModel(title: "approve".tr, icon: Icons.check),
        PopupMenuModel(title: "decline".tr, icon: Icons.clear),
      ];

    }else if(sendSms){
      return [
        PopupMenuModel(title: "send_sms".tr, icon: Icons.send),
        PopupMenuModel(title: "decline".tr, icon: Icons.clear),
      ];

    }else if(subscription){
      return [
        PopupMenuModel(title: "subscription_upgrade_request".tr, icon: Icons.request_quote),
        PopupMenuModel(title: "payment".tr, icon: Icons.payment),
      ];

    } else if(course){
      return [
        PopupMenuModel(title: "view".tr, icon: Icons.remove_red_eye_outlined),
        PopupMenuModel(title: "edit".tr, icon: Icons.edit),
        PopupMenuModel(title: "delete".tr, icon: Icons.delete_forever),
      ];

    }else if(institute){
      return [
        PopupMenuModel(title: "upgrade_subscription".tr, icon: Icons.update),

      ];

    }else if(language){
      return [
        PopupMenuModel(title: "set_default".tr, icon: Icons.check),
        PopupMenuModel(title: "delete".tr, icon: Icons.delete),
        PopupMenuModel(title: "view".tr, icon: Icons.remove_red_eye),

      ];

    }else {
      return [
        PopupMenuModel(title: "edit".tr, icon: Icons.edit),
        PopupMenuModel(title: "delete".tr, icon: Icons.delete_forever),
      ];
    }

  }
}
