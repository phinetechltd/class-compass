
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/common/widget/custom_floating_button.dart';
import 'package:class_compass/feature/course_management/course/presentation/screens/create_new_course_screen.dart';
import 'package:class_compass/feature/course_management/course/presentation/widgets/course_list_widget.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "course".tr),
        body: CustomWebScrollView(controller: scrollController, slivers: [

          SliverToBoxAdapter(child: CourseListWidget(scrollController: scrollController),)
        ],),


        floatingActionButton: CustomFloatingButton(title: "add",
            onTap: ()=> Get.to(()=> const CreateNewCourseScreen()))
    );
  }
}




