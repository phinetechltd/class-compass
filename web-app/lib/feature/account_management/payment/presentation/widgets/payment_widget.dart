import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/controller/datepicker_controller.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/common/widget/date_selection_widget.dart';
import 'package:class_compass/common/widget/section_header_with_path_widget.dart';
import 'package:class_compass/feature/account_management/accounting_funds/logic/account_fund_controller.dart';
import 'package:class_compass/feature/account_management/accounting_funds/presentation/widgets/accounting_fund_selection_widget.dart';
import 'package:class_compass/feature/account_management/accounting_ledger/logic/account_ledger_controller.dart';
import 'package:class_compass/feature/account_management/accounting_ledger/presentation/widgets/accounting_ledger_selection_widget.dart';
import 'package:class_compass/feature/account_management/payment/domain/model/payment_body.dart';
import 'package:class_compass/feature/account_management/payment/logic/payment_controller.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';

class PaymentWidget extends StatefulWidget {
  final bool fromReceipt;
  const PaymentWidget({super.key, required this.fromReceipt});

  @override
  State<PaymentWidget> createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentWidget> {
  TextEditingController  amountController = TextEditingController();
  TextEditingController  refController = TextEditingController();
  TextEditingController  descriptionController = TextEditingController();
  TextEditingController  dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountLedgerController>(builder: (accountLedgerController) {
          return GetBuilder<PaymentController>(builder: (paymentController) {
                return Padding(padding: EdgeInsets.all(ResponsiveHelper.isDesktop(context)? 0 : Dimensions.paddingSizeDefault),
                  child: Column(children: [

                    SectionHeaderWithPath(sectionTitle: "account_management".tr,
                        pathItems: [ widget.fromReceipt? "receipt".tr : "payment".tr]),

                      Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                        child: CustomContainer(color: ResponsiveHelper.isDesktop(context)? Theme.of(context).cardColor : Colors.transparent, showShadow: false,
                          child: Column(mainAxisSize: MainAxisSize.min, children: [

                               Row(spacing: Dimensions.paddingSizeDefault, children: [
                                  Expanded(child: DateSelectionWidget(title: widget.fromReceipt?"receipt_date".tr:"payment_date".tr,)),
                                  Expanded(child: SelectAccountingLedgerWidget(showBalance: true, title:  widget.fromReceipt?"receipt_by":"payment_by")),
                                ],
                              ),

                            Row(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeDefault, children: [
                              const Expanded(child: SelectAccountingLedgerWidget(title: "transaction_for")),

                              Expanded(child:  Padding(padding: const EdgeInsets.only(top: 8.0),
                                child: CustomTextField(title: "amount".tr,
                                  controller: amountController,
                                  inputType: TextInputType.number,
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  hintText: "amount".tr,),
                              ),),
                            ],
                            ),

                              Row(spacing: Dimensions.paddingSizeDefault,children: [
                                const Expanded(child: SelectAccountingFundWidget(title: "fund")),
                                Expanded(child: CustomTextField(title: "ref".tr,
                                    controller: refController, hintText: "ref".tr)),
                              ]),


                              CustomTextField(title: "description".tr,
                                controller: descriptionController,
                                minLines: 3,
                                maxLines: 5,
                                maxLength: 200,
                                hintText: "description".tr,),


                              paymentController.isLoading? const Center(child: Padding(padding: EdgeInsets.all(8.0), child: CircularProgressIndicator(),)):
                              Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                                child: accountLedgerController.isLoading? const CircularProgressIndicator():
                                Align(alignment: Alignment.centerRight,
                                  child: IntrinsicWidth(
                                    child: CustomButton(onTap: (){
                                      String amount = amountController.text.trim();
                                      int? paymentMethodId = Get.find<AccountLedgerController>().selectedAccountingLedgerItemForPayment?.id;
                                      int? ledgerId = Get.find<AccountLedgerController>().selectedAccountingLedgerItemForTransaction?.id;
                                      int? fundId = Get.find<AccountingFundController>().selectedAccountingFundItem?.id;
                                      String? date = Get.find<DatePickerController>().formatedDate;
                                      String? ref = refController.text.trim();
                                      String? description = descriptionController.text.trim();

                                      if(amount.isEmpty){
                                        showCustomSnackBar("amount_is_empty".tr);
                                      }

                                      else if(paymentMethodId == null){
                                        showCustomSnackBar("select_payment_method".tr);
                                      }
                                      else if(ledgerId == null){
                                        showCustomSnackBar("select_transaction_type".tr);
                                      }
                                      else if(fundId == null){
                                        showCustomSnackBar("select_fund".tr);
                                      }
                                      else if(date.isEmpty){
                                        showCustomSnackBar("select_date".tr);
                                      }
                                      else if(ref.isEmpty){
                                        showCustomSnackBar("ref_is_empty".tr);
                                      }
                                      else{
                                        PaymentBody paymentBody = PaymentBody(
                                          type: widget.fromReceipt? "receipt" : "payment",
                                          amounts: [amount],
                                          paymentMethodId: paymentMethodId,
                                          ledgerIds: [ledgerId],
                                          fundId: fundId,
                                          transactionDate: date,
                                          reference: ref,
                                          description: description,
                                        );
                                        paymentController.createPayment(paymentBody);
                                      }
                                    }, text: "confirm".tr),
                                  ),
                                ),
                              )


                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
          );
        }
    );
  }
}
