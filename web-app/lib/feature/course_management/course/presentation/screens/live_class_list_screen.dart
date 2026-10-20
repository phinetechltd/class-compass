import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/feature/course_management/course/presentation/widgets/my_course_details_live_class_widget.dart';

class LiveClassListScreen extends StatelessWidget {
  const LiveClassListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "live_class".tr),
      body: const MyCourseDetailsLiveClassWidget(),
    );
  }
}
