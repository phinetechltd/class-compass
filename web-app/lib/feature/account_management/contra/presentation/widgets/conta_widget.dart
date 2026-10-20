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
import 'package:class_compass/feature/account_management/contra/domain/model/contra_model.dart';
import 'package:class_compass/feature/account_management/contra/logic/contra_controller.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';

class ContraWidget extends StatefulWidget {
  const ContraWidget({super.key});

  @override
  State<ContraWidget> createState() => _ContraWidgetState();
}

class _ContraWidgetState extends State<ContraWidget> {
  TextEditingController  amountController = TextEditingController();
  TextEditingController  refController = TextEditingController();
  TextEditingController  descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountLedgerController>(builder: (accountLedgerController) {
          return GetBuilder<ContraController>(builder: (contraController) {

            return Padding(padding: EdgeInsets.all(ResponsiveHelper.isDesktop(context)? 0 : Dimensions.paddingSizeDefault),
              child: Column(children: [

                SectionHeaderWithPath(sectionTitle: "account_management".tr, pathItems: ["contra".tr]),
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

                      contraController.isLoading? const Center(child: Padding(padding: EdgeInsets.all(8.0), child: CircularProgressIndicator(),)):
                              Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                                child: accountLedgerController.isLoading? const CircularProgressIndicator():
                                Align(alignment: Alignment.centerRight,
                                  child: IntrinsicWidth(
                                    child: CustomButton(onTap: (){
                                      String amount = amountController.text.trim();
                                      int? fundId = Get.find<AccountingFundController>().selectedAccountingFundItem?.id;
                                      int? fundToId = Get.find<AccountingFundController>().selectedToFundItem?.id;
                                      String? date = Get.find<DatePickerController>().formatedDate;
                                      String? ref = refController.text.trim();
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
                                      else if(ref.isEmpty){
                                        showCustomSnackBar("ref_is_empty".tr);
                                      }
                                      else{
                                        ContraBody body = ContraBody(
                                          type: "contra",
                                          paymentMethodId: fundId,
                                          paymentMethodToId: fundToId,
                                          transactionDate: date,
                                          reference: ref,
                                          description: description,
                                        );
                                        contraController.contraTransfer(body);
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
