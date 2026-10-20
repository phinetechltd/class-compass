import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/feature/exam_management/marksheet/widgets/add_new_marksheet_config_widget.dart';

class AddNewMarksheetConfig extends StatefulWidget {
  const AddNewMarksheetConfig({super.key});

  @override
  State<AddNewMarksheetConfig> createState() => _AddNewMarksheetConfigState();
}

class _AddNewMarksheetConfigState extends State<AddNewMarksheetConfig> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "add_new_marksheet_config".tr),
      body: const CustomScrollView(slivers: [
        SliverToBoxAdapter(child: Column(children: [
          AddNewMarkSheetConfigWidget(),
        ]))
      ]),
    );
  }
}
