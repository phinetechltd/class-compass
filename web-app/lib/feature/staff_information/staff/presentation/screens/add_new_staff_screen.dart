
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/common/widget/section_header_with_path_widget.dart';
import 'package:class_compass/feature/staff_information/teacher/presentation/widgets/add_new_teacher_widget.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';

class AddNewStaffScreen extends StatefulWidget {
  const AddNewStaffScreen({super.key, });

  @override
  State<AddNewStaffScreen> createState() => _AddNewStaffScreenState();
}

class _AddNewStaffScreenState extends State<AddNewStaffScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResponsiveHelper.isDesktop(context)? null : CustomAppBar(title: "add_new_staff".tr),
      body: CustomWebScrollView(slivers: [

        SliverToBoxAdapter(child: Column(
          children: [
            SectionHeaderWithPath(sectionTitle: "staff_information".tr,
            pathItems: ["add_new_staff".tr],),
            const Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: AddNewTeacherWidget(fromStaff: true)),
          ],
        ))
      ],),
    );
  }
}
