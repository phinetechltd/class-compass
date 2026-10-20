import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/feature/payroll_management/advance/logic/advance_controller.dart';
import 'package:class_compass/feature/payroll_management/advance/presentation/widgets/advance_salary_list_widget.dart';

class AdvanceSalaryScreen extends StatefulWidget {
  const AdvanceSalaryScreen({super.key});

  @override
  State<AdvanceSalaryScreen> createState() => _AdvanceSalaryScreenState();
}

class _AdvanceSalaryScreenState extends State<AdvanceSalaryScreen> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Get.find<AdvanceController>().getAdvanceSalaryList(1);
    Get.find<AdvanceController>().getEmployeeList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "advance_salary".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [

        SliverToBoxAdapter(
          child: AdvanceSalaryListWidget(scrollController: scrollController),
        ),
      ]),
    );
  }
}
