
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/common/widget/custom_floating_button.dart';
import 'package:class_compass/feature/course_management/course_category/presentation/widgets/course_category_list_widget.dart';
import 'package:class_compass/feature/course_management/course_category/presentation/widgets/create_new_course_category_widget.dart';

class CourseCategoryScreen extends StatefulWidget {
  const CourseCategoryScreen({super.key});

  @override
  State<CourseCategoryScreen> createState() => _CourseCategoryScreenState();
}

class _CourseCategoryScreenState extends State<CourseCategoryScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: "course_category".tr),
        body: CustomWebScrollView(controller: scrollController, slivers: [

          SliverToBoxAdapter(child: CourseCategoryListWidget(scrollController: scrollController),)
        ],),


        floatingActionButton: CustomFloatingButton(title: "add",
            onTap: ()=> Get.to(()=> const CreateNewCourseCategoryWidget()))
    );
  }
}



