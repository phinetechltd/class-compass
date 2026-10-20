import 'package:flutter/material.dart';
import 'package:class_compass/common/widget/custom_item_text_widget.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/parent_module/children/domain/model/behavior_model.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class BehaviourItemWidget extends StatelessWidget {
  final BehaviorItem? behaviorItem;
  final int index;
  const BehaviourItemWidget({super.key, this.behaviorItem, required this.index});

  @override
  Widget build(BuildContext context) {
    bool isDesktop = ResponsiveHelper.isDesktop(context);
    return isDesktop?
    Row(spacing: Dimensions.paddingSizeDefault, children: [
      NumberingWidget(index: index),
      CustomItemTextWidget(text:"${behaviorItem?.title}"),
      CustomItemTextWidget(text:" ${behaviorItem?.note??''}", maxLines: 5,),
    ]):

    Padding(padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: Dimensions.paddingSizeSmall),
      child: Container(decoration: BoxDecoration(color: index%2==1? const Color(0xFFDDFDE9): const Color(0xFFFDF6DC)),
          child: Padding(padding: const EdgeInsets.all(8),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text("${behaviorItem?.title}",
                  style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
                Text(" ${behaviorItem?.note??''}", style: textRegular.copyWith(), maxLines: 5,),
              ]))),
    );
  }
}