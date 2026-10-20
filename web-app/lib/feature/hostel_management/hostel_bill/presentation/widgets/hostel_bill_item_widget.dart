import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_item_text_widget.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/hostel_management/hostel_bill/domain/model/hostel_bill_model.dart';
import 'package:class_compass/feature/hostel_management/hostel_meals/logic/hostel_meals_controller.dart';
import 'package:class_compass/helper/price_converter.dart';
import 'package:class_compass/util/dimensions.dart';

class HostelBillItemWidget extends StatelessWidget {
  final HostelBillItem billItem;
  final int index;

  const HostelBillItemWidget({super.key, required this.billItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HostelMealsController>(builder: (mealController) {
      return  _buildDesktopView(context, mealController);
    },
    );
  }

  Widget _buildDesktopView(BuildContext context, HostelMealsController mealController) {
    return Row(spacing: Dimensions.paddingSizeDefault, children: [
      NumberingWidget(index: index),
      Expanded(child: CustomItemTextWidget(text: billItem.student?.firstName ?? '')),
      Expanded(child: CustomItemTextWidget(text: PriceConverter.convertPrice(context, billItem.hostelFee ?? 0))),
      Expanded(child: CustomItemTextWidget(text: PriceConverter.convertPrice(context, billItem.mealFee ?? 0))),
      CustomItemTextWidget(text: PriceConverter.convertPrice(context, billItem.totalAmount ?? 0)),


    ],
    );
  }

}
