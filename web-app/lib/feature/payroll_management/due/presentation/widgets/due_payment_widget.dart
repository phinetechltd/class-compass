import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/controller/datepicker_controller.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/feature/master_configuration/employee/controller/employee_controller.dart';
import 'package:class_compass/feature/master_configuration/employee/presentation/widgets/select_employee_widget.dart';
import 'package:class_compass/feature/payroll_management/due/domain/model/due_payment_body.dart';
import 'package:class_compass/feature/payroll_management/due/logic/due_controller.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';

class DuePaymentWidget extends StatefulWidget {
  const DuePaymentWidget({super.key});

  @override
  State<DuePaymentWidget> createState() => _DuePaymentWidgetState();
}

class _DuePaymentWidgetState extends State<DuePaymentWidget> {
  TextEditingController amountController =  TextEditingController();
  TextEditingController noteController =  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SelectEmployeeWidget(),
      CustomTextField(
        hintText: "amount".tr, title: "amount".tr,
          inputType: TextInputType.number,
          inputFormatters: [AppConstants.numberFormat],
          controller: amountController),

      CustomTextField(controller: noteController,
          title: "note".tr, hintText: "note".tr,),


      const SizedBox(height: Dimensions.paddingSizeDefault),
      GetBuilder<DueController>(builder: (dueController) {
          return dueController.loading? const Center(child: CircularProgressIndicator()):
          CustomButton(onTap: (){
            int? userId = Get.find<EmployeeController>().selectedEmployee?.id;
            String amount = amountController.text.trim();
            String note = noteController.text.trim();

            if(userId == null){
              showCustomSnackBar("select_employee".tr);
            }else if(amount.isEmpty){
              showCustomSnackBar("amount_is_required".tr);
            }else{
              DuePaymentBody body = DuePaymentBody(
                userId: userId.toString(),
                amount: amount,
                note: note,
                date: Get.find<DatePickerController>().formatedDate,
                type: "due"
              );
              dueController.duePayment(body);
            }
          }, text: "confirm".tr);
        }
      )

    ]);
  }
}
