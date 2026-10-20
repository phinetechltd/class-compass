import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/feature/question_bank/question_bank_types/domain/model/question_bank_types_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_types/logic/question_bank_types_controller.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';


class CreateNewQuestionBankTypesWidget extends StatefulWidget {
  final QuestionBankTypesItem? item;
  const CreateNewQuestionBankTypesWidget({super.key, this.item});

  @override
  State<CreateNewQuestionBankTypesWidget> createState() => _CreateNewQuestionBankTypesWidgetState();
}

class _CreateNewQuestionBankTypesWidgetState extends State<CreateNewQuestionBankTypesWidget> {
  TextEditingController nameController = TextEditingController();
  bool update = false;
  @override
  void initState() {
    if(widget.item != null){
      update = true;
      nameController.text = widget.item?.typeName??'';
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionBankTypesController>(
        builder: (typesController) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  child: CustomTitle(title: update?  "update_type".tr : "add_new_type".tr, leftPadding: 0, webTitle: ResponsiveHelper.isDesktop(context))),

              CustomTextField(title: "type_name".tr,
                controller: nameController,
                hintText: "enter_type_name".tr,),



              typesController.isLoading? const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Center(child: CircularProgressIndicator())):
              Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  child: CustomButton(onTap: (){
                    String name = nameController.text.trim();
                    if(name.isEmpty){
                      showCustomSnackBar("name_is_empty".tr);
                    }else{
                      Get.back();
                      if(update){
                        typesController.editQuestionBankTypes(name,  widget.item!.id!);
                      }else{
                        typesController.createQuestionBankTypes(name);
                      }

                    }
                  }, text: update? "update".tr : "save".tr))
            ],),
          );
        }
    );
  }
}
