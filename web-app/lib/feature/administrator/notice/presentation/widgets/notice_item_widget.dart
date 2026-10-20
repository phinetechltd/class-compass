import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/widget/confirmation_dialog.dart';
import 'package:class_compass/common/widget/edit_delete_section.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/administrator/notice/controller/notice_controller.dart';
import 'package:class_compass/feature/administrator/notice/domain/models/notice_model.dart';
import 'package:class_compass/feature/administrator/notice/presentation/screens/create_new_notice_screen.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class NoticeItemWidget extends StatelessWidget {
  final NoticeItem? noticeItem;
  final int index;
  final bool dashBoardScreen;
  const NoticeItemWidget({super.key, this.noticeItem, required this.index, this.dashBoardScreen = false});

  @override
  Widget build(BuildContext context) {
    return Row(spacing: Dimensions.paddingSizeDefault,  children: [
      NumberingWidget(index: index),
      Expanded(child: Text('${noticeItem?.title}', style: textRegular.copyWith())),
      Expanded(child: Text(noticeItem?.notice ?? '',
          style: textRegular.copyWith(), maxLines: 3, overflow: TextOverflow.ellipsis)),
      if(!dashBoardScreen)
      EditDeleteSection(horizontal: true, onDelete: (){
        Get.dialog(ConfirmationDialog(title: "notice", content: "notice",
          onTap: (){
            Get.back();
            Get.find<NoticeController>().deleteNotice(noticeItem!.id!);
          },));

      }, onEdit: (){
        Get.dialog(CustomDialogWidget(title: "notice".tr,
            child: CreateNewNoticeScreen(noticeItem: noticeItem)));
      },)
    ],
    );
  }
}