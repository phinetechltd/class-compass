import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/feature/sms/sent_sms/presentation/widgets/sent_sms_report_list_widget.dart';

class SentSmsReportScreen extends StatefulWidget {
  const SentSmsReportScreen({super.key});

  @override
  State<SentSmsReportScreen> createState() => _SentSmsReportScreenState();
}

class _SentSmsReportScreenState extends State<SentSmsReportScreen> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "sms_report_list".tr),

      body: CustomWebScrollView(controller: scrollController, slivers: [
        SliverToBoxAdapter(child: SmsReportListWidget(scrollController: scrollController),)
      ],),

    );
  }
}
