import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/common/widget/custom_floating_button.dart';
import 'package:class_compass/feature/staff_information/staff/presentation/widgets/staff_list_widget.dart';
import 'package:class_compass/feature/staff_information/teacher/presentation/widgets/add_new_teacher_widget.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';

class StaffScreen extends StatefulWidget {
  const StaffScreen({super.key});
  @override
  State<StaffScreen> createState() => _StaffScreenState();
}

class _StaffScreenState extends State<StaffScreen> {

  ScrollController scrollController = ScrollController();


  @override
  Widget build(BuildContext context) {
    return  Scaffold(appBar:  CustomAppBar(title: "staff".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [

        SliverToBoxAdapter(child: Padding(padding:  EdgeInsets.all( ResponsiveHelper.isDesktop(context)? Dimensions.paddingSizeDefault :0 ),
          child: StaffListWidget(scrollController: scrollController,)),)
      ],),

      floatingActionButton: CustomFloatingButton(title: "add".tr, onTap: ()=>Get.dialog(const AddNewTeacherWidget(fromStaff: true)))
    );
  }
}
