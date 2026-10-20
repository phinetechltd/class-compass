import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/feature/question_bank/question_bank_tag/domain/model/question_bank_tag_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_tag/logic/question_bank_tag_controller.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';


class CreateNewQuestionBankTagWidget extends StatefulWidget {
  final QuestionBankTagItem? item;
  const CreateNewQuestionBankTagWidget({super.key, this.item});

  @override
  State<CreateNewQuestionBankTagWidget> createState() => _CreateNewQuestionBankTagWidgetState();
}

class _CreateNewQuestionBankTagWidgetState extends State<CreateNewQuestionBankTagWidget> {
  TextEditingController tagTextController = TextEditingController();
  bool update = false;
  @override
  void initState() {
    if(widget.item != null){
      update = true;
      tagTextController.text = widget.item?.tagName??'';
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionBankTagController>(
        builder: (tagController) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  child: CustomTitle(title: update?  "update_year".tr : "add_new_tag".tr, leftPadding: 0, webTitle: ResponsiveHelper.isDesktop(context))),

              CustomTextField(title: "tag".tr,
                controller: tagTextController,
                hintText: "enter_tag".tr,),



              tagController.isLoading? const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Center(child: CircularProgressIndicator())):
              Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  child: CustomButton(onTap: (){
                    String name = tagTextController.text.trim();
                    if(name.isEmpty){
                      showCustomSnackBar("tag_is_empty".tr);
                    }else{
                      Get.back();
                      if(update){
                        tagController.editQuestionBankTag(name,  widget.item!.id!);
                      }else{
                        tagController.createQuestionBankTag(name);
                      }

                    }
                  }, text: update? "update".tr : "save".tr))
            ],),
          );
        }
    );
  }
}
