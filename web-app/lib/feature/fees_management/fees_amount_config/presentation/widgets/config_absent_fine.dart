import 'package:flutter/material.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/feature/academic_configuration/class/controller/class_controller.dart';
import 'package:class_compass/feature/academic_configuration/class/presentation/widgets/select_class_widget.dart';
import 'package:class_compass/feature/academic_configuration/period/controller/period_controller.dart';
import 'package:class_compass/feature/academic_configuration/period/presentation/widgets/select_period_section.dart';
import 'package:class_compass/feature/fees_management/fees_amount_config/controller/fees_controller.dart';
import 'package:class_compass/feature/fees_management/fees_amount_config/domain/model/absent_fine_body.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:get/get.dart';

class NewAbsentFineConfigWidget extends StatefulWidget {
  const NewAbsentFineConfigWidget({super.key});

  @override
  State<NewAbsentFineConfigWidget> createState() => _NewAbsentFineConfigWidgetState();
}

class _NewAbsentFineConfigWidgetState extends State<NewAbsentFineConfigWidget> {
  TextEditingController fineAmountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
      child: Column(mainAxisSize: MainAxisSize.min, spacing: Dimensions.paddingSizeDefault, children: [
        const Row(spacing: Dimensions.paddingSizeDefault, children: [
          Expanded(child: SelectClassWidget()),
          Expanded(child: SelectPeriodWidget())
        ]),

        CustomTextField(
            controller: fineAmountController,
            inputFormatters: [AppConstants.numberFormat],
            inputType: TextInputType.number,
            hintText: "fine".tr, title: "fine".tr, isAmount: true
        ),


        GetBuilder<FeesController>(
            builder: (feesController) {
              return feesController.isLoading?
              const Center(child: CircularProgressIndicator()):
              CustomButton(onTap: (){
                String fine = fineAmountController.text.trim();
                int? classId = Get.find<ClassController>().selectedClassItem?.id;
                int? periodId = Get.find<PeriodController>().selectedPeriodItem?.id;
               if(fine.isEmpty){
                  showCustomSnackBar("fine_is_empty".tr);
                }
                else if(classId == null){
                  showCustomSnackBar("select_class".tr);
                }
                else if(periodId == null){
                  showCustomSnackBar("select_period".tr);
                }

                else{
                  AbsentFineBody body = AbsentFineBody(
                      classId: classId.toString(),
                      periodId: periodId.toString(),
                      amount: fine
                  );
                  Get.find<FeesController>().addNewAbsentFine(body);
                }
              }, text: "confirm");
            }
        )
      ]),
    );
  }
}
