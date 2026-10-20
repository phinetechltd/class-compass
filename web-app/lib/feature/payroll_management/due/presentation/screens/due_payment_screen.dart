import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/common/widget/section_header_with_path_widget.dart';
import 'package:class_compass/feature/payroll_management/due/presentation/widgets/due_payment_widget.dart';

class DuePaymentScreen extends StatefulWidget {
  const DuePaymentScreen({super.key});

  @override
  State<DuePaymentScreen> createState() => _DuePaymentScreenState();
}

class _DuePaymentScreenState extends State<DuePaymentScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "due_payment".tr),
      body: CustomWebScrollView(slivers: [
        SliverToBoxAdapter(child: Column(children: [
              SectionHeaderWithPath(sectionTitle: "payroll_management".tr,
                pathItems: const ["due_payment"],),
              const DuePaymentWidget(),
            ],
          ),
        ),
      ]),
    );
  }
}
