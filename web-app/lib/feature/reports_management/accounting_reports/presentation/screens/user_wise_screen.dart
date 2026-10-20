import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/feature/reports_management/accounting_reports/logic/accounting_reports_controller.dart';
import 'package:class_compass/feature/reports_management/accounting_reports/presentation/widgets/user_wise_transaction_list_widget.dart';

class UserWiseScreen extends StatefulWidget {
  const UserWiseScreen({super.key});

  @override
  State<UserWiseScreen> createState() => _UserWiseScreenState();
}

class _UserWiseScreenState extends State<UserWiseScreen> {
  @override
  void initState() {
    super.initState();

    if (Get.find<AccountingReportsController>().userWiseModel == null) {
      Get.find<AccountingReportsController>().getUserWise();
    }
  }
  ScrollController scrollController = ScrollController();

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "user_wise_report".tr),
      body: CustomWebScrollView(slivers: [
          SliverToBoxAdapter(
            child: UserWiseTransactionListWidget(scrollController: scrollController),
          ),
        ],
      ),
    );
  }
}
