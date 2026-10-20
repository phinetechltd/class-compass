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
import 'package:class_compass/feature/account_management/fund_transfer/domain/model/fund_transfer_body.dart';
import 'package:class_compass/feature/account_management/fund_transfer/logic/fund_transfer_controller.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';

class FundTransferWidget extends StatefulWidget {
  const FundTransferWidget({super.key});

  @override
  State<FundTransferWidget> createState() => _FundTransferWidgetState();
}

class _FundTransferWidgetState extends State<FundTransferWidget> {
  TextEditingController  amountController = TextEditingController();
  TextEditingController  descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountLedgerController>(builder: (accountLedgerController) {
      return GetBuilder<FundTransferController>(builder: (fundTransferController) {
            return Padding(padding: EdgeInsets.all(ResponsiveHelper.isDesktop(context)? 0 : Dimensions.paddingSizeDefault),
              child: Column(children: [
                SectionHeaderWithPath(sectionTitle: "account_management".tr,
                    pathItems: ["fund_transfer".tr]),

                Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                  child: CustomContainer(color: ResponsiveHelper.isDesktop(context)? Theme.of(context).cardColor : Colors.transparent, showShadow: false,
                    child: Column(mainAxisSize: MainAxisSize.min, children: [

                      Row(spacing: Dimensions.paddingSizeDefault,
                        children: [
                          const Expanded(child: DateSelectionWidget()),
                          Expanded(child:  Padding(padding: const EdgeInsets.only(top: 8.0),
                            child: CustomTextField(title: "amount".tr,
                              controller: amountController,
                              inputType: TextInputType.number,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              hintText: "amount".tr,),
                          ),),
                        ],
                      ),


                       Row(spacing: Dimensions.paddingSizeDefault, children: [
                          Expanded(child: SelectAccountingFundWidget(title: "transfer_from".tr)),
                          Expanded(child: SelectAccountingFundWidget(title: "transfer_to".tr,toFund: true )),
                        ],
                      ),


                      CustomTextField(title: "description".tr,
                        controller: descriptionController,
                        minLines: 3, maxLines: 5, maxLength: 200,
                        hintText: "description".tr,),



                      fundTransferController.isLoading? const Center(child: Padding(padding: EdgeInsets.all(8.0), child: CircularProgressIndicator(),)):
                      Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                        child: accountLedgerController.isLoading? const CircularProgressIndicator():
                        Align(alignment: Alignment.centerRight,
                          child: IntrinsicWidth(
                            child: CustomButton(onTap: (){
                                String amount = amountController.text.trim();
                                int? fundId = Get.find<AccountingFundController>().selectedAccountingFundItem?.id;
                                int? fundToId = Get.find<AccountingFundController>().selectedToFundItem?.id;
                                String? date = Get.find<DatePickerController>().formatedDate;
                                String? description = descriptionController.text.trim();

                                if(amount.isEmpty){
                                  showCustomSnackBar("amount_is_empty".tr);
                                }
                                else if(fundId == null){
                                  showCustomSnackBar("select_fund".tr);
                                }
                                else if(fundToId == null){
                                  showCustomSnackBar("select_to_fund".tr);
                                }
                                else if(date.isEmpty){
                                  showCustomSnackBar("select_date".tr);
                                }
                                else{
                                  FundTransferBody body = FundTransferBody(
                                    description: description,
                                    transactionDate: date,
                                    fundId: fundId,
                                    amount: amount,
                                    type: "fund_transfer",
                                    fundToId: fundToId,
                                  );
                                  fundTransferController.fundTransfer(body);
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
