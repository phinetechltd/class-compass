import 'package:flutter/material.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/feature/fees_management/fees_date/controller/fees_date_controller.dart';
import 'package:class_compass/feature/fees_management/fees_date/domain/model/fees_date_model.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:get/get.dart';

class EditDateConfigWidget extends StatefulWidget {
  final FeesDateItem? item;
  const EditDateConfigWidget({super.key, this.item});

  @override
  State<EditDateConfigWidget> createState() => _EditDateConfigWidgetState();
}

class _EditDateConfigWidgetState extends State<EditDateConfigWidget> {
  TextEditingController payableDateController = TextEditingController();
  TextEditingController fineActiveDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if(widget.item != null){
      payableDateController.text = widget.item!.payableDateStart??'';
      fineActiveDateController.text = widget.item!.payableDateEnd??'';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(spacing: Dimensions.paddingSizeDefault, children: [
          Expanded(child: Text(widget.item?.feeSubHeadName??'')),
          Expanded(child: CustomTextField(
            suffix: Icon(Icons.calendar_month, color: Theme.of(context).hintColor),
            hintText: "2024-11-01",
            controller: payableDateController,)),
          Expanded(child: CustomTextField(
            suffix: Icon(Icons.calendar_month, color: Theme.of(context).hintColor),
            hintText: "2024-12-01",
            controller: fineActiveDateController,)),

        ]),

        const SizedBox(height: Dimensions.paddingSizeDefault),

        GetBuilder<FeesDateController>(builder: (dateController) {
            return dateController.isLoading?
                const Center(child: CircularProgressIndicator()):
            CustomButton(onTap: (){
              String payableDate = payableDateController.text.trim();
              String fineActiveDate = fineActiveDateController.text.trim();
              if(payableDate.isEmpty){
                showCustomSnackBar("please_enter_payable_date".tr, isError: true);
              }else if(fineActiveDate.isEmpty){
                showCustomSnackBar("please_enter_fine_active_date".tr, isError: true);
              }else {
                Get.find<FeesDateController>().updateFeesDate(payableDate, fineActiveDate, widget.item!.id!);
              }
              }, text: "confirm".tr);
          }
        )
      ],
    );
  }
}
