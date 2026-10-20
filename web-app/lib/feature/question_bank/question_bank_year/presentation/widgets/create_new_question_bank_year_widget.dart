import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/feature/question_bank/question_bank_year/domain/model/question_bank_year_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_year/logic/question_bank_year_controller.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';


class CreateNewQuestionBankYearWidget extends StatefulWidget {
  final QuestionBankYearItem? item;
  const CreateNewQuestionBankYearWidget({super.key, this.item});

  @override
  State<CreateNewQuestionBankYearWidget> createState() => _CreateNewQuestionBankYearWidgetState();
}

class _CreateNewQuestionBankYearWidgetState extends State<CreateNewQuestionBankYearWidget> {
  TextEditingController yearTextController = TextEditingController();
  bool update = false;
  @override
  void initState() {
    if(widget.item != null){
      update = true;
      yearTextController.text = widget.item?.year??'';
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionBankYearController>(
        builder: (yearController) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  child: CustomTitle(title: update?  "update_year".tr : "add_new_year".tr, leftPadding: 0, webTitle: ResponsiveHelper.isDesktop(context))),

              CustomTextField(title: "year".tr,
                controller: yearTextController,
                inputType: TextInputType.phone,
                inputFormatters: [AppConstants.phoneNumberFormat],
                hintText: "enter_year".tr,),



              yearController.isLoading? const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Center(child: CircularProgressIndicator())):
              Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  child: CustomButton(onTap: (){
                    String name = yearTextController.text.trim();
                    if(name.isEmpty){
                      showCustomSnackBar("year_is_empty".tr);
                    }else{
                      Get.back();
                      if(update){
                        yearController.editQuestionBankYear(name,  widget.item!.id!);
                      }else{
                        yearController.createQuestionBankYear(name);
                      }

                    }
                  }, text: update? "update".tr : "save".tr))
            ],),
          );
        }
    );
  }
}
