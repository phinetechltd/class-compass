import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/common/widget/section_header_with_path_widget.dart';
import 'package:class_compass/feature/hostel_management/hostel_meal_plan/domain/model/hostel_meal_plan_model.dart';
import 'package:class_compass/feature/hostel_management/hostel_meal_plan/presentation/widgets/add_new_hostel_meal_plan_widget.dart';
import 'package:class_compass/util/dimensions.dart';

class AddNewHostelMealPlanScreen extends StatelessWidget {
  final HostelMealPlanItem? mealPlanItem;
  const AddNewHostelMealPlanScreen({super.key, this.mealPlanItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "add_new_hostel_meal_plan".tr),
      body: CustomWebScrollView(slivers: [
        SliverToBoxAdapter(child: Column(children: [
          SectionHeaderWithPath(sectionTitle: "hostel_management".tr,
            pathItems: ["meal_plan".tr]),
          Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            child: AddNewHostelMealPlanWidget(mealPlanItem: mealPlanItem),
          )
        ]))
      ]),
    );
  }
}
