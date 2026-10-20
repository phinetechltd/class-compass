
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/feature/course_management/course/presentation/widgets/course_details_widget.dart';

class CourseDetailsScreen extends StatefulWidget {
  final String? courseId;
  const CourseDetailsScreen({super.key, this.courseId});

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  ScrollController scrollController = ScrollController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: "course_details".tr),
        body: CustomWebScrollView(controller: scrollController, slivers: [
          SliverToBoxAdapter(child: CourseDetailsWidget(id: widget.courseId),)
        ],),

    );
  }
}



