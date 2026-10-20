import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/list_layout_widget.dart';
import 'package:class_compass/feature/sms/sent_sms/domain/model/absent_student_model.dart';
import 'package:class_compass/feature/sms/sent_sms/logic/sent_sms_controller.dart';
import 'package:class_compass/feature/sms/sent_sms/presentation/widgets/absent_student_item_widget.dart';

class AbsentStudentListWidget extends StatelessWidget {
  final ScrollController scrollController;
  final bool showRouteSection;
  const AbsentStudentListWidget({super.key, required this.scrollController,
     this.showRouteSection = true});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SentSmsController>(builder: (controller) {
        final absentStudent = controller.absentStudentModel;
        final user = absentStudent?.data ?? [];

        return GenericListSection<AbsentStudentItem>(
          showRouteSection: showRouteSection,
          sectionTitle: "sms_management".tr,
          addNewTitle: "absent_student".tr,
          pathItems: ["user_list".tr],
          headings: const ["name", "phone" ],
          scrollController: scrollController,
          isLoading: absentStudent == null,
          totalSize:  0,
          offset:  0,
          onPaginate: (offset) async => await controller.getUserListFoeSms("Student"),
          items: user,
          itemBuilder: (item, index) => AbsentStudentItemWidget(index: index, userItem: item),
        );
      },
    );
  }
}
