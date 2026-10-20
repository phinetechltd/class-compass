import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/widget/custom_item_text_widget.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/fees_management/paid_info/presentation/widgets/unpaid_details_info_widget.dart';
import 'package:class_compass/helper/price_converter.dart';
import 'package:class_compass/util/dimensions.dart';

import '../../domain/model/un_paid_report_model.dart';

class UnpaidFeesInfoItemWidget extends StatelessWidget {
  final UnpaidStudentData? item;
  final int index;
  const UnpaidFeesInfoItemWidget({super.key, this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(spacing: Dimensions.paddingSizeDefault, children: [
      NumberingWidget(index: index),

      Expanded(child: CustomItemTextWidget(text:item?.name ?? 'N/A')),
      Expanded(child: CustomItemTextWidget(text: item?.roll ?? 'N/A')),
      Expanded(child: CustomItemTextWidget(
        text:PriceConverter.convertPrice(context, item?.totalPaidAmount  ?? 0),)),

      IconButton(onPressed: ()=> Get.dialog(CustomDialogWidget(
          title: "details".tr,
          child: UnPaidDetailsInfoWidget(info: item))),
        icon: Icon(Icons.arrow_forward_ios_rounded, size: 16,
            color: Theme.of(context).hintColor),
      ),
    ]);
  }
}
