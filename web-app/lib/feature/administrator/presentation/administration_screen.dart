import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/common/widget/sub_menu_item_widget.dart';
import 'package:class_compass/feature/administrator/event/presentation/screens/event_screen.dart';
import 'package:class_compass/feature/administrator/notice/presentation/screens/notice_screen.dart';
import 'package:class_compass/feature/menu_section/controller/menu_type_controller.dart';
import 'package:class_compass/feature/students_information/student/presentation/screens/student_screen.dart';
import 'package:class_compass/feature/students_information/student_migration/presentation/screens/student_migration_screen.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/images.dart';


class AdministrationScreen extends StatefulWidget {
  const AdministrationScreen({super.key});

  @override
  State<AdministrationScreen> createState() => _AdministrationScreenState();
}

class _AdministrationScreenState extends State<AdministrationScreen> {
  List<MainMenuModel> studentInformationItems = [
    MainMenuModel(icon: Images.purchase, title: 'assign_shift', widget:  const StudentScreen()),
    MainMenuModel(icon: Images.productReturn, title: 'assign_subject', widget:  const StudentMigrationScreen()),
    MainMenuModel(icon: Images.productReturn, title: 'assign_class', widget:  const StudentMigrationScreen()),
    MainMenuModel(icon: Images.productReturn, title: 'notice', widget:  const NoticeScreen()),
    MainMenuModel(icon: Images.productReturn, title: 'event', widget:  const EventScreen()),
    MainMenuModel(icon: Images.productReturn, title: 'contact_message', widget:  const StudentScreen()),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: "academic_configuration".tr,),
        body: CustomWebScrollView(slivers: [
          SliverToBoxAdapter(child:Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
            child: ListView.builder(
                itemCount: studentInformationItems.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (context, index){
                  return InkWell(onTap: ()=> Get.to(studentInformationItems[index].widget),
                      child: SubMenuItemWidget(icon: studentInformationItems[index].icon, title: studentInformationItems[index].title)
                  );
                }),
          ),)
        ],)
    );
  }
}
