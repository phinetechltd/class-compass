import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/feature/fees_management/paid_info/presentation/widgets/unpaid_fees_info_report_list_widget.dart';

class UnpaidFeesInfoScreen extends StatefulWidget {
  const UnpaidFeesInfoScreen({super.key});

  @override
  State<UnpaidFeesInfoScreen> createState() => _UnpaidFeesInfoScreenState();
}

class _UnpaidFeesInfoScreenState extends State<UnpaidFeesInfoScreen> {
  ScrollController scrollController = ScrollController();
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "unpaid_fees_info".tr),
      body: CustomWebScrollView(slivers: [
        SliverToBoxAdapter(
          child: UnpaidFeesInfoReportListWidget(scrollController: scrollController),
        ),
      ],
      ),
    );
  }
}
