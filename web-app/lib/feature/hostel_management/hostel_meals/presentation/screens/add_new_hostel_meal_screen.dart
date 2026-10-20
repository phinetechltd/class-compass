import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/common/widget/section_header_with_path_widget.dart';
import 'package:class_compass/feature/hostel_management/hostel_meals/domain/model/hostel_meal_model.dart';
import 'package:class_compass/feature/hostel_management/hostel_meals/presentation/widgets/add_new_meal_widget.dart';

class AddNewHostelMealScreen extends StatelessWidget {
  final HostelMealItem? item;
  const AddNewHostelMealScreen({super.key, this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "add_new_hostel_meal".tr),
      body: CustomWebScrollView(slivers: [
        SliverToBoxAdapter(child: Column(children: [
            const SectionHeaderWithPath(sectionTitle: "hostel_management", pathItems: ["add_new_meal"],),
            AddNewMealWidget(item: item),
          ],
        ),)
      ]),
    );
  }
}
