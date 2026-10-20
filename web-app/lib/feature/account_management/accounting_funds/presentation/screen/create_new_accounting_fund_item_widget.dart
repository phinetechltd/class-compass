import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/feature/account_management/accounting_funds/domain/model/account_fund_model.dart';
import 'package:class_compass/feature/account_management/accounting_funds/logic/account_fund_controller.dart';
import 'package:class_compass/util/dimensions.dart';

class CreateNewAccountingFundWidget extends StatefulWidget {
  final AccountingFundItem? accountingFundItem;
  const CreateNewAccountingFundWidget({super.key, this.accountingFundItem});

  @override
  State<CreateNewAccountingFundWidget> createState() => _CreateNewAccountingFundWidgetState();
}

class _CreateNewAccountingFundWidgetState extends State<CreateNewAccountingFundWidget> {

  TextEditingController  nameController = TextEditingController();

  bool updateAccount = false;

  @override
  void initState() {

    if(widget.accountingFundItem != null) {
      nameController.text = widget.accountingFundItem?.name??'';
      updateAccount = true;

    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountingFundController>(builder: (accountingFundController) {
          return Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Column(mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(title: "name".tr, 
                  controller: nameController,
                  hintText: "enter_name".tr,),


                Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  child: accountingFundController.isLoading? const CircularProgressIndicator():
                  CustomButton(onTap: (){

                    String name = nameController.text.trim();

                    if(name.isEmpty){
                      showCustomSnackBar("name_is_empty".tr);
                    }
                    else{

                      if(updateAccount){
                        accountingFundController.updateAccountingFund(name, widget.accountingFundItem!.id!);
                      }else{
                        accountingFundController.createNewAccountingFund(name);
                      }
                    }
                  }, text: "confirm".tr),
                )


              ],
            ),
          );
        }
    );
  }
}
