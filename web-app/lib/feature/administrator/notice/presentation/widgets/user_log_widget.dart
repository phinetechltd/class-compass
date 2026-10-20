import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/administrator/notice/controller/notice_controller.dart';
import 'package:class_compass/feature/administrator/notice/domain/models/user_log_model.dart';
import 'package:class_compass/feature/administrator/notice/presentation/widgets/user_log_item_widget.dart';

class UserLogListWidget extends StatelessWidget {
  final ScrollController scrollController;
  final bool dashBoardScreen;
  const UserLogListWidget({
    super.key,
    required this.scrollController,
    this.dashBoardScreen = false,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NoticeController>(
      initState: (val) => Get.find<NoticeController>().getUserLogList(1),
      builder: (userLogController) {
        final userLogModel = userLogController.userLogModel;
        final userLogData = userLogModel?.data;

        return GenericListSection<UserLogItem>(
          showRouteSection: dashBoardScreen ? false : true,
          sectionTitle: "administrator".tr,
          pathItems: ["user_logs".tr],
          showAction: false,
          headings: const ["user", "description", "date"],

          scrollController: scrollController,
          isLoading: userLogModel == null,
          totalSize: userLogData?.total ?? 0,
          offset: userLogData?.currentPage ?? 0,
          onPaginate: (offset) async => await userLogController.getUserLogList(offset ?? 1),

          items: userLogData?.data ?? [],
          itemBuilder: (item, index) => UserLogItemWidget(
            index: index,
            userLogItem: item,
          ),
        );
      },
    );
  }
}
