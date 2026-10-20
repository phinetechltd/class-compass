
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/controller/datepicker_controller.dart';
import 'package:class_compass/common/widget/active_inactive_widget.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/common/widget/horizontal_divider.dart';
import 'package:class_compass/feature/account_management/accounting_ledger/presentation/widgets/accounting_ledger_selection_widget.dart';
import 'package:class_compass/feature/fees_management/smart_collection/controller/smart_collection_controller.dart';
import 'package:class_compass/feature/fees_management/smart_collection/domain/model/smart_collection_body.dart';
import 'package:class_compass/feature/fees_management/smart_collection/domain/model/smart_collection_details_model.dart';
import 'package:class_compass/feature/fees_management/smart_collection/presentation/widgets/available_fees_widget.dart';
import 'package:class_compass/feature/fees_management/smart_collection/presentation/widgets/available_fine_widget.dart';
import 'package:class_compass/feature/fees_management/smart_collection/presentation/widgets/select_fee_head_for_amount_widget.dart';
import 'package:class_compass/feature/fees_management/smart_collection/presentation/widgets/student_info_widget_fees_collection.dart';
import 'package:class_compass/feature/profile/logic/profile_controller.dart';
import 'package:class_compass/helper/price_converter.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class QuickCollectionDetailsWidget extends StatefulWidget {
  const QuickCollectionDetailsWidget({super.key});

  @override
  State<QuickCollectionDetailsWidget> createState() => _QuickCollectionDetailsWidgetState();
}

class _QuickCollectionDetailsWidgetState extends State<QuickCollectionDetailsWidget> {
  TextEditingController commentController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (profileController) {
      return GetBuilder<SmartCollectionController>(builder: (smartCollection) {
        bool isParent = (profileController.profileModel?.data?.role == AppConstants.parent);
        bool isStudent = (profileController.profileModel?.data?.role == AppConstants.student);
        SmartCollectionDetailsModel? smartCollectionDetailsModel = smartCollection.smartCollectionDetailsModel;
        SmartItem? smartItem = smartCollectionDetailsModel?.data;

        double totalPaid = smartCollection.calculationModel.fold(
            0.0,
                (sum, model) => sum + (model.amounts?.totalPaid ?? 0)) +
            smartCollection.quizFineAmount +
            smartCollection.attendanceFineAmount +
            smartCollection.labFineAmount +
            smartCollection.tcChargeAmount;

        double totalPayable = smartCollection.calculationModel.fold(
            0.0,
                (sum, model) => sum + (model.amounts?.totalPayable ?? 0)) +
            smartCollection.quizFineAmount +
            smartCollection.attendanceFineAmount +
            smartCollection.labFineAmount +
            smartCollection.tcChargeAmount;



        return smartCollectionDetailsModel != null?
        Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Column(spacing: Dimensions.paddingSizeDefault,
          crossAxisAlignment: CrossAxisAlignment.start, children: [


            const StudentInfoWidgetFeesCollection(),

            const SelectFeeHeadForAmountWidget(),

            CustomContainer(borderRadius: Dimensions.paddingSizeExtraSmall,
                child: Row(spacing: Dimensions.paddingSizeSmall, children: [
                  Expanded(child: Text("total_paid".tr, style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall))),
                  const HorizontalDivider(),
                  Expanded(child: Text("waiver".tr, style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall))),
                  const HorizontalDivider(),
                  Expanded(child: Text("fine_payable".tr, style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall))),
                  const HorizontalDivider(),
                  Expanded(child: Text("fee_payable".tr, style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall))),
                  const HorizontalDivider(),
                  Expanded(child: Text("fee_and_fine_payable".tr, style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall))),
                  const HorizontalDivider(),
                  Expanded(child: Text("total_payable".tr, style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall))),
                  ])),


            const AvailableFeesWidget(),
            const AvailableFineWidget(),

            Row(crossAxisAlignment: CrossAxisAlignment.end,
              spacing: Dimensions.paddingSizeSmall, children: [

                Expanded(flex: 4, child: CustomTextField(
                    title: "comment".tr,
                    controller: commentController,
                    hintText: "comments".tr)),
              ]),


            Row(crossAxisAlignment: CrossAxisAlignment.end,
              spacing: Dimensions.paddingSizeSmall, children: [

                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text("paid_amount".tr, style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),
                    ),
                    CustomContainer(borderRadius: 5,showShadow: false,
                      border: Border.all(color: Theme.of(context).hintColor, width: .5),
                      child: Text(PriceConverter.convertPrice(context,
                            smartCollection.calculationModel.fold(0.0, (sum, model) => sum + (model.amounts?.totalPaid ?? 0))
                        ),
                        style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                      ),
                    ),
                  ],
                )),


                if(!isParent && !isStudent)
                  const Expanded(flex:2,
                      child: SelectAccountingLedgerWidget(title: 'paid_by', showBalance: true)),

                if(!isParent && !isStudent)
                  Row(spacing: Dimensions.paddingSizeSmall, children: [
                    ActiveInActiveWidget(active: smartCollection.sendSms,
                      onChanged: (val){
                      smartCollection.toggleSendSms();
                      },),
                    Text("sent_sms".tr, style: textRegular)],),

                SizedBox(width : 180, child: smartCollection.isLoading?
                const Center(child: CircularProgressIndicator()):

                CustomButton(onTap: (){
                  String comment = commentController.text.trim();

                  List<FeeHead>? feeHeads = [];
                  feeHeads.addAll(
                      smartCollection.calculationModel.map((model) => FeeHead(
                          feeHeadId: model.feeHeadId.toString(),
                          subHeadIds: model.feeSubHeads,
                          totalPaid: model.amounts?.totalPaid.toString(),
                          waiver: model.amounts?.waiver.toString(),
                          finePayable: model.amounts?.finePayable.toString(),
                          feePayable: model.amounts?.feePayable.toString(),
                          feeAndFinePayable: model.amounts?.feeAndFinePayable.toString(),
                          previousDuePaid: model.amounts?.previousDuePaid.toString(),
                          previousDuePayable: model.amounts?.previousDuePayable.toString(),
                          totalPayable: model.amounts?.totalPayable.toString()))
                  );

                  SmartCollectionBody body =  SmartCollectionBody(
                      studentId: smartItem?.studentSession?.studentId,
                      feeHeads: feeHeads,
                      attendanceFine: smartCollection.attendanceFineAmount,
                      quizFine: smartCollection.quizFineAmount,
                      totalPaid: totalPaid.toString(),
                      totalPayable: totalPayable.toString(),
                      smsStatus: smartCollection.sendSms? "1" : "0",
                      tcAmount: smartCollection.tcChargeAmount,
                      date: Get.find<DatePickerController>().formatedDate,
                      ledgerId: 1,
                      note: comment);

                  if(totalPayable>0){
                    smartCollection.collectSmartCollection(body);
                  }else{
                    showCustomSnackBar("invalid_request".tr);
                  }
                  }, text:  (!isParent && !isStudent)?
                "process_to_collection".tr : "payment".tr)),
              ],
            )
          ],),
        ): const Center(child: CircularProgressIndicator());
      }
      );
      }
    );
  }
}
class CostItem extends StatelessWidget {
  final double amount;
  const CostItem({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Text(PriceConverter.convertPrice(context, amount),
        style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall)));
  }
}

