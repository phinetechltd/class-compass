import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/feature/master_configuration/employee/controller/employee_controller.dart';
import 'package:class_compass/feature/master_configuration/employee/domain/models/employee_model.dart';
import 'package:class_compass/feature/master_configuration/employee/presentation/widgets/select_employee_widget.dart';
import 'package:class_compass/feature/payroll_management/advance/domain/models/advance_salary_body.dart';
import 'package:class_compass/feature/payroll_management/advance/domain/models/advance_salary_model.dart';
import 'package:class_compass/feature/payroll_management/advance/logic/advance_controller.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';

class AddAdvanceSalaryWidget extends StatefulWidget {
  final UserPayroll? advanceSalaryItem;

  const AddAdvanceSalaryWidget({super.key, this.advanceSalaryItem});

  @override
  State<AddAdvanceSalaryWidget> createState() => _AddAdvanceSalaryWidgetState();
}

class _AddAdvanceSalaryWidgetState extends State<AddAdvanceSalaryWidget> {
  bool isUpdate = false;
  TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if(widget.advanceSalaryItem != null){
      isUpdate = true;
      amountController.text = widget.advanceSalaryItem?.currentAdvance?.toString()??"0";
      Get.find<EmployeeController>().selectEmployee(EmployeeItem(
        name: widget.advanceSalaryItem?.user?.name,
          id: widget.advanceSalaryItem?.user?.id), notify: false);
    }

  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdvanceController>(builder: (controller) {
      return Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Column(spacing: Dimensions.paddingSizeDefault, children: [

            const SelectEmployeeWidget(),

            CustomTextField(
                controller: amountController,
                hintText: "enter_amount".tr,
                title: "amount".tr,
                inputFormatters: [AppConstants.numberFormat],
                inputType: TextInputType.number),


            controller.loading? const Center(child: CircularProgressIndicator()):
            CustomButton(onTap: () {
              String amount = amountController.text.trim();
              int? employeeId = Get.find<EmployeeController>().selectedEmployee?.id;

              if (employeeId == null) {
                showCustomSnackBar("select_employee".tr);
              }else if(amount.isEmpty){
                showCustomSnackBar("enter_amount".tr);
              }else{

              AdvanceSalaryBody advanceSalaryBody = AdvanceSalaryBody(
                  userId: employeeId,
                  amount: amount,
                  date: controller.formatedDate,
                  type: "advanced",
                  paymentMethodId: "1");

              if (isUpdate) {
                controller.editAdvanceSalary(advanceSalaryBody, widget.advanceSalaryItem!.id!,);
              } else {
                controller.createAdvanceSalary(advanceSalaryBody);
              }
              }
            }, text: isUpdate ? "update".tr : "save".tr),
          ]));
    });
  }
}
