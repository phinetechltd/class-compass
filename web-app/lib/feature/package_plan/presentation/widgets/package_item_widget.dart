import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_item_text_widget.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/package_plan/domain/models/package_model.dart';
import 'package:class_compass/helper/price_converter.dart';
import 'package:class_compass/util/dimensions.dart';

class PackageItemWidget extends StatelessWidget {
  final PackageItem? packageItem;
  final int index;
  const PackageItemWidget({super.key, this.packageItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(spacing: Dimensions.paddingSizeDefault, children: [
      NumberingWidget(index: index),
        Expanded(child: CustomItemTextWidget(text:"${packageItem?.name}")),
        Expanded(child: CustomItemTextWidget(text: packageItem?.description??'N/A')),
        Expanded(child: CustomItemTextWidget(text: PriceConverter.convertPrice(context, packageItem?.price ?? 0))),
        Expanded(child: CustomItemTextWidget(text: "${packageItem?.durationDays?.toString()??'0'} ${"days".tr}")),

      ],);
  }
}