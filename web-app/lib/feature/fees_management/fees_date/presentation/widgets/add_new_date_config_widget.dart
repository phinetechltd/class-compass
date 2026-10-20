
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/common/widget/heading_menu_widget.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/fees_management/fees_date/controller/fees_date_controller.dart';
import 'package:class_compass/feature/fees_management/fees_date/domain/model/fee_date_config_search_model.dart';
import 'package:class_compass/feature/fees_management/fees_date/domain/model/fees_date_body.dart';
import 'package:class_compass/feature/fees_management/fees_date/domain/model/fees_date_model.dart';
import 'package:class_compass/feature/fees_management/fees_head/controller/fees_head_controller.dart';
import 'package:class_compass/feature/fees_management/fees_head/presentation/widgets/select_fees_head_widget.dart';
import 'package:class_compass/util/dimensions.dart';

class AddNewDateConfigWidget extends StatefulWidget {
  final FeesDateItem? item;
  const AddNewDateConfigWidget({super.key, this.item});

  @override
  State<AddNewDateConfigWidget> createState() => _AddNewDateConfigWidgetState();
}

class _AddNewDateConfigWidgetState extends State<AddNewDateConfigWidget> {
  @override
  void initState() {
    super.initState();
    if(widget.item != null){
      Get.find<FeesDateController>().getFeesDateConfigSearch(widget.item!.id!);
    }
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeesDateController>(builder: (controller) {
      FeeDateConfigSearchModel? model = controller.feeDateConfigSearchModel;
      return Column(children: [
        Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
          child: Row(crossAxisAlignment: CrossAxisAlignment.end, spacing: Dimensions.paddingSizeSmall,  children: [
            const Expanded(child: SelectFeesHeadWidget()),
            Padding(padding: const EdgeInsets.only(bottom: 9),
                child: SizedBox(width: 90, child: CustomButton(onTap: (){
                  int? feeHeadId = Get.find<FeesHeadController>().selectedFeesHeadItem?.id;

                  if(feeHeadId == null){
                    showCustomSnackBar("select_fee_head".tr);
                  }else {
                    controller.getFeesDateConfigSearch(feeHeadId);
                  }}, text: "search".tr)))
            ],),
          ),

        if(model != null && model.data != null && model.data!.isNotEmpty)
        Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeadingMenu(showActionOption: false,
                headings: ["fee_sub_head", "payable_date", "fine_active_date"]),
            ListView.builder(
              itemCount: model.data!.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, index){
                  FeeDateConfigSearchItem item = model.data![index];
              return Row(spacing: Dimensions.paddingSizeDefault, children: [
                NumberingWidget(index: index),
                Expanded(child: Text("${item.name}")),
                Expanded(child: CustomTextField(
                  suffix: Icon(Icons.calendar_month, color: Theme.of(context).hintColor),
                  hintText: "2024-11-01",
                  controller: item.payableDateController,)),
                Expanded(child: CustomTextField(
                  suffix: Icon(Icons.calendar_month, color: Theme.of(context).hintColor),
                  hintText: "2024-12-01",
                  controller: item.fineActiveDateController,)),

              ]);
            }),
          ],
        ),
        const SizedBox(height: Dimensions.paddingSizeDefault),
        CustomButton(onTap: (){

          List<String>? feeSubHeadId;
          List<String>? payableDate;
          List<String>? fineActiveDate;
          if(model != null && model.data != null && model.data!.isNotEmpty){
            feeSubHeadId = model.data!.map((e) => e.id.toString()).toList();
            payableDate = model.data!.map((e) => e.payableDateController!.text.trim()).toList();
            fineActiveDate = model.data!.map((e) => e.fineActiveDateController!.text.trim()).toList();
          }
          bool hasInvalidData =
              feeSubHeadId == null ||
                  payableDate == null ||
                  fineActiveDate == null ||
                  feeSubHeadId.isEmpty ||
                  payableDate.isEmpty ||
                  fineActiveDate.isEmpty ||
                  payableDate.any((e) => e.isEmpty) ||
                  fineActiveDate.any((e) => e.isEmpty);

          if (hasInvalidData) {
            showCustomSnackBar("fill_all_fields".tr);
          }else {
            FeesDateBody body = FeesDateBody(
              feeSubHeadId: feeSubHeadId,
              payableDate: payableDate,
              fineActiveDate: fineActiveDate);

            controller.addNewFeesDate(body);
          }

        }, text: "confirm".tr)

        ]);
      }
    );
  }
}
