import 'dart:developer';

import 'package:flutter/material.dart';
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
import 'package:class_compass/feature/account_management/accounting_ledger/presentation/widgets/dynamic_ledger_item_select_widget.dart';
import 'package:class_compass/feature/account_management/journal/domain/model/journal_body.dart';
import 'package:class_compass/feature/account_management/journal/logic/journal_controller.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';

class JournalWidget extends StatefulWidget {
  const JournalWidget({super.key});

  @override
  State<JournalWidget> createState() => _JournalWidgetState();
}

class _JournalWidgetState extends State<JournalWidget> {
  TextEditingController  descriptionController = TextEditingController();
  TextEditingController  refController = TextEditingController();
  TextEditingController  debitController = TextEditingController();
  TextEditingController  creditController = TextEditingController();


  @override
  void initState() {
    Get.find<JournalController>().addDebitCreditTransaction(notify: false);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<JournalController>(builder: (journalController) {
      return Padding(padding: EdgeInsets.all(ResponsiveHelper.isDesktop(context)? 0 : Dimensions.paddingSizeDefault),
        child: Column(children: [

          SectionHeaderWithPath(sectionTitle: "account_management".tr, pathItems: ["journal".tr]),

          Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            child: CustomContainer(color: ResponsiveHelper.isDesktop(context)? Theme.of(context).cardColor : Colors.transparent, showShadow: false,
              child: Column(mainAxisSize: MainAxisSize.min, children: [


                Row(spacing: Dimensions.paddingSizeDefault, children: [
                  Expanded(child: DateSelectionWidget(title: "journal_date".tr,)),
                  Expanded(child: SelectAccountingFundWidget(title: "fund".tr)),
                ],
                ),



                Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                  child: Row(children: [
                    Expanded(child: Text("cash_ledger".tr)),
                    Expanded(child: Text("debit".tr)),
                    Expanded(child: Text("credit".tr)),
                  ]),
                ),
                Row(spacing: Dimensions.paddingSizeDefault,
                  children: [
                    const Expanded(child: SelectAccountingLedgerWidget(title: "",)),
                    Expanded(child: CustomTextField(
                      hintText: "0",
                      onChanged: (val) {
                        journalController.updateDebitCreditState(true);
                      },
                      controller: debitController,
                      inputFormatters: [AppConstants.numberFormat],
                      inputType: TextInputType.number,
                      isEnabled: (journalController.debitEnabled == 0 || journalController.debitEnabled == 1),
                    )),
                    Expanded(child: CustomTextField(
                      hintText: "0",
                      onChanged: (val) {
                        journalController.updateDebitCreditState(false);
                      },
                      controller: creditController,
                      inputFormatters: [AppConstants.numberFormat],
                      inputType: TextInputType.number,
                      isEnabled: (journalController.debitEnabled == 0 || journalController.debitEnabled == 2),
                    )),
                  ],
                ),



                Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                  child: Row(children: [
                    Expanded(child: Text("transaction_for".tr)),
                    Expanded(child: Text("debit".tr)),
                    Expanded(child: Text("credit".tr)),
                    Text("action".tr),
                  ]),
                ),
                ListView.separated(itemBuilder: (_,index){
                  final item = journalController.debitCreditTransactionList[index];
                  return Row(spacing: Dimensions.paddingSizeDefault,
                    children: [
                       Expanded(child: SelectDynamicAccountingLedgerWidget(
                        selectedValue: item.item,
                        onSelect: (ledger) => journalController.updateSelectedLedgerItem(index, ledger),
                      )),
                      Expanded(child: CustomTextField(
                        hintText: "0",
                        controller: item.debitController,
                        inputFormatters: [AppConstants.numberFormat],
                        inputType: TextInputType.number,
                        isEnabled: journalController.debitEnabled == 2,
                      )),
                      Expanded(child: CustomTextField(
                        hintText: "0",
                        controller: item.creditController,
                        inputFormatters: [AppConstants.numberFormat],
                        inputType: TextInputType.number,
                        isEnabled:journalController.debitEnabled ==1,
                      )),

                     Row(spacing: Dimensions.paddingSizeSmall, children: [
                       CustomContainer(onTap: ()=> journalController.addDebitCreditTransaction(),
                         color: Theme.of(context).primaryColor.withValues(alpha: .2),
                         child: Icon(Icons.add, color: Theme.of(context).primaryColor),),

                       if(index>0)
                         CustomContainer(onTap: ()=> journalController.removeDebitCreditTransaction(index),
                             color: Theme.of(context).primaryColor.withValues(alpha: .2),
                             child: Icon(Icons.remove, color: Theme.of(context).primaryColor)),
                     ])

                    ],
                  );
                }, separatorBuilder: (_, index){
                  return const SizedBox(height: Dimensions.paddingSizeDefault);
                }, itemCount: journalController.debitCreditTransactionList.length,
                  shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                ),


                Row(spacing: Dimensions.paddingSizeDefault, children: [
                  Expanded(
                    child: CustomTextField(title: "ref".tr,
                      controller: refController,
                      hintText: "ref".tr,),
                  ),

                  Expanded(
                    child: CustomTextField(title: "description".tr,
                      controller: descriptionController,
                      maxLength: 200,
                      hintText: "description".tr,),
                  ),


                ]),



                journalController.isLoading? const Center(child: CircularProgressIndicator()):
                Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  child:
                  Align(alignment: Alignment.centerRight,
                    child: IntrinsicWidth(
                      child: CustomButton(onTap: (){
                        int? cashLedgerId = Get.find<AccountLedgerController>().selectedAccountingLedgerItemForTransaction?.id;
                        int? fundId = Get.find<AccountingFundController>().selectedAccountingFundItem?.id;
                        String? date = Get.find<DatePickerController>().formatedDate;
                        String? ref = refController.text.trim();
                        String? description = descriptionController.text.trim();
                        String cashDebit = debitController.text.trim();
                        String cashCredit = creditController.text.trim();

                        List<String> debits = [];
                        List<String> credits = [];
                        List<int> ledgerIds = [];
                        double totalDebit = 0;
                        double totalCredit = 0;
                        double cashDebitValue = double.tryParse(cashDebit) ?? 0;
                        double cashCreditValue = double.tryParse(cashCredit) ?? 0;

                        for(var item in journalController.debitCreditTransactionList){
                          if(item.item != null){
                            debits.add(item.debitController.text);
                            credits.add(item.creditController.text);
                            ledgerIds.add(item.ledgerId!);
                            totalDebit += double.tryParse(item.debitController.text.trim()) ?? 0;
                            totalCredit += double.tryParse(item.creditController.text.trim()) ?? 0;

                          }
                        }

                        log("different==> ${totalDebit+totalCredit} and ${cashCreditValue+cashDebitValue}");

                        if(cashLedgerId == null){
                          showCustomSnackBar("select_cash_ledger".tr);
                        }
                        else if(cashDebit.isEmpty && cashCredit.isEmpty){
                          showCustomSnackBar("cash_debit_credit_both_empty".tr);
                        }

                        else if((totalDebit + totalCredit) != (cashCreditValue + cashDebitValue)){
                          showCustomSnackBar("cash_balance_and_transaction_balance_not_match".tr);
                        }

                        else if(ledgerIds.isEmpty){
                          showCustomSnackBar("ledger_is_empty".tr);
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
                          JournalBody body = JournalBody(
                            transactionDate: date,
                            fundId: fundId,
                            type: "journal",
                            cashDebit: cashDebit,
                            cashLedgerId: cashLedgerId,
                            cashCredit: cashCredit,
                            ledgerIds: ledgerIds,
                            debits: debits,
                            credits: credits,
                            description: description,
                          );
                          journalController.journalTransfer(body);

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
}
