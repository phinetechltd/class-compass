import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/feature/question_bank/question_bank_sources/domain/model/question_bank_sources_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_sources/logic/question_bank_sources_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_sources/presentation/widgets/select_question_bank_source_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_sub_sources/domain/model/question_bank_sub_sources_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_sub_sources/logic/question_bank_sub_sources_controller.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';


class CreateNewQuestionBankSubSourceWidget extends StatefulWidget {
  final QuestionBankSubSourceItem? item;
  const CreateNewQuestionBankSubSourceWidget({super.key, this.item});

  @override
  State<CreateNewQuestionBankSubSourceWidget> createState() => _CreateNewQuestionBankSubSourceWidgetState();
}

class _CreateNewQuestionBankSubSourceWidgetState extends State<CreateNewQuestionBankSubSourceWidget> {
  TextEditingController nameController = TextEditingController();
  bool update = false;
  @override
  void initState() {
    if(widget.item != null){
      update = true;
      nameController.text = widget.item?.subSourceName??'';
      Get.find<QuestionBankSourcesController>().setQuestionBankSourcesItem(QuestionBankSourcesItem(id: widget.item?.sourceId, sourceName: widget.item?.sourceName), notify: false);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionBankSubSourcesController>(
        builder: (subSourcesController) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  child: CustomTitle(title: update?  "update_sub_source".tr : "add_new_sub_source".tr, leftPadding: 0, webTitle: ResponsiveHelper.isDesktop(context))),

              CustomTextField(title: "sub_source_name".tr,
                controller: nameController,
                hintText: "enter_sub_source_name".tr,),

              const QuestionBankSelectSourceWidget(),



              subSourcesController.isLoading? const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Center(child: CircularProgressIndicator())):
              Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  child: CustomButton(onTap: (){
                    String name = nameController.text.trim();
                    int ? sourceId = Get.find<QuestionBankSourcesController>().selectedQuestionBankSourcesItem?.id;
                    if(name.isEmpty){
                      showCustomSnackBar("name_is_empty".tr);
                    }
                    else if(sourceId == null){
                      showCustomSnackBar("source_is_empty".tr);
                    }
                    else{
                      Get.back();
                      if(update){
                        subSourcesController.editQuestionBankSubSources(name, sourceId,  widget.item!.id!);
                      }else{
                        subSourcesController.createQuestionBankSubSources(name, sourceId).then((val){
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
