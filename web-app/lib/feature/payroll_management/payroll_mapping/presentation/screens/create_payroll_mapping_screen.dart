import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/account_management/accounting_funds/logic/account_fund_controller.dart';
import 'package:class_compass/feature/account_management/accounting_funds/presentation/widgets/accounting_fund_selection_widget.dart';
import 'package:class_compass/feature/account_management/accounting_ledger/logic/account_ledger_controller.dart';
import 'package:class_compass/feature/account_management/accounting_ledger/presentation/widgets/accounting_ledger_selection_widget.dart';
import 'package:class_compass/feature/payroll_management/payroll_mapping/domain/models/payroll_mapping_body.dart';
import 'package:class_compass/feature/payroll_management/payroll_mapping/domain/models/payroll_mapping_model.dart';
import 'package:class_compass/feature/payroll_management/payroll_mapping/logic/payroll_mapping_controller.dart';
import 'package:class_compass/util/dimensions.dart';

class CreatePayrollMappingScreen extends StatefulWidget {
  final PayrollMappingItem? payrollMappingItem;
  
  const CreatePayrollMappingScreen({super.key, this.payrollMappingItem});

  @override
  State<CreatePayrollMappingScreen> createState() => _CreatePayrollMappingScreenState();
}

class _CreatePayrollMappingScreenState extends State<CreatePayrollMappingScreen> {
  bool isUpdate = false;
  @override
  void initState() {
    super.initState();
    isUpdate = widget.payrollMappingItem != null;
    if (isUpdate) {
      Get.find<PayrollMappingController>().fillForm(widget.payrollMappingItem!);
    } else {
      Get.find<PayrollMappingController>().clearForm();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PayrollMappingController>(
      builder: (controller) {
        return Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
              Row(spacing: Dimensions.paddingSizeDefault, children: [
                Expanded(child: SelectAccountingLedgerWidget(title: "payment_for".tr)),
                Expanded(child: SelectAccountingFundWidget(title: "paid_by".tr))

              ]),

            controller.loading? const Center(child: CircularProgressIndicator()):
            CustomButton(onTap: () {
              int? ledgerId = Get.find<AccountLedgerController>().selectedAccountingLedgerItemForTransaction?.id;
              int? fundId = Get.find<AccountingFundController>().selectedAccountingFundItem?.id;
              if (ledgerId == null) {
                showCustomSnackBar("select_ledger".tr);
              } else if (fundId == null) {
                showCustomSnackBar("select_fund".tr);
              } else{
                Get.back();
                PayrollMappingBody body = PayrollMappingBody(ledgerId: ledgerId, fundId: fundId);
              controller.createPayrollMapping(body);
            }}, text: "save".tr)
            ],
          ),
        );
      },
    );
  }
}
