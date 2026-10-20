
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/common/widget/section_header_with_path_widget.dart';
import 'package:class_compass/feature/students_information/student/presentation/widgets/add_new_student_widget.dart';
import 'package:class_compass/util/dimensions.dart';

import '../../domain/model/student_model.dart';

class AddNewStudentScreen extends StatefulWidget {
  final StudentItem? studentItem;
  const AddNewStudentScreen({super.key, this.studentItem});

  @override
  State<AddNewStudentScreen> createState() => _AddNewStudentScreenState();
}

class _AddNewStudentScreenState extends State<AddNewStudentScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(title: "add_new_student".tr),
      body: CustomWebScrollView(slivers: [

        SliverToBoxAdapter(child: Column(children: [
            SectionHeaderWithPath(sectionTitle: "student_management".tr,
              pathItems: const ["add_new_student"],),
            const Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
              child: AddNewStudentWidget()),
          ],
        ))
      ],),
    );
  }
}
