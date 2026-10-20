import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/common/widget/custom_floating_button.dart';
import 'package:class_compass/feature/hostel_management/hostel_meal_plan/presentation/screens/add_new_hostel_meal_plan_screen.dart';
import 'package:class_compass/feature/hostel_management/hostel_meal_plan/presentation/widgets/hostel_meal_plan_list_widget.dart';

class HostelMealPlanScreen extends StatefulWidget {
  const HostelMealPlanScreen({super.key});

  @override
  State<HostelMealPlanScreen> createState() => _HostelMealPlanScreenState();
}

class _HostelMealPlanScreenState extends State<HostelMealPlanScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "hostel_meal_plan".tr),
      body: const CustomWebScrollView(slivers: [
        SliverToBoxAdapter(child: HostelMealPlanListWidget())
      ]),
      floatingActionButton: CustomFloatingButton(
          onTap: () => Get.to(() => const AddNewHostelMealPlanScreen())
      ),
    );
  }
}