import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_item_text_widget.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/common/widget/heading_menu_widget.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/exam_management/mark_config/controller/mark_config_controller.dart';
import 'package:class_compass/feature/exam_management/mark_config/domain/model/grand_final_exam_percentage_store_body.dart';
import 'package:class_compass/util/dimensions.dart';

class GrandFinalMarkPercentageUpdateWidget extends StatelessWidget {
  const GrandFinalMarkPercentageUpdateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MarkConfigController>(
      builder: (markConfigController) {
        final grandFinalExamPercentageBodyList = markConfigController.grandFinalExamPercentageBodyList;
        return Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const HeadingMenu(headings: ["exam_name", "percentage", "exam_serial"], showActionOption: false),
            ListView.separated(
              shrinkWrap: true,
                itemCount: grandFinalExamPercentageBodyList?.length??0,
                padding: EdgeInsets.zero,
                itemBuilder: (_, index){
                  GrandFinalExamPercentageBody body = grandFinalExamPercentageBodyList![index];
              return Row(spacing: Dimensions.paddingSizeDefault, children: [
                NumberingWidget(index: index),
                Expanded(child: CustomItemTextWidget(text: body.name)),
                Expanded(child: CustomTextField(controller: body.percentage,hintText: "0",)),
                Expanded(child: CustomTextField(hintText: "1", controller: body.serialNo)),
              ]);
            }, separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: Dimensions.paddingSizeDefault);
            },),
            const SizedBox(height: Dimensions.paddingSizeDefault),
            Row(mainAxisAlignment: MainAxisAlignment.end, spacing: Dimensions.paddingSizeDefault, children: [

              IntrinsicWidth(child: CustomButton(
                buttonColor: Colors.transparent,
                  borderColor: Theme.of(context).colorScheme.error,
                  borderWidth: .25,
                  onTap: ()=> Get.back(), text: "cancel".tr)),
              IntrinsicWidth(child: markConfigController.isLoading?
              const Center(child: CircularProgressIndicator()):
              CustomButton(onTap: (){
                Get.back();
                double totalPercentage = 0;
                List<Percentages>? percentages = [];
                List<SerialNo>? serialNo = [];
                for(GrandFinalExamPercentageBody body in grandFinalExamPercentageBodyList!){

                  double percent = double.tryParse(body.percentage.text) ?? 0;
                  totalPercentage += percent;
                  percentages.add(Percentages(examId: body.examId, percentage: body.percentage.text));
                  serialNo.add(SerialNo(examId: body.examId, serialNo: body.serialNo.text));
                }

                if (totalPercentage != 100){
                  showCustomSnackBar("total_percentage_should_be_100".tr);
                }else{

                  int? selectedClassId = markConfigController.selectedClassId;
                  GrandFinalExamPercentageStoreBody body = GrandFinalExamPercentageStoreBody(
                      classId: selectedClassId,
                      percentages: percentages,
                      serialNo: serialNo);
                  markConfigController.storeGrandFinalExamPercentage(body);
                }

              }, text: "submit".tr)),
            ])
          ]),
        );
      }
    );
  }
}
