import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/feature/payroll_management/due/presentation/widgets/due_payment_list_widget.dart';

class DueSalaryScreen extends StatefulWidget {
  const DueSalaryScreen({super.key});

  @override
  State<DueSalaryScreen> createState() => _DueSalaryScreenState();
}

class _DueSalaryScreenState extends State<DueSalaryScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "due_salary".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [
        SliverToBoxAdapter(
          child: DuePaymentListWidget(scrollController: scrollController),
        ),
      ]),
    );
  }
}
