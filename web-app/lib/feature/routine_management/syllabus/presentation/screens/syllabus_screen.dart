
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/common/widget/custom_floating_button.dart';
import 'package:class_compass/feature/routine_management/syllabus/presentation/widgets/syllabus_list_widget.dart';
import 'package:class_compass/helper/route_helper.dart';

class SyllabusScreen extends StatefulWidget {
  const SyllabusScreen({super.key});

  @override
  State<SyllabusScreen> createState() => _SyllabusScreenState();
}

class _SyllabusScreenState extends State<SyllabusScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "syllabus".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [

        SliverToBoxAdapter(child: SyllabusListWidget(scrollController: scrollController))
      ]),

      floatingActionButton: CustomFloatingButton(onTap: ()=> Get.toNamed(RouteHelper.getAddNewSyllabusRoute()))

    );
  }
}



