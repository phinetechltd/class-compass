import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/feature/question_bank/question_bank_class/domain/model/question_bank_class_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_class/logic/question_bank_class_controller.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';


class CreateNewQuestionBankClassWidget extends StatefulWidget {
  final QuestionBankClassItem? classItem;
  const CreateNewQuestionBankClassWidget({super.key, this.classItem});

  @override
  State<CreateNewQuestionBankClassWidget> createState() => _CreateNewQuestionBankClassWidgetState();
}

class _CreateNewQuestionBankClassWidgetState extends State<CreateNewQuestionBankClassWidget> {
  TextEditingController nameController = TextEditingController();
  bool update = false;
  @override
  void initState() {
    if(widget.classItem != null){
      update = true;
      nameController.text = widget.classItem?.name??'';
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionBankClassController>(
        builder: (classController) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  child: CustomTitle(title: update?  "update_class".tr : "add_new_class".tr, leftPadding: 0, webTitle: ResponsiveHelper.isDesktop(context))),

              CustomTextField(title: "class_name".tr,
                controller: nameController,
                hintText: "enter_class_name".tr,),


              classController.isLoading? const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Center(child: CircularProgressIndicator())):
              Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  child: CustomButton(onTap: (){
                    String name = nameController.text.trim();
                    if(name.isEmpty){
                      showCustomSnackBar("name_is_empty".tr);
                    }else{
                      Get.back();
                      if(update){
                        classController.editQuestionBankClass(name,  widget.classItem!.id!);
                      }else{
                        classController.createQuestionBankClass(name);
                      }

                    }
                  }, text: update? "update".tr : "save".tr))
            ],),
          );
        }
    );
  }
}
