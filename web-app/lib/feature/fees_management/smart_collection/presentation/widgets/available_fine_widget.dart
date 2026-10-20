
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/feature/fees_management/smart_collection/controller/smart_collection_controller.dart';
import 'package:class_compass/helper/price_converter.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class AvailableFineWidget extends StatelessWidget {
  const AvailableFineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SmartCollectionController>(
        builder: (smartCollectionController) {
          return Row(children: [

            FineWidget(title: "attendance_fine", amount: smartCollectionController.attendanceFineAmount,
                value: smartCollectionController.attendanceFineChecked,
                onTap: (val)=> smartCollectionController.toggleAttendanceFine()),

            const SizedBox(width: Dimensions.paddingSizeSmall),
            FineWidget(title: "quiz_fine", amount: smartCollectionController.quizFineAmount,
                value: smartCollectionController.quizFineChecked,
                onTap: (val)=> smartCollectionController.toggleQuizFine()),

            const SizedBox(width: Dimensions.paddingSizeSmall),
            FineWidget(title: "lab_fine", amount: smartCollectionController.labFineAmount,
                value: smartCollectionController.labFineChecked,
                onTap: (val)=> smartCollectionController.toggleLabFine()),

            const SizedBox(width: Dimensions.paddingSizeSmall),
            FineWidget(title: "tc_amount", amount: smartCollectionController.tcChargeAmount,
                value: smartCollectionController.tcChargeChecked,
                onTap: (val)=> smartCollectionController.toggleTCCharge()),

          ],
          );
        }
    );
  }
}
class FineWidget extends StatelessWidget {
  final String title;
  final double amount;
  final bool value;
  final Function(dynamic)? onTap;
  const FineWidget({super.key, required this.title,
    required this.amount, this.onTap, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: CustomContainer(
        borderRadius: Dimensions.paddingSizeExtraSmall,
        horizontalPadding: 5,verticalPadding: 5,child: Row(children: [
      SizedBox(width: 20, child: Checkbox(value: value, onChanged: onTap)),
      const SizedBox(width: Dimensions.paddingSizeExtraSmall),
      Text("${title.tr}: ",
        style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall),),
      Text(PriceConverter.convertPrice(context, amount),
          style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall))
    ])),
    );
  }
}
