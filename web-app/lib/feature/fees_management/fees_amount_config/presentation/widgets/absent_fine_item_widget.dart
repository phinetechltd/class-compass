import 'package:flutter/material.dart';
import 'package:class_compass/common/widget/custom_item_text_widget.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/fees_management/fees_amount_config/domain/model/absent_fine_model.dart';
import 'package:class_compass/helper/price_converter.dart';
import 'package:class_compass/util/dimensions.dart';

class AbsentFineItemWidget extends StatelessWidget {
  final AbsentFineItem absentFineItem;
  final int index;
  const AbsentFineItemWidget({super.key, required this.absentFineItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(spacing: Dimensions.paddingSizeDefault, children: [
      NumberingWidget(index: index),
      Expanded(child: CustomItemTextWidget(text:'${absentFineItem.classItem?.className}')),
      Expanded(child: CustomItemTextWidget(text:'${absentFineItem.period?.period}')),
      Expanded(child: CustomItemTextWidget(text:PriceConverter.convertPrice(context, absentFineItem.feeAmount ?? 0))),
    ],
    );
  }
}
