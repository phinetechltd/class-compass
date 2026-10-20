
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_divider.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/common/widget/horizontal_divider.dart';
import 'package:class_compass/feature/fees_management/smart_collection/controller/smart_collection_controller.dart';
import 'package:class_compass/feature/fees_management/smart_collection/domain/model/calculation_body.dart';
import 'package:class_compass/feature/fees_management/smart_collection/presentation/widgets/quick_collection_details_widget.dart';
import 'package:class_compass/util/dimensions.dart';
class AvailableFeesWidget extends StatelessWidget {
  const AvailableFeesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SmartCollectionController>(builder: (smartCollectionController) {

      List<CalculationModel> calculationModel = smartCollectionController.calculationModel;
      return calculationModel.isNotEmpty?
      CustomContainer(borderRadius: Dimensions.paddingSizeExtraSmall,

          child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: calculationModel.length,
              itemBuilder: (context, index){
                return Row(spacing: Dimensions.paddingSizeSmall, children: [
                  Expanded(child: CustomTextField(
                    hintText: "0",
                    controller: smartCollectionController.paidControllers[index],
                    onChanged: (value) {
                      smartCollectionController.updatePaidAmount(index, value);
                      },
                  )),

                  const HorizontalDivider(),
                  CostItem(amount: calculationModel[index].amounts?.waiver??0),
                  const HorizontalDivider(),
                  CostItem(amount: calculationModel[index].amounts?.finePayable??0),
                  const HorizontalDivider(),
                  CostItem(amount: calculationModel[index].amounts?.feePayable??0),
                  const HorizontalDivider(),
                  CostItem(amount: calculationModel[index].amounts?.feeAndFinePayable??0),
                  const HorizontalDivider(),
                  CostItem(amount: calculationModel[index].amounts?.totalPayable??0),
                ]);
              }, separatorBuilder: (BuildContext context, int index) {
                return const Padding(padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: CustomDivider());
          },)):const SizedBox();
        }
    );
  }
}
