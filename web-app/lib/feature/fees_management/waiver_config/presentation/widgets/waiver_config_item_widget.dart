import 'package:flutter/material.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_item_text_widget.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/fees_management/waiver_config/domain/model/waiver_config_model.dart';
import 'package:class_compass/helper/price_converter.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';

class WaiverConfigItemWidget extends StatelessWidget {
  final WaiverList? waiverList;
  final int index;
  const WaiverConfigItemWidget({super.key, this.waiverList, required this.index});

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.isDesktop(context)?
    Row(spacing: Dimensions.paddingSizeDefault, children: [
      NumberingWidget(index: index),

      Expanded(child :CustomItemTextWidget(text:"${waiverList?.firstName??'N/A'} ${waiverList?.lastName??'N/A'}")),
      Expanded(child :CustomItemTextWidget(text:waiverList?.email??'n/A')),
      Expanded(child :CustomItemTextWidget(text:waiverList?.phone??'n/A')),
      Expanded(child :CustomItemTextWidget(text:waiverList?.roll??'n/A')),
      Expanded(child :CustomItemTextWidget(text:waiverList?.className??'n/A')),
      Expanded(child :CustomItemTextWidget(text:waiverList?.sectionName??'n/A')),
      Expanded(child :CustomItemTextWidget(text:waiverList?.feeHeadName??'n/A')),
      Expanded(child :CustomItemTextWidget(text:waiverList?.waiverName??'n/A')),
      Expanded(child :CustomItemTextWidget(text:PriceConverter.convertPrice(context, waiverList?.waiverAmount??0))),
    ]) :

    CustomContainer(borderRadius: 6,
        child: Column(spacing: Dimensions.paddingSizeDefault, children: [
          Row(spacing: Dimensions.fontSizeSmall, children: [
            NumberingWidget(index: index),
            Expanded(child :CustomItemTextWidget(text:waiverList?.waiverName??'n/A')),
            CustomItemTextWidget(text:PriceConverter.convertPrice(context, waiverList?.waiverAmount??0)),
          ]),

          Row(children: [

            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CustomItemTextWidget(text:"${waiverList?.firstName??'N/A'} ${waiverList?.lastName??'N/A'}"),
              CustomItemTextWidget(text:waiverList?.email??'n/A'),
              CustomItemTextWidget(text:waiverList?.phone??'n/A'),
              CustomItemTextWidget(text:waiverList?.roll??'n/A'),
              CustomItemTextWidget(text:waiverList?.className??'n/A'),
              CustomItemTextWidget(text:waiverList?.sectionName??'n/A'),
              CustomItemTextWidget(text:waiverList?.feeHeadName??'n/A'),
              CustomItemTextWidget(text:waiverList?.waiverName??'n/A'),
            ],),
          ],
          ),
        ]));
  }

}