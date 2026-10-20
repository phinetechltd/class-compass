
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/feature/academic_configuration/subject/domain/model/subject_model.dart';
import 'package:class_compass/feature/academic_configuration/subject/presentation/widgets/add_new_subject_widget.dart';
import 'package:class_compass/util/dimensions.dart';

class AddNewSubjectScreen extends StatefulWidget {
  final SubjectItem? subjectItem;
  const AddNewSubjectScreen({super.key, this.subjectItem});

  @override
  State<AddNewSubjectScreen> createState() => _AddNewSubjectScreenState();
}

class _AddNewSubjectScreenState extends State<AddNewSubjectScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "add_new_subject".tr),
      body:  CustomWebScrollView(slivers: [
        SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: AddNewSubjectWidget(subjectItem: widget.subjectItem)))
      ],),
    );
  }
}
