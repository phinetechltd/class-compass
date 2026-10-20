import 'package:flutter/material.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_image.dart';
import 'package:class_compass/common/widget/custom_item_text_widget.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/payroll_management/due/domain/model/due_model.dart';
import 'package:class_compass/helper/price_converter.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';

class DueItemWidget extends StatelessWidget {
  final DueUserPayroll? dueUserPayroll;
  final int index;
  const DueItemWidget({super.key, this.dueUserPayroll, required this.index});

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.isDesktop(context)?
    Row(spacing: Dimensions.paddingSizeDefault, children: [
      NumberingWidget(index: index),
      ClipRRect(borderRadius: BorderRadius.circular(120),
          child: CustomImage(width: Dimensions.imageSizeBig,
              height: Dimensions.imageSizeBig,
              image: "${AppConstants.imageBaseUrl}/users/${dueUserPayroll?.user?.image}")),

      Expanded(child :CustomItemTextWidget(text:"${dueUserPayroll?.user?.name}")),
      Expanded(child :CustomItemTextWidget(text:"${dueUserPayroll?.user?.userType}")),
      Expanded(child :CustomItemTextWidget(text:PriceConverter.convertPrice(context, dueUserPayroll?.currentDue??0))),
    ]) :

    CustomContainer(borderRadius: 6,
        child: Column(spacing: Dimensions.paddingSizeDefault, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            NumberingWidget(index: index),
            CustomItemTextWidget(text:PriceConverter.convertPrice(context, dueUserPayroll?.currentDue??0)),
          ]),

          Row(children: [
            CustomImage(width: Dimensions.imageSizeBig,
                height: Dimensions.imageSizeBig,
                image: "${AppConstants.imageBaseUrl}/users/${dueUserPayroll?.user?.image}"),

            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                CustomItemTextWidget(text:"${dueUserPayroll?.user?.name}"),
                CustomItemTextWidget(text:"${dueUserPayroll?.user?.userType}"),
              ],)),
            ],
          ),
        ]));
  }

}