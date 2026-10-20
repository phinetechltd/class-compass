import 'package:flutter/material.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/feature/academic_configuration/class/controller/class_controller.dart';
import 'package:class_compass/feature/academic_configuration/class/presentation/widgets/select_class_widget.dart';
import 'package:class_compass/feature/academic_configuration/group/controller/group_controller.dart';
import 'package:class_compass/feature/academic_configuration/group/presentation/widgets/select_group_widget.dart';
import 'package:class_compass/feature/academic_configuration/student_categories/controller/student_categories_controller.dart';
import 'package:class_compass/feature/academic_configuration/student_categories/presentation/widgets/select_student_category_widget.dart';
import 'package:class_compass/feature/account_management/accounting_funds/logic/account_fund_controller.dart';
import 'package:class_compass/feature/account_management/accounting_funds/presentation/widgets/accounting_fund_selection_widget.dart';
import 'package:class_compass/feature/fees_management/fees_amount_config/controller/fees_controller.dart';
import 'package:class_compass/feature/fees_management/fees_amount_config/domain/model/fees_body.dart';
import 'package:class_compass/feature/fees_management/fees_head/controller/fees_head_controller.dart';
import 'package:class_compass/feature/fees_management/fees_head/presentation/widgets/select_fees_head_widget.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:get/get.dart';

class NewAmountConfigWidget extends StatefulWidget {
  const NewAmountConfigWidget({super.key});

  @override
  State<NewAmountConfigWidget> createState() => _NewAmountConfigWidgetState();
}

class _NewAmountConfigWidgetState extends State<NewAmountConfigWidget> {
  TextEditingController feesAmountController = TextEditingController();
  TextEditingController fineAmountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
      child: Column(mainAxisSize: MainAxisSize.min, spacing: Dimensions.paddingSizeDefault, children: [
        const Row(spacing: Dimensions.paddingSizeDefault, children: [
          Expanded(child: SelectClassWidget()),
          Expanded(child: SelectGroupWidget())
        ]),
        Row(spacing: Dimensions.paddingSizeDefault, children: [
          const Expanded(child: SelectStudentCategoryWidget()),
          const Expanded(child: SelectFeesHeadWidget()),
          Expanded(child: SelectAccountingFundWidget(title: "fund".tr))
        ]),
        Row(spacing: Dimensions.paddingSizeDefault, children: [
          Expanded(child: CustomTextField(controller: feesAmountController,
              inputFormatters: [AppConstants.numberFormat],
              inputType: TextInputType.number,
              hintText: "fees".tr, title: "fees".tr, isAmount: true)),
          Expanded(child: CustomTextField(
              controller: fineAmountController,
              inputFormatters: [AppConstants.numberFormat],
              inputType: TextInputType.number,
              hintText: "fine".tr, title: "fine".tr, isAmount: true
          )),
        ]),



        GetBuilder<FeesController>(
          builder: (feesController) {
            return feesController.isLoading?
                const Center(child: CircularProgressIndicator()):
            CustomButton(onTap: (){
              String fees = feesAmountController.text.trim();
              String fine = fineAmountController.text.trim();
              int? classId = Get.find<ClassController>().selectedClassItem?.id;
              int? groupId = Get.find<GroupController>().groupItem?.id;
              int? studentCategoryId = Get.find<StudentCategoriesController>().selectedStudentCategories?.id;
              int? feesHeadId = Get.find<FeesHeadController>().selectedFeesHeadItem?.id;
              int? fundId = Get.find<AccountingFundController>().selectedAccountingFundItem?.id;
              if(fees.isEmpty){
                showCustomSnackBar("fees_is_empty".tr);
              }
              else if(fine.isEmpty){
                showCustomSnackBar("fine_is_empty".tr);
              }
              else if(classId == null){
                showCustomSnackBar("select_class".tr);
              }
              else if(groupId == null){
                showCustomSnackBar("select_group".tr);
              }
              else if(studentCategoryId == null){
                showCustomSnackBar("select_student_category".tr);
              }
              else if(feesHeadId == null){
                showCustomSnackBar("select_fees_head".tr);
              }else if(fundId == null){
                showCustomSnackBar("select_fund".tr);
              }
              else{
                FeesBody body = FeesBody(
                    classId: classId.toString(),
                    groupId: groupId.toString(),
                    studentCategoryId: studentCategoryId.toString(),
                    feeHeadId: feesHeadId.toString(),
                    fundId: fundId.toString(),
                    feeAmount: fees,
                    fineAmount: fine
                );
                Get.find<FeesController>().addNewFees(body);
              }
            }, text: "confirm");
          }
        )
      ]),
    );
  }
}
