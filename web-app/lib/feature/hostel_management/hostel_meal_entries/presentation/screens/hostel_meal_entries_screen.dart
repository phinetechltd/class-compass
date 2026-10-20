import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/common/widget/custom_floating_button.dart';
import 'package:class_compass/feature/hostel_management/hostel_meal_entries/presentation/screens/add_new_hostel_meal_entry_screen.dart';
import 'package:class_compass/feature/hostel_management/hostel_meal_entries/presentation/widgets/hostel_meal_entries_list_widget.dart';

class HostelMealEntriesScreen extends StatefulWidget {
  const HostelMealEntriesScreen({super.key});

  @override
  State<HostelMealEntriesScreen> createState() => _HostelMealEntriesScreenState();
}

class _HostelMealEntriesScreenState extends State<HostelMealEntriesScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "hostel_meal_entries".tr),
      body: const CustomWebScrollView(slivers: [
        SliverToBoxAdapter(child: HostelMealEntriesListWidget())
      ]),
      floatingActionButton: CustomFloatingButton(
        onTap: () => Get.to(() => const AddNewHostelMealEntriesScreen())
      ),
    );
  }
}