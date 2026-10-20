import 'package:flutter/material.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/account_management/chart_of_account/domain/model/char_of_account_model.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class ChartOfAccountItemWidget extends StatelessWidget {
  final ChartOfAccountItem? chartOfAccountItem;
  final int index;
  const ChartOfAccountItemWidget({super.key, this.chartOfAccountItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(spacing: Dimensions.paddingSizeDefault,
      crossAxisAlignment: CrossAxisAlignment.start, children: [

      NumberingWidget(index: index),
      Expanded(child: Text('${chartOfAccountItem?.name}', style: textRegular.copyWith())),
      Expanded(child: Text('${chartOfAccountItem?.type}', style: textRegular.copyWith())),
      Expanded(child: SizedBox(height: 40,
        child: ListView.builder(shrinkWrap: true, scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(), padding: EdgeInsets.zero,
          itemCount: chartOfAccountItem?.accountingGroups?.length?? 0,
          itemBuilder: (context, index){
            return Text("${chartOfAccountItem?.accountingGroups?[index].name??''}, ");
          }),
      )),
    ],
    );
  }
}
