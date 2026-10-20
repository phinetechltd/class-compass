import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/parent_module/parent_notice/controller/parent_notice_controller.dart';
import 'package:class_compass/feature/parent_module/parent_notice/presentation/widgets/parent_notice_item_widget.dart';

class ParentNoticeScreen extends StatelessWidget {
  const ParentNoticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Scaffold(appBar: CustomAppBar(title: "notice".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [
        SliverToBoxAdapter(child: GetBuilder<ParentNoticeController>(
          initState: (_) => Get.find<ParentNoticeController>().getNoticeList(1),
          builder: (noticeController) {
            final noticeModel = noticeController.noticeModel;
            final notices = noticeModel?.data?.data ?? [];

            return GenericListSection(
              showAction: false,
              sectionTitle: "notice".tr,
              headings: const ["title", "description"],
              scrollController: scrollController,
              isLoading: noticeModel == null,
              totalSize: noticeModel?.data?.total ?? 0,
              offset: noticeModel?.data?.currentPage ?? 0,
              onPaginate: (offset) async {
                await noticeController.getNoticeList(offset ?? 1);
                },
              items: notices,
              itemBuilder: (item, index) => ParentNoticeItemWidget(index: index, noticeItem: item));
              },
            ),
          ),
        ],
      ),
    );
  }
}
