import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/feature/course_management/course_category/domain/model/course_category_model.dart';
import 'package:class_compass/feature/course_management/course_category/presentation/widgets/create_new_course_category_widget.dart';
import 'package:class_compass/util/dimensions.dart';


class CreateNewCourseCategoryScreen extends StatefulWidget {
  final CourseCategoryItem? categoryItem;
  const CreateNewCourseCategoryScreen({super.key, this.categoryItem});

  @override
  State<CreateNewCourseCategoryScreen> createState() => _CreateNewCourseCategoryScreenState();
}

class _CreateNewCourseCategoryScreenState extends State<CreateNewCourseCategoryScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "add_new_course_category".tr),
      body: CustomWebScrollView(slivers: [
        SliverToBoxAdapter(child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          child: CreateNewCourseCategoryWidget(courseCategoryItem: widget.categoryItem,),
        ),)
      ],),
    );
  }
}
