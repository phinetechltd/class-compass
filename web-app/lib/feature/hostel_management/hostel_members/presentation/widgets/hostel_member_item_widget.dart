import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/widget/custom_item_text_widget.dart';
import 'package:class_compass/common/widget/edit_delete_section.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/hostel_management/hostel_members/domain/model/hostel_member_model.dart';
import 'package:class_compass/feature/hostel_management/hostel_members/logic/hostel_members_controller.dart';
import 'package:class_compass/feature/hostel_management/hostel_members/presentation/widgets/add_new_hostel_member_widget.dart';
import 'package:class_compass/util/dimensions.dart';

class HostelMemberItemWidget extends StatelessWidget {
  final HostelMemberItem memberItem;
  final int index;
  
  const HostelMemberItemWidget({super.key, required this.memberItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HostelMembersController>(builder: (memberController) {
        return  _buildDesktopView(context, memberController);
      },
    );
  }

  Widget _buildDesktopView(BuildContext context, HostelMembersController memberController) {
    return Row(spacing: Dimensions.paddingSizeDefault, children: [
      NumberingWidget(index: index),
      Expanded(child: CustomItemTextWidget(text: memberItem.name ?? '')),
      Expanded(child: CustomItemTextWidget(text: memberItem.roll ?? '')),
      Expanded(child: CustomItemTextWidget(text: memberItem.className ?? '')),
      Expanded(child: CustomItemTextWidget(text: memberItem.sectionName ?? '')),

        EditDeleteSection(horizontal: true,
          onEdit: () => Get.dialog(CustomDialogWidget(title: "hostel_member".tr,
              child: AddNewHostelMemberWidget(memberId: memberItem.id))),
          onDelete: () => memberController.deleteHostelMember(memberItem.id!),
        ),
      ],
    );
  }

}
