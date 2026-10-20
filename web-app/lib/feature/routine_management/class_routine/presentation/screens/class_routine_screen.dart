import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/feature/routine_management/class_routine/presentation/widgets/class_routine_widget.dart';


class ClassRoutineScreen extends StatefulWidget {
  const ClassRoutineScreen({super.key});

  @override
  State<ClassRoutineScreen> createState() => _ClassRoutineScreenState();
}

class _ClassRoutineScreenState extends State<ClassRoutineScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "class_routine".tr),
      body: const CustomWebScrollView(slivers: [
         SliverToBoxAdapter(child: ClassRoutineWidget(),)
      ],),
    );
  }
}
