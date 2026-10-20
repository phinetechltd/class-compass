import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/feature/reports_management/fees_reports/presentation/widgets/fees_payment_ratio_list_widget.dart';

class FeesPaymentRatioScreen extends StatefulWidget {
  const FeesPaymentRatioScreen({super.key});

  @override
  State<FeesPaymentRatioScreen> createState() => _FeesPaymentRatioScreenState();
}

class _FeesPaymentRatioScreenState extends State<FeesPaymentRatioScreen> {
  ScrollController scrollController = ScrollController();

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "payment_ratio_info".tr),
      body: CustomWebScrollView(slivers: [
        SliverToBoxAdapter(
          child: FeesPaymentRatioListWidget(scrollController: scrollController),
        ),
      ],
      ),
    );
  }
}
