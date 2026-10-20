import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/common/widget/custom_floating_button.dart';
import 'package:class_compass/feature/academic_configuration/period/presentation/screens/create_new_period_dialog.dart';
import 'package:class_compass/feature/academic_configuration/period/presentation/widgets/period_list_widget.dart';

class PeriodScreen extends StatefulWidget {
  const PeriodScreen({super.key});

  @override
  State<PeriodScreen> createState() => _PeriodScreenState();
}

class _PeriodScreenState extends State<PeriodScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "period".tr),
    body: CustomWebScrollView(controller: scrollController, slivers: [

      SliverToBoxAdapter(child: PeriodListWidget(scrollController: scrollController,))
    ],),
      floatingActionButton: CustomFloatingButton(title: "add", onTap: ()=>Get.dialog(const CreateNewPeriodScreen())));
  }
}
