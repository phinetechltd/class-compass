import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/feature/course_management/lesson/presentation/widgets/create_new_lesson_widget.dart';


class CreateNewLessonScreen extends StatefulWidget {
  const CreateNewLessonScreen({super.key});

  @override
  State<CreateNewLessonScreen> createState() => _CreateNewLessonScreenState();
}

class _CreateNewLessonScreenState extends State<CreateNewLessonScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "add_new_lesson".tr),
      body: const CustomWebScrollView(slivers: [

        SliverToBoxAdapter(child: CreateNewLessonWidget(),)
      ],),
    );
  }
}
