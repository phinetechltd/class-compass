import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/common/widget/custom_title.dart';
import 'package:class_compass/feature/question_bank/question_bank_chapter/logic/question_bank_chapter_controller.dart';
import 'package:class_compass/feature/question_bank/question_bank_chapter/presentation/widgets/select_question_bank_chapter_widget.dart';
import 'package:class_compass/feature/question_bank/question_bank_level/domain/model/question_bank_level_model.dart';
import 'package:class_compass/feature/question_bank/question_bank_level/logic/question_bank_level_controller.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';


class CreateNewQuestionBankLevelWidget extends StatefulWidget {
  final QuestionBankLevelItem? item;
  const CreateNewQuestionBankLevelWidget({super.key, this.item});

  @override
  State<CreateNewQuestionBankLevelWidget> createState() => _CreateNewQuestionBankLevelWidgetState();
}

class _CreateNewQuestionBankLevelWidgetState extends State<CreateNewQuestionBankLevelWidget> {
  TextEditingController nameController = TextEditingController();
  bool update = false;
  @override
  void initState() {
    if(widget.item != null){
      update = true;
      nameController.text = widget.item?.levelName??'';
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionBankLevelController>(
        builder: (levelController) {
          return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  child: CustomTitle(title: update?  "update_level".tr : "add_new_level".tr, leftPadding: 0, webTitle: ResponsiveHelper.isDesktop(context))),

              CustomTextField(title: "level_name".tr,
                controller: nameController,
                hintText: "enter_level_name".tr,),

              const SizedBox(height: Dimensions.paddingSizeDefault),
              QuestionBankSelectChapterWidget(title: "select_chapter".tr),



              levelController.isLoading? const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Center(child: CircularProgressIndicator())):
              Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  child: CustomButton(onTap: (){
                    String name = nameController.text.trim();
                    int? chapterId = Get.find<QuestionBankChapterController>().selectChapterItem?.id;
                    if(name.isEmpty){
                      showCustomSnackBar("name_is_empty".tr);
                    }
                    else if(chapterId == null){
                      showCustomSnackBar("chapter_is_empty".tr);
                    }
                    else{
                      if(update){
                        levelController.editQuestionBankLevel(name, chapterId,  widget.item!.id!);
                      }else{
                        levelController.createQuestionBankLevel(name, chapterId).then((val){
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
