import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/parent_module/parent_library/controller/parent_library_controller.dart';
import 'package:class_compass/feature/parent_module/parent_library/presentation/widgets/library_history_item_widget.dart';

class ParentLibraryScreen extends StatelessWidget {
  const ParentLibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Scaffold(appBar: CustomAppBar(title: "library_history".tr),
      body: CustomWebScrollView(slivers: [
        SliverToBoxAdapter(child: GetBuilder<ParentLibraryController>(
          initState: (_) => Get.find<ParentLibraryController>().getLibraryHistoryList(),
          builder: (libraryController) {
            final libraryHistoryModel = libraryController.libraryHistoryModel;
            final libraryHistory = libraryHistoryModel?.data?.issues ?? [];

            return GenericListSection(sectionTitle: "library_history".tr,
              showAction: false,
              headings: const ["book_name", "issue_date","due_date", "return_date", ],
              scrollController: scrollController,
              isLoading: libraryHistoryModel == null,
              totalSize: 0,
              offset: 1,
              onPaginate: (offset) async {
              await libraryController.getLibraryHistoryList();
              },

              items: libraryHistory,
              itemBuilder: (item, index) => LibraryHistoryItemWidget(index: index, bookIssueItem: item),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
