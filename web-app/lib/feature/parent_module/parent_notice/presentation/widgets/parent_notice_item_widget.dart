import 'package:flutter/material.dart';
import 'package:class_compass/common/widget/custom_item_text_widget.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/administrator/notice/domain/models/notice_model.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class ParentNoticeItemWidget extends StatelessWidget {
  final NoticeItem? noticeItem;
  final int index;
  const ParentNoticeItemWidget({super.key, this.noticeItem, required this.index});

  @override
  Widget build(BuildContext context) {
    bool isDesktop = ResponsiveHelper.isDesktop(context);
    return isDesktop?
    Row(spacing: Dimensions.paddingSizeDefault, children: [
      NumberingWidget(index: index),
      Expanded(child: CustomItemTextWidget(text:"${noticeItem?.title}")),
      Expanded(child: CustomItemTextWidget(text:" ${noticeItem?.notice??''}", maxLines: 5,)),
    ]):

    Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: Dimensions.paddingSizeSmall),
      child: Container(decoration: BoxDecoration(color: index%2==1?
      const Color(0xFFDDFDE9): const Color(0xFFFDF6DC)),
          child: Padding(padding: const EdgeInsets.all(8),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text("${noticeItem?.title}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
                Text(" ${noticeItem?.notice??''}", style: textRegular.copyWith(), maxLines: 5,),
              ]))),
    );
  }
}