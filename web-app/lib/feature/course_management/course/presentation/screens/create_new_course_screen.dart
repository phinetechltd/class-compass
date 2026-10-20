import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/feature/course_management/course/domain/model/course_model.dart';
import 'package:class_compass/feature/course_management/course/presentation/widgets/create_new_course_widget.dart';
import 'package:class_compass/util/dimensions.dart';


class CreateNewCourseScreen extends StatefulWidget {
  final CourseItem? courseItem;
  const CreateNewCourseScreen({super.key, this.courseItem});

  @override
  State<CreateNewCourseScreen> createState() => _CreateNewCourseScreenState();
}

class _CreateNewCourseScreenState extends State<CreateNewCourseScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "add_new_course".tr),
      body: CustomWebScrollView(slivers: [

        SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          child: CreateNewCourseWidget(courseItem: widget.courseItem,),
        ),)
      ],),
    );
  }
}
