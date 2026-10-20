import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/feature/administrator/notice/domain/models/notice_model.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class StudentNoticeItemWidget extends StatelessWidget {
  final NoticeItem? noticeItem;
  final int index;
  const StudentNoticeItemWidget({super.key, this.noticeItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: 5),
      child: CustomContainer(child: Row(
        children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("${"title".tr} : ${noticeItem?.title}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
              const SizedBox(height: Dimensions.paddingSizeSmall,),
              Text("${"description".tr} : ${noticeItem?.notice??''}", style: textRegular.copyWith(),),
            ]),
          ),

        ],
      )),
    );
  }
}