import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/feature/question_bank/question_bank_sources/domain/model/question_bank_sources_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_sources/logic/question_bank_sources_controller.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';


class CreateNewQuestionBankSourceWidget extends StatefulWidget {
  final QuestionBankSourcesItem? item;
  const CreateNewQuestionBankSourceWidget({super.key, this.item});

  @override
  State<CreateNewQuestionBankSourceWidget> createState() => _CreateNewQuestionBankSourceWidgetState();
}

class _CreateNewQuestionBankSourceWidgetState extends State<CreateNewQuestionBankSourceWidget> {
  TextEditingController nameController = TextEditingController();
  bool update = false;
  @override
  void initState() {
    if(widget.item != null){
      update = true;
      nameController.text = widget.item?.sourceName??'';
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionBankSourcesController>(
        builder: (sourcesController) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  child: CustomTitle(title: update?  "update_source".tr : "add_new_source".tr, leftPadding: 0, webTitle: ResponsiveHelper.isDesktop(context))),

              CustomTextField(title: "source_name".tr,
                controller: nameController,
                hintText: "enter_source_name".tr,),



              sourcesController.isLoading? const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Center(child: CircularProgressIndicator())):
              Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  child: CustomButton(onTap: (){
                    String name = nameController.text.trim();
                    if(name.isEmpty){
                      showCustomSnackBar("name_is_empty".tr);
                    }else{
                      Get.back();
                      if(update){
                        sourcesController.editQuestionBankSources(name,  widget.item!.id!);
                      }else{
                        sourcesController.createQuestionBankSources(name).then((val){
                          if(val.statusCode == 200){
                            nameController.clear();
                          }
                        });
                      }

                    }
                  }, text: update? "update".tr : "save".tr))
            ],),
          );
        }
    );
  }
}
