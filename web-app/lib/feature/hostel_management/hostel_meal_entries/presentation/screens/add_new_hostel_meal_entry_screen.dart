import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/common/widget/section_header_with_path_widget.dart';
import 'package:class_compass/feature/hostel_management/hostel_meal_entries/domain/model/hostel_meal_entry_model.dart';
import 'package:class_compass/feature/hostel_management/hostel_meal_entries/presentation/widgets/add_new_meal_entries_widget.dart';
import 'package:class_compass/util/dimensions.dart';

class AddNewHostelMealEntriesScreen extends StatelessWidget {
  final HostelMealEntryItem? mealEntryItem;
  const AddNewHostelMealEntriesScreen({super.key, this.mealEntryItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "add_new_hostel_meal_entries".tr),
      body: CustomWebScrollView(slivers: [
        SliverToBoxAdapter(child: Column(children: [
          SectionHeaderWithPath(sectionTitle: "hostel_management".tr,
              pathItems: ["meal_entries".tr]),
          Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            child: AddNewHostelMealEntriesWidget(mealEntryItem: mealEntryItem),
          )
        ]))
      ]),
    );
  }
}
