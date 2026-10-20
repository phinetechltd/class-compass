
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/common/widget/custom_floating_button.dart';
import 'package:class_compass/feature/academic_configuration/section/presentation/screens/create_new_section_screen.dart';
import 'package:class_compass/feature/academic_configuration/section/presentation/widgets/section_list_widget.dart';

class SectionScreen extends StatefulWidget {
  const SectionScreen({super.key});

  @override
  State<SectionScreen> createState() => _SectionScreenState();
}

class _SectionScreenState extends State<SectionScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "section".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [

        SliverToBoxAdapter(child: SectionListWidget(scrollController: scrollController),)
      ],),

      floatingActionButton: CustomFloatingButton(title: "add", onTap: ()=> Get.to(()=> const CreateNewSectionScreen()))
    );
  }
}



