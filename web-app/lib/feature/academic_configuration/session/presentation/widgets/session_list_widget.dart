import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/academic_configuration/session/controller/session_controller.dart';
import 'package:class_compass/feature/academic_configuration/session/domain/models/session_model.dart';
import 'package:class_compass/feature/academic_configuration/session/presentation/widgets/create_new_session_widget.dart';
import 'package:class_compass/feature/academic_configuration/session/presentation/widgets/session_item_widget.dart';

class SessionListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const SessionListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SessionController>(
      initState: (val) => Get.find<SessionController>().getSessionList(1),
      builder: (sessionController) {
        final sessionModel = sessionController.sessionModel;
        final sessionData = sessionModel?.data;

        return GenericListSection<SessionItem>(
          sectionTitle: "academic_configuration".tr,
          pathItems: ["session_list".tr],
          addNewTitle: "add_new_session".tr,
          onAddNewTap: () => Get.dialog(CustomDialogWidget(title: "session".tr,
              child: const CreateNewSessionWidget())),
          headings: const ["session", "year"],

          scrollController: scrollController,
          isLoading: sessionModel == null,
          totalSize: sessionData?.total ?? 0,
          offset: sessionData?.currentPage ?? 0,
          onPaginate: (offset) async => await sessionController.getSessionList(offset ?? 1),

          items: sessionData?.data ?? [],
          itemBuilder: (item, index) => SessionItemWidget(index: index, sessionItem: item),
        );
      },
    );
  }
}